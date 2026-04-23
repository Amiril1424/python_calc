#Import basic function from BasicFunction modul
import BasicFunction


###Class Object for Calculation windload
class LoadGeneralObject:
    q_wp = 2214
    gravity = 9.80665

    def __init__(self, name, area_Front, area_Side, cf, weight, center_height):
        #Take data from outer of class
        self.name = name
        self.area_Front = area_Front
        self.area_Side = area_Side
        self.cf = cf
        self.weight = weight
        self.center_height = center_height

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
    
    def calc_moment(self, z_ref):
        moment_obj = self.center_height * self.calc_windload_Front(z_ref)
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
        #Call ___init___ from parent class to put or read the data
        super().__init__(
            name = nama_DO,
            area_Front = Area_Front_DO,
            area_Side = Area_Side_DO,
            cf = Cf_Do,
            weight = Weight_DO,
            z_height = z_height_DO
        )
    
    def calc_center_height(self, z_ref):
        center_height = self.z_height - z_ref
        return center_height
        
#Child Class 2 
class PoleObject(LoadGeneralObject):
    def __init__(self, nama_pole, diameter_po, thicknes_po, z_height_po):
        
        self.diameter = diameter_po
        self.thickness = thicknes_po

        #Call ___init___ from parent class to put or read the data
        super().__init__(
            name = nama_pole,
            area_Front = 0,         # Placeholder
            area_Side = 0,
            cf = 0.7,
            weight = 0,             # Placeholder
            z_height = z_height_po
        )

    #Calculate Length of pole
    def get_length(self, z_ref):
        if self.z_height <= z_ref:
            return 0
        return self.z_height - z_ref
        
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
        
    #calculate center height of pole for moment calculation
    def calc_center_point(self, z_ref=None):
        length = self.get_length(z_ref)
        center_point = round(length / 2, 3)
        return center_point
    
    #Calculate Length center of pole
    def calc_length_center(self, z_ref):
        length = self.get_length(z_ref=None)
        center_point = self.center_point(z_ref)
        length_center = round(center_point + self.z_height - length - z_ref, 3)
        return length_center



#Calculate total Load per section
def total_load_at_section(objects, h_section):
    total_windload = 0

    for obj in objects:
        if obj.z_height >= h_section:
            total_windload += obj.calc_windload_Front() #----> total = total + windload

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
    DO1,
    DO2,
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


# Get Output
for name, h in sections.items():
    windLoad_total = total_load_at_section(objects, h)
    moment_total = moment_at_section(objects, h)

    print(f"\n{name}")
    print(f"  windload : {windLoad_total:.2f} N")
    print(f"  Moment : {moment_total:.2f} N")


for name, h in sections.items():
    print(f"\n{name}")

    for obj in objects:
        #Only print PoleObject
        if isinstance(obj, PoleObject):
            length = obj.get_length(h)
            print(f"  {obj.name} length: {length:.2f} m")












#Run display function to see the result
# DO1.displayResult()
# DO2.displayResult()
# Pole1.displayResult()
# Pole2.displayResult()
# Pole3.displayResult()