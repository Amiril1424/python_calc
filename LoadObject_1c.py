#Import basic function from BasicFunction modul
import BasicFunction

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

###Class Object for Calculation for Load Calculation
#Class as Parent Class which contain general property (windload and moment)
class LoadObject:
    q_wp = 2214
    gravity = 9.80665

    def __init__(self, name, cf, weight):
        self.name = name
        self.cf = cf
        self.weight = weight

    def calc_windload(self, area):
        windload = area * self.cf * self.q_wp
        return windload

    def calc_moment(self, load, center):
        moment = load * center
        return moment

#Child Class 1 (Inheritance from Object General --> for Direct Object)
class DirectObject(LoadObject):
    def __init__(self, name, area, cf, weight, z_height):
        super().__init__(name, cf, weight)
        self.area = area
        self.z_height = z_height

    def get_area(self, z_ref=None):
        return self.area
    
#Child Class 2 (Inheritance from Object General --> for Pole as Object)
class PoleObject(LoadObject):
    def __init__(self, name, diameter, thickness, material, z_height):
        super().__init__(name, cf=0.7, weight=0)
        self.diameter = diameter
        self.thickness = thickness
        self.material = material
        self.z_height = z_height

    def get_area(self, length):
        area = self.diameter / 1000 * length
        return area
    

class CalcLoadPerSection:
    def __init__(self, objects):
        self.objects = objects
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
            
            windload = obj.calc_windload(area)
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





    


    
