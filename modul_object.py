#Import basic function from BasicFunction modul
import BasicFunction
from BasicFunction import PI
from modul_condition import wind_pressure


###Class Object for Calculation for Load Calculation
#Class as Parent Class which contain general property (windload and moment)
class LoadObject:
    # Get wind pressure value from modul condition based on standard input

    gravity = 9.80665

    def __init__(self, name, cf, weight, q_wp):
        self.name = name
        self.cf = cf
        self.weight = weight
        self.q_wp = q_wp
    
    def calc_fixload(self, weight):
        fixload = weight * self.gravity
        return fixload

    def calc_windload(self, area):
        windload = area * self.cf * self.q_wp
        return windload

    def calc_seismicload(self, weight, k_factor=0.5):
        seismicload = weight * self.gravity * k_factor
        return seismicload

    def calc_moment(self, load, center):
        moment = load * center
        return moment

#Child Class 1 (Inheritance from Object General --> for Direct Object)
class DirectObject(LoadObject):
    def __init__(self, name, area, cf, weight, z_height, q_wp):
        super().__init__(name, cf, weight, q_wp)
        self.area = area
        self.z_height = z_height

    def get_area(self, z_ref=None):
        return self.area
    
    def get_cf(self):
        cf_do = self.cf
        return cf_do
    
#Child Class 2 (Inheritance from Object General --> for Pole as Object)
class PoleObject(LoadObject):
    def __init__(self, name, diameter, thickness, material, z_height, q_wp):
        super().__init__(name, cf=0.7, weight=0, q_wp=q_wp)
        self.diameter = diameter
        self.thickness = thickness
        self.material = material
        self.z_height = z_height

    def get_area(self, length):
        area = self.diameter / 1000 * length
        return area
    
    def get_sect_mod(self):
        sect_mod = round(BasicFunction.Section_Modulus(self.diameter, self.thickness),2)
        return sect_mod

#Child Class 3 (Inheritance from Object General --> for OHW as Object)
class OhwObject(LoadObject):
    def __init__(self, name, weight, diameter, span, sagging_r, cf, fix_ang, vert_ang, z_height, q_wp):
        super().__init__(name, cf=1, weight=0, q_wp=q_wp)
        self.diameter = diameter
        self.span = span
        self.sagging_r = sagging_r
        self.fix_ang = fix_ang
        self.vert_ang = vert_ang
        self.z_height = z_height
    
    def get_area(self):
        area = round(self.diameter / 1000 * self.span, 3)
        return area

    def get_cf(self):
        cf_ohw = self.cf
        return cf_ohw

    # def get_angle_attack(self):
    #     """AoA = ((aof / 180) * phi - AoW)"""
    #     angle_attack = ((self.fix_ang / 180) * PI - )
