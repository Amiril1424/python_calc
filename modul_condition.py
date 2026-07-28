#Import basic function from BasicFunction modul
import BasicFunction
from BasicFunction import PI

def std_act_common(adc: int, hstr: float):
    # -----------------------------
    # Determine zb, zg, alpha
    # -----------------------------
    if adc == 1:
        zb = 5
        zg = 250
        aha = 0.1
        adc_sym = "I"

    elif adc == 2:
        zb = 5
        zg = 350
        aha = 0.15
        adc_sym = "II"

    elif adc == 3:
        zb = 5
        zg = 450
        aha = 0.2
        adc_sym = "III"

    elif adc == 4:
        zb = 10
        zg = 550
        aha = 0.27
        adc_sym = "IV"

    else:
        raise ValueError("ADC is not recognized")

    # -----------------------------
    # Calculate Gust Factor (Gf)
    # -----------------------------
    if adc == 1:
        if hstr <= 10:
            gf = 2

        elif hstr < 40:
            gf = (-0.2 / 30) * (hstr - 10) + 2

        else:
            gf = 1.8

    elif adc == 2:
        if hstr <= 10:
            gf = 2.2

        elif hstr < 40:
            gf = (-0.2 / 30) * (hstr - 10) + 2.2

        else:
            gf = 2

    elif adc == 3:
        if hstr <= 10:
            gf = 2.5

        elif hstr < 40:
            gf = (-0.4 / 30) * (hstr - 10) + 2.5

        else:
            gf = 2.1

    elif adc == 4:
        if hstr <= 10:
            gf = 3.1

        elif hstr < 40:
            gf = (-0.8 / 30) * (hstr - 10) + 3.1

        else:
            gf = 2.3

    gf = round(gf, 3)

    # -----------------------------
    # Calculate Height Distribution (Er)
    # -----------------------------
    if hstr <= zb:
        er_act = 1.7 * (zb / zg) ** aha

    else:
        er_act = 1.7 * (hstr / 350) ** aha

    er_act = round(er_act, 3)

    # -----------------------------
    # Calculate Density of Air
    # -----------------------------
    ds_air = (er_act ** 2) * gf
    ds_air = round(ds_air, 3)

    # -----------------------------
    # Return Result
    # -----------------------------
    return {
        "Hstr": hstr,
        "zb": zb,
        "zg": zg,
        "alpha": aha,
        "Gf": gf,
        "Er": er_act,
        "Ds_air": ds_air,
        "ADC_symbol": adc_sym,
    }

def standard_act_cond(d_st: int, adc: int, hstr: float):
    """
    Select calculation standard for Building Act Method
    """
    # Building Standards Act
    if d_st == 1:
        result = std_act_common(adc, hstr)

    # Tower Standard
    elif d_st == 6:
        result = std_act_common(adc, hstr)

    else:
        raise ValueError("Standard is not recognized")

    return result


def direct_angle():
    """
    Direction angle of wind
    Unit: radian
    """
    return [
        PI * 2 / 4,   # N
        PI * 6 / 4,   # S
        PI * 0 / 4,   # E
        PI * 4 / 4,   # W
        PI * 1 / 4,   # NE
        PI * 5 / 4,   # SW
        PI * 3 / 4,   # NW
        PI * 7 / 4,   # SE
    ]


# Function for wind pressure value base on standard condition
def wind_pressure(d_st, adc=None, hstr=None, z=None, vo=None):

    """
    Calculate Wind Pressure
    Unit: N/m²
    """

    # Building Standard Act
    if d_st == 1:
        act_common = standard_act_cond(d_st, adc, hstr)
        
        ds_air = act_common["Ds_air"]
        q_wpr = round(0.6 * ds_air * (vo ** 2), 3)

    # Standard 2 & 3
    elif d_st in [2, 3]:
        ds_air = 1.23
        vo = 60
        q_wpr = round(0.5 * ds_air * (vo ** 2), 4)

    # Standard 4
    elif d_st == 4:
        ds_air = 1.23
        vo = 40
        q_wpr = round(0.5 * ds_air * (vo ** 2), 3)

    # Standard 5
    elif d_st == 5:
        ds_air = 1.23
        vo = 50
        q_wpr = round(0.5 * ds_air * (vo ** 2), 3)

    # Tower Standard
    # elif d_st == 6:
    #     kz = f_kz(z)
    #     ds_air = act_comn["Ds_air"]
    #     q_wpr = round(0.6 * ds_air * (vo ** 2), 3)
    #     q_b_kz = q_wpr * 1.42 * kz
    #     if q_b_kz > 2350:
    #         q_wpr = round(q_b_kz, 3)
    #     else:
    #         q_wpr = 2350

    else:
        raise ValueError("Standard is not recognized")

    return q_wpr