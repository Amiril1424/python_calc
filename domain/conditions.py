"""Wind and seismic conditions used by the calculation engine."""

from dataclasses import dataclass
from math import pi

from modul_condition import calc_kz, std_act_common


@dataclass(frozen=True)
class WindDirection:
    """Named wind direction and its angle in radians."""

    name: str
    angle_rad: float


WIND_DIRECTIONS: tuple[WindDirection, ...] = (
    WindDirection("N", pi * 2 / 4),
    WindDirection("S", pi * 6 / 4),
    WindDirection("E", pi * 0 / 4),
    WindDirection("W", pi * 4 / 4),
    WindDirection("NE", pi * 1 / 4),
    WindDirection("SW", pi * 5 / 4),
    WindDirection("NW", pi * 3 / 4),
    WindDirection("SE", pi * 7 / 4),
)


class WindCondition:
    """Wind condition implementing the confirmed rules for standards 1-6."""

    def __init__(
        self,
        design_standard: int,
        structure_height_m: float,
        atmospheric_category: int | None = None,
        basic_wind_speed_m_s: float | None = None,
    ) -> None:
        self.design_standard = int(design_standard)
        self.structure_height_m = float(structure_height_m)
        self.atmospheric_category = atmospheric_category
        self.basic_wind_speed_m_s = basic_wind_speed_m_s
        self._validate()

        self._common = None
        if self.design_standard in (1, 6):
            self._common = std_act_common(
                adc=self.atmospheric_category,
                hstr=self.structure_height_m,
            )

    def _validate(self) -> None:
        if self.design_standard not in {1, 2, 3, 4, 5, 6}:
            raise ValueError("Wind design standard must be between 1 and 6")
        if self.structure_height_m <= 0:
            raise ValueError("Structure height must be greater than zero")
        if self.design_standard in (1, 6):
            if self.atmospheric_category not in {1, 2, 3, 4}:
                raise ValueError(
                    "Atmospheric category 1-4 is required for standard 1 or 6"
                )
            if (
                self.basic_wind_speed_m_s is None
                or self.basic_wind_speed_m_s <= 0
            ):
                raise ValueError(
                    "Basic wind speed is required for standard 1 or 6"
                )

    @property
    def directions(self) -> tuple[WindDirection, ...]:
        return WIND_DIRECTIONS

    @property
    def common_parameters(self) -> dict | None:
        return None if self._common is None else dict(self._common)

    def kz_at(self, top_elevation_m: float) -> float:
        """Return Kz at the top elevation of an individual pole segment."""
        if self.design_standard not in (1, 6):
            return 1.0
        return calc_kz(
            z_height=top_elevation_m,
            hstr=self.structure_height_m,
            zb=self._common["zb"],
            alpha=self._common["alpha"],
        )

    def wind_pressure_at(self, top_elevation_m: float) -> float:
        """Return pole wind pressure in N/m2 according to the VBA rules."""
        standard = self.design_standard
        if standard == 1:
            return round(
                0.6 * self._common["Ds_air"] * self.basic_wind_speed_m_s**2,
                3,
            )
        if standard in (2, 3):
            return round(0.5 * 1.23 * 60**2, 4)
        if standard == 4:
            return round(0.5 * 1.23 * 40**2, 3)
        if standard == 5:
            return round(0.5 * 1.23 * 50**2, 3)

        kz = self.kz_at(top_elevation_m)
        base_pressure = round(
            0.6 * self._common["Ds_air"] * self.basic_wind_speed_m_s**2,
            3,
        )
        pressure_with_kz = base_pressure * 1.42 * kz
        return round(pressure_with_kz, 3) if pressure_with_kz > 2350 else 2350.0


class SeismicCondition:
    """Seismic condition currently supplied as a dimensionless K value."""

    ROOFTOP_K_VALUES = {"A": 1.5, "B": 1.0, "S": 2.0}

    def __init__(
        self,
        position: str,
        k_value: float,
        seismic_class: str | None = None,
    ) -> None:
        normalized_position = position.strip().title()
        if normalized_position not in {"Ground", "Rooftop"}:
            raise ValueError("Position must be 'Ground' or 'Rooftop'")
        if k_value <= 0:
            raise ValueError("Seismic K value must be greater than zero")

        self.position = normalized_position
        self.k_value = float(k_value)
        self.seismic_class = seismic_class

    @classmethod
    def ground(cls, k_value: float) -> "SeismicCondition":
        return cls(position="Ground", k_value=k_value)

    @classmethod
    def rooftop(cls, seismic_class: str) -> "SeismicCondition":
        normalized_class = seismic_class.strip().upper()
        try:
            k_value = cls.ROOFTOP_K_VALUES[normalized_class]
        except KeyError:
            raise ValueError("Seismic class must be A, B, or S") from None
        return cls("Rooftop", k_value, normalized_class)

