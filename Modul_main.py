import BasicFunction
from modul_condition import standard_act_cond, wind_pressure, seismic_condition
from modul_object import PoleObject, DirectObject, OhwObject
from modul_calculation import CalcLoadPerSection
# 
# --------Execution with dummy data input---------
# Condition data
d_st = 3
adc = 2
hstr = 14.84
vo = 60

condition = standard_act_cond(
    d_st=d_st,
    adc=adc,
    hstr=hstr,
)

q_wp = wind_pressure(
    d_st=d_st,
    adc=adc,
    hstr=hstr,
    vo=vo
)

seismic_factor = seismic_condition(
    position="ground",
    k_value=0.5
)

# seismic_factor = seismic_condition(
#     position="Rooftop",
#     seismic_class="B"
# )

# Object data
#Create a object for Direct Object
DO1 = DirectObject("Lighting", 0.2, 1, 10, 8, q_wp)
DO2 = DirectObject("Box", 0.3, 1.2, 15, 5, q_wp)

#Create Object for Pole
Pole1 = PoleObject("Pole1", 165.2, 4.5,"STK400", 14.84, q_wp)
Pole2 = PoleObject("Pole2", 190.7, 5.5,"STK540", 9.69, q_wp)
Pole3 = PoleObject("Pole3", 216.3, 7,"STK540", 4, q_wp)

#Create Object for Overhead Wire
HW1 = OhwObject("OHW1", 0.125, 10, 10, 3, 1, 0, 0, 7, q_wp)


#Create List of object
objects = [
    DO1,
    DO2,
    Pole1,
    Pole2,
    Pole3
]

#height evaluation input
h_eval = {
    "h_eval_1": 9.69,
    "h_eval_2": 4,
    "h_eval_3": 0,
}

# Create object to utilize the windload
windload_calc = CalcLoadPerSection(
    objects=objects,
    condition=condition,
)

# 
for name, h in h_eval.items():
    print(f"\n{name}")

    windload_results = windload_calc.get_windloads(h)
    stress_result = windload_calc.bending_stress(h)
    safety_ratio = windload_calc.safety_factor(h)

    for obj, load, moment in windload_results:
        print(f"  {obj.name}")
        print(f"    Windload : {load:.2f} N")
        print(f"    Moment   : {moment:.2f} Nm")

    total = windload_calc.get_total_load(h)

    print(f"  TOTAL LOAD   : {total['total_windload']:.2f} N")
    print(f"  TOTAL MOMENT : {total['total_moment']:.2f} Nm")
    print(f"  Stress Result : {stress_result:.2f} N/mm^2")
    print(f"  Safety Factor : {safety_ratio:.3f}")
