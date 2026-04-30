import BasicFunction
# import LoadObject_1c
from LoadObject_1c import PoleObject, DirectObject, CalcLoadPerSection

# --------Execution with dummy data---------
#Create a object for Direct Object
DO1 = DirectObject("Lighting", 0.2, 1, 10, 8)
DO2 = DirectObject("Box", 0.3, 1.2, 15, 5)

#Create Object for Pole
Pole1 = PoleObject("Pole1", 165.2, 4.5,"STK400", 14.84)
Pole2 = PoleObject("Pole2", 190.7, 5.3,"STK400", 9.69)
Pole3 = PoleObject("Pole3", 216.3, 4.5,"STK400", 4)


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
    "section_1": 9.69,
    "section_2": 4,
    "section_3": 0,
}

# Create object to utilize the windload
windload_calc = CalcLoadPerSection(objects)

# 
for name, h in sections.items():
    print(f"\n{name}")

    results = windload_calc.get_windloads(h)

    for obj, load, moment in results:
        print(f"  {obj.name}")
        print(f"    Windload : {load:.2f} N")
        print(f"    Moment   : {moment:.2f} Nm")

    total = windload_calc.get_total_load(h)

    print(f"  TOTAL LOAD   : {total['total_windload']:.2f} N")
    print(f"  TOTAL MOMENT : {total['total_moment']:.2f} Nm")