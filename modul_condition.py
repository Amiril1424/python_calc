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

    # Tambahkan design standard ke dictionary hasil.
    result["d_st"] = d_st

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


def calc_kz(z_height: float, hstr: float, zb: float, alpha: float) -> float:
    """
    Calculate the height correction factor (Kz) .

    Parameters use metres for ``z_ob``, ``hstr``, and ``zb``.
    """
    try:
        z_height = float(z_height)
        hstr = float(hstr)
        zb = float(zb)
        alpha = float(alpha)
    except (TypeError, ValueError):
        raise ValueError("Kz parameters must be numbers") from None

    if z_height < 0:
        raise ValueError("Object height (z_height) cannot be negative")
    if hstr <= 0:
        raise ValueError("Structure height (hstr) must be greater than zero")
    if zb <= 0:
        raise ValueError("zb must be greater than zero")
    if alpha < 0:
        raise ValueError("alpha cannot be negative")

    if hstr <= zb:
        kz = 1.0
    elif z_height <= zb:
        kz = (zb / hstr) ** (2 * alpha)
    else:
        kz = (z_height / hstr) ** (2 * alpha)

    return round(kz, 3)


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

        if vo is None:
            vo = 60

        q_wpr = round(0.5 * ds_air * (vo ** 2), 4)

    # Standard 4
    elif d_st == 4:
        ds_air = 1.23

        if vo is None:
            vo = 40

        q_wpr = round(0.5 * ds_air * (vo ** 2), 3)

    # Standard 5
    elif d_st == 5:
        ds_air = 1.23

        if vo is None:
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

# Function for seismic condition
def seismic_condition(position: str, k_value=None, seismic_class=None):
    """
    Determine the seismic K value based on the position of the pole.

    Parameters
    ----------
    position : str
        Pole position: ``"Ground"`` or ``"Rooftop"``.
    k_value : float, optional
        K value entered by the user. This is required only for a pole at
        ground position.
    seismic_class : str, optional
        Rooftop seismic class: ``"A"``, ``"B"``, or ``"S"``.

    Returns
    -------
    dict
        Pole position, seismic class, and its K value.
    """
    if not isinstance(position, str):
        raise ValueError("Position of pole must be 'Ground' or 'Rooftop'")

    normalized_position = position.strip().lower()

    if normalized_position == "ground":
        if k_value is None:
            raise ValueError("K value is required for a pole at ground position")

        try:
            selected_k_value = float(k_value)
        except (TypeError, ValueError):
            raise ValueError("K value must be a number") from None

        if selected_k_value <= 0:
            raise ValueError("K value must be greater than zero")

        return {
            "position": "Ground",
            "seismic_class": None,
            "K_value": selected_k_value,
        }

    if normalized_position == "rooftop":
        if not isinstance(seismic_class, str):
            raise ValueError(
                "Seismic class A, B, or S is required for a pole at rooftop"
            )

        normalized_class = seismic_class.strip().upper()
        rooftop_k_values = {
            "A": 1.5,
            "B": 1.0,
            "S": 2.0,
        }

        if normalized_class not in rooftop_k_values:
            raise ValueError("Seismic class must be A, B, or S")

        return {
            "position": "Rooftop",
            "seismic_class": normalized_class,
            "K_value": rooftop_k_values[normalized_class],
        }

    raise ValueError("Position of pole must be 'Ground' or 'Rooftop'")
