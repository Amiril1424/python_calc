"""Immutable result objects returned by the calculation engine."""

from dataclasses import dataclass

from domain.pole import PoleSectionProperties


@dataclass(frozen=True)
class PoleActiveGeometry:
    """Geometry of one pole segment above an evaluated position."""

    pole_name: str
    evaluated_position_m: float
    segment_bottom_m: float
    segment_top_m: float
    active_bottom_m: float
    active_top_m: float
    full_length_m: float
    active_length_m: float
    diameter_at_active_bottom_mm: float
    diameter_at_active_top_mm: float
    local_load_center_m: float
    lever_arm_m: float


@dataclass(frozen=True)
class PoleCalculationResult:
    """Calculated response of one pole segment at an evaluated position."""

    geometry: PoleActiveGeometry
    section_properties: PoleSectionProperties
    nnc: float
    kz: float
    cf: float
    wind_pressure_n_m2: float
    projected_area_m2: float
    mass_kg: float
    overdesign_factor: float
    fix_load_n: float
    wind_load_n: float
    seismic_load_n: float
    wind_moment_nm: float
    seismic_moment_nm: float
    directional_results: tuple["PoleDirectionalResult", ...] = ()


@dataclass(frozen=True)
class PoleDirectionalResult:
    """Signed pole force and moment components for one wind direction."""

    direction: str
    angle_rad: float
    wind_load_x_n: float
    wind_load_y_n: float
    wind_moment_x_nm: float
    wind_moment_y_nm: float


@dataclass(frozen=True)
class PoleDirectionalTotal:
    """Aggregated signed wind response for one direction."""

    direction: str
    angle_rad: float
    total_wind_load_n: float
    total_wind_load_x_n: float
    total_wind_load_y_n: float
    total_wind_moment_x_nm: float
    total_wind_moment_y_nm: float


@dataclass(frozen=True)
class PoleAggregationResult:
    """Aggregated pole response at one EvaluatedPosition."""

    evaluated_position_m: float
    pole_results: tuple[PoleCalculationResult, ...]
    total_fix_load_n: float
    total_seismic_load_n: float
    total_seismic_moment_nm: float
    directional_totals: tuple[PoleDirectionalTotal, ...]


@dataclass(frozen=True)
class CalculationResult:
    """Top-level engine result; details will grow with later object phases."""

    evaluated_position_m: float
    pole_results: tuple[PoleCalculationResult, ...] = ()

