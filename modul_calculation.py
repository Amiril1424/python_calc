#Import basic function from BasicFunction modul
import BasicFunction
from BasicFunction import PI
from modul_object import PoleObject
from modul_object import DirectObject

class GetPoleAssembly:
    def __init__(self, poles):
        # simpan 2 urutan → tidak perlu sort ulang
        self.poles_asc = sorted(poles, key=lambda p: p.z_height)          # bawah → atas
        self.poles_desc = list(reversed(self.poles_asc))                  # atas → bawah
    
    #Calculate Length of pole
    def get_length(self, z_ref):
        result = []
        
        # urutkan pole dari atas ke bawah
        poles = self.poles_desc

        n = len(poles)

        for i, p in enumerate(poles):

            if p.z_height <= z_ref:
                length = 0
            else:
                # ambil batas bawah pole
                if i == n - 1:
                    lower_z = z_ref
                else:
                    lower_z = max(z_ref, poles[i + 1].z_height)

                length = p.z_height - lower_z

            result.append((p, length))

        return result
    
    def get_center_heights(self, z_ref):
        lengths = self.get_length(z_ref)

        result = []
        running_sum = 0  #akumulasi dari bawah

        # loop dari bawah ke atas (reversed)
        for p, length in reversed(lengths):

            if length > 0:
                center = (length / 2) + running_sum
                running_sum += length
            else:
                center = 0

            result.append((p, center))
        
        # balik lagi ke urutan atas --> ke bawah
        result.reverse()

        return result


class CalcLoadPerSection:
    def __init__(self, objects, condition):
        self.objects = objects
        self.condition = condition
        self.assembly = GetPoleAssembly(
            [obj for obj in objects if isinstance(obj, PoleObject)]
        ) # Only pole should be calculate the assembly to calculate center Height
    
    # Calculate length if object is a pole
    def get_lengths(self, z_ref):
        return self.assembly.get_length(z_ref)
    
    # Calculate center height
    def get_centers(self, z_ref):
        """property assembly is specific for pole"""
        return self.assembly.get_center_heights(z_ref)
    
    # Calculate windload 
    def get_windloads(self, z_ref):
        result = []

        lengths = self.assembly.get_length(z_ref)
        centers = self.assembly.get_center_heights(z_ref)

        pole_lengths = dict(lengths)
        pole_centers = dict(centers)

        for obj in self.objects:
            length = None
            
            # Pole as object
            if isinstance(obj, PoleObject):
                length = pole_lengths.get(obj, 0)
                center = pole_centers.get(obj, 0)

                area = obj.get_area(length)

            # Non-Pole --> DO, OHW, Arm
            else:
                if obj.z_height <= z_ref:
                    continue

                area = obj.get_area()
                center = obj.z_height - z_ref
                
            windload = obj.calc_windload(
                area=area,
                d_st=self.condition["d_st"],
                condition=self.condition,
                length=length,
            )
            moment = obj.calc_moment(windload, center)

            result.append((obj, windload, moment))
        
        return result
    
    # Calculate Total Load per section
    def get_total_load(self, z_ref):
        total_windload = 0
        total_moment = 0

        results = self.get_windloads(z_ref)

        for obj, windload, moment in results:
            total_windload += windload
            total_moment += moment

        return {
            "total_windload": total_windload,
            "total_moment": total_moment
        }
    
    # Calculate Bending Stress (Be)
    def bending_stress(self, z_ref):
        """Bending Stress = Total Moment/ Section Modulus"""
        total = self.get_total_load(z_ref)
        total_moment = total["total_moment"]

        #Get active pole which need to calculate the bending stress and get section modulus
        active_poles = [
            obj for obj in self.objects
            if isinstance(obj, PoleObject) and obj.z_height > z_ref
        ]
            
        # If no active pole, tidak ada pole yang dievaluasi
        if not active_poles:
            return 0
        
        # pole paling bawah yang masih aktif
        critical_pole = min(active_poles, key=lambda p: p.z_height)

         # ambil section modulus dari child class PoleObject
        sect_mod = critical_pole.get_sect_mod()

        # convert Nm --> Nmm
        bending_stress = (total_moment) / sect_mod

        return bending_stress
    
    # Calculate Safety Factor
    def safety_factor(self, z_ref):
        """Safety Factor = Bending Stress / Allowable (SFB)"""
        stress = self.bending_stress(z_ref)

         #Get active pole which need to calculate the bending stress and get section modulus
        active_poles = [
            obj for obj in self.objects
            if isinstance(obj, PoleObject) and obj.z_height > z_ref
        ]
            
        # If no active pole, tidak ada pole yang dievaluasi
        if not active_poles:
            return 0
        
        # pole paling bawah yang masih aktif
        critical_pole = min(active_poles, key=lambda p: p.z_height)

        # Get Material Pole
        material = BasicFunction.PoleMaterialClass(critical_pole.material)
        
        # allowable stress
        sfb = material.get("SFB")

        # Safety ratio
        sf = round(stress/sfb, 3)

        return sf
