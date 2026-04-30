#Import basic function from BasicFunction modul
import BasicFunction


###Class Object for Calculation windload
class LoadGeneralObject:
    q_wp = 2214
    gravity = 9.80665

    def __init__(self, name, area_Front, area_Side, cf, weight):
        #Take data from outer of class
        self.name = name
        self.area_Front = area_Front
        self.area_Side = area_Side
        self.cf = cf
        self.weight = weight

    #Create function of calculation
    def calc_Area_Oblique(self):
        """ Area Oblique = area front/2^0.5 + area side / 2^0.5"""
        area_Oblique = (self.area_Front / (2**0.5)) + (self.area_Side / (2**0.5))
        return area_Oblique
    
    def get_area(self, z_ref=None):
        return self.area_Front

    def calc_windload_Front(self, z_ref=None):
        area = self.get_area(z_ref)
        return area * self.cf * self.q_wp
    
    def calc_fixload(self):
        return self.weight * self.gravity
    
    def get_center_height(self, z_ref):
        return 0  # default
    
    def calc_moment(self, z_ref):
        length_center = self.get_center_height(z_ref)
        moment_obj = length_center * self.calc_windload_Front(z_ref)
        return moment_obj
        


    # def displayResult(self):
    #     """Show the result of calculation"""
    #     print(f"---The result of calculation {self.name} ---")
    #     # print(f"Area Oblique : {self.calc_Area_Oblique():.3f} m^2")
    #     print(f"Windload Front : {self.calc_windload_Front():.1f} N")
    #     print(f"Fixload : {self.calc_fixload():.1f} N")

#Child Class 1 (Inheritance from Object General --> for Direct Object)
class DirectObject(LoadGeneralObject):
    def __init__(self, nama_DO, Area_Front_DO, Area_Side_DO, Cf_Do, Weight_DO, z_height_DO):
        self.z_height = z_height_DO

        #Call ___init___ from parent class to put or read the data
        super().__init__(
            name = nama_DO,
            area_Front = Area_Front_DO,
            area_Side = Area_Side_DO,
            cf = Cf_Do,
            weight = Weight_DO,
        )
    
    def get_center_height(self, z_ref):
        center_height_do = self.z_height - z_ref
        return center_height_do
        
#Child Class 2 
class PoleObject(LoadGeneralObject):
    def __init__(self, nama_pole, diameter_po, thicknes_po, z_height_po):
        self.diameter = diameter_po
        self.thickness = thicknes_po
        self.z_height = z_height_po

        #Call ___init___ from parent class to put or read the data
        super().__init__(
            name = nama_pole,
            area_Front = 0,         # Placeholder
            area_Side = 0,
            cf = 0.7,
            weight = 0,             # Placeholder
        )
        
    #Calculate Area based on section height
    def get_area(self, z_ref=None):
        if z_ref is None:
            return 0

        length = self.get_length(z_ref)
        return self.diameter / 1000 * length

    #calculate Weight of pole
    def calc_weight_po(self, z_ref=None):
        if z_ref is None:
            return 0
        
        length = self.get_length(z_ref)
        weight_po = BasicFunction.Pole_WeightKg_Straight(self.diameter, self.thickness,length)
        return  weight_po
    
    #Calculate Length center of pole
    def get_center_height(self, z_ref=None):
        if self.z_height <= z_ref:
            return 0
        
        length = self.get_length(z_ref)
        center_point = round(length / 2, 3)
        z_center = round(z_ref + center_point, 3)
        return z_center
        
#Class to get center length of pole for Moment calculation
#This class handling is like cntcs in VBA
class GetPoleCenterLengthAssembly:
    def __init__(self, poles):
        #sort from bottom to upper (z small to large)
        self.poles = sorted(poles, key=lambda p: p.z_height)

    #Calculate Length of pole
    def get_length(self, z_ref):
        list_length = []
        
        # urutkan pole dari atas ke bawah
        poles_sorted = sorted(self.poles, key=lambda p: p.z_height, reverse=True)

        for i, p in enumerate(poles_sorted):

            if p.z_height <= z_ref:
                length = 0
            else:
                # ambil batas bawah pole
                if i == len(poles_sorted) - 1:
                    lower_z = z_ref
                else:
                    lower_z = max(z_ref, poles_sorted[i + 1].z_height)

                length = p.z_height - lower_z

            list_length.append((p, length))

        return list_length
        
    def get_current_pole_lengths(self, z_ref):
        """Ambil panjang pole aktif berdasarkan section"""
        return self.get_length(z_ref)

    def get_center_heights(self, z_ref):
        lengths = self.get_current_pole_lengths(z_ref)

        result = []
        total_below = 0

        # penting: dari bawah ke atas
        for p, length in lengths:

            if length > 0:
                center =  (length / 2) + z_ref
                # total_below += length
            else:
                center = 0

            result.append((p, center))

        return result











    # def get_center_heights(self, z_ref):
    #     """
    #     Calculate center height relatif with evaluated height:
    #     length acumulation pole in bottom of evaluated height + center point
    #     """
    #     result = []
    #     total_below_section = 0

    #     for pole, length in self.get_current_pole_lengths(z_ref):
    #         if length > 0:
    #             center = total_below_section + (length / 2)
    #             result.append((pole, center))
    #             total_below_section += length
    #         else:
    #             result.append((pole, 0))
        
    #     return result



#Calculate total Load per section
def total_load_at_section(objects, h_section):
    total_windload = 0

    for obj in objects:
        if obj.z_height >= h_section:
            total_windload += obj.calc_windload_Front(h_section) #----> total = total + windload

    return total_windload


#Calculate total moment per section
def moment_at_section(objects, h_section):
    total_moment = 0

    for obj in objects:
        if obj.z_height >= h_section:
            total_moment += obj.calc_moment(h_section)  #-----> total moment per step section
    
    return total_moment
        


#---Execution---
#Create a object for Direct Object
DO1 = DirectObject("Lighting", 0.2, 0.1, 1, 10, 8)
DO2 = DirectObject("Box", 0.3, 0.15, 1.2, 15, 5)

#Create Object for Pole
Pole1 = PoleObject("Pole1", 165.2, 4.5, 9)
Pole2 = PoleObject("Pole2", 190.7, 5.3, 6)
Pole3 = PoleObject("Pole3", 216.3, 4.5, 3)


#Create List of object
objects = [
    # DO1,
    # DO2,
    Pole1,
    Pole2,
    Pole3
]

#Section Height input
sections = {
    "section_1": 6,
    "section_2": 3,
    "section_3": 0,
}

poles = [obj for obj in objects if isinstance(obj, PoleObject)]

assembly = GetPoleCenterLengthAssembly(poles)

for name, h in sections.items():
    print(f"\n{name}")

    centers = assembly.get_center_heights(h)

    for pole, center in centers:
        print(f"    {pole.name} center height pole: {center:.2f} m")















# Get Output
# for name, h in sections.items():
#     windLoad_total = total_load_at_section(objects, h)
#     moment_total = moment_at_section(objects, h)

#     print(f"\n{name}")
#     print(f"  windload : {windLoad_total:.2f} N")
#     print(f"  Moment : {moment_total:.2f} N")


# for name, h in sections.items():
#     print(f"\n{name}")

#     for obj in objects:
#         #Only print PoleObject
#         if isinstance(obj, PoleObject):
#             center_h = obj.get_center_height(h)
#             print(f"  {obj.name} center height pole: {center_h:.2f} m")












#Run display function to see the result
# DO1.displayResult()
# DO2.displayResult()
# Pole1.displayResult()
# Pole2.displayResult()
# Pole3.displayResult()