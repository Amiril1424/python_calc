"""Complete load calculation for assembled pole segments."""

from math import cos, pi, sin
from math import fsum

from .pole_assembly import PoleAssembly
from .result import (
    PoleAggregationResult,
    PoleCalculationResult,
    PoleDirectionalResult,
    PoleDirectionalTotal,
)
from domain.conditions import SeismicCondition, WindCondition
from domain.loads import OverdesignFactor
from domain.pole import PoleObject


class PoleCalculator:
    """Calculate pole loads at one EvaluatedPosition."""

    def __init__(
        self,
        assembly: PoleAssembly,
        wind_condition: WindCondition,
        seismic_condition: SeismicCondition,
        overdesign_factor: OverdesignFactor | None = None,
    ) -> None:
        self.assembly = assembly
        self.wind_condition = wind_condition
        self.seismic_condition = seismic_condition
        self.overdesign_factor = overdesign_factor or OverdesignFactor()

    def calculate_one(
        self,
        pole: PoleObject,
        evaluated_position_m: float,
    ) -> PoleCalculationResult:
        geometry = self.assembly.active_geometry(pole, evaluated_position_m)
        if geometry.active_length_m <= 0:
            raise ValueError(
                f"Pole {pole.name!r} is not active above the evaluated position"
            )

        diameter_bottom = geometry.diameter_at_active_bottom_mm
        diameter_top = geometry.diameter_at_active_top_mm
        nnc = pole.base_wind_coefficient(
            geometry.active_length_m,
            diameter_bottom,
        )
        kz = self.wind_condition.kz_at(pole.top_elevation_m)
        cf = pole.wind_coefficient(
            geometry.active_length_m,
            diameter_bottom,
            self.wind_condition.design_standard,
            kz,
        )
        wind_pressure = self.wind_condition.wind_pressure_at(
            pole.top_elevation_m
        )
        projected_area = pole.projected_area(
            geometry.active_length_m,
            diameter_bottom,
            diameter_top,
        )
        mass = pole.mass_kg(
            geometry.active_length_m,
            diameter_bottom,
            diameter_top,
        )
        fix_load = pole.fix_load_n(
            geometry.active_length_m,
            diameter_bottom,
            diameter_top,
            self.overdesign_factor,
        )
        wind_load = pole.calculate_wind_load(
            projected_area,
            cf,
            wind_pressure,
        )
        seismic_load = fix_load * self.seismic_condition.k_value
        wind_moment = pole.calculate_moment(wind_load, geometry.lever_arm_m)
        seismic_moment = pole.calculate_moment(
            seismic_load,
            geometry.lever_arm_m,
        )
        directional_results = tuple(
            self._directional_result(
                wind_load,
                geometry.lever_arm_m,
                direction.name,
                direction.angle_rad,
            )
            for direction in self.wind_condition.directions
        )

        return PoleCalculationResult(
            geometry=geometry,
            section_properties=pole.section_properties(diameter_bottom),
            nnc=nnc,
            kz=kz,
            cf=cf,
            wind_pressure_n_m2=wind_pressure,
            projected_area_m2=projected_area,
            mass_kg=mass,
            overdesign_factor=self.overdesign_factor.value,
            fix_load_n=fix_load,
            wind_load_n=wind_load,
            seismic_load_n=seismic_load,
            wind_moment_nm=wind_moment,
            seismic_moment_nm=seismic_moment,
            directional_results=directional_results,
        )

    def calculate_at(
        self,
        evaluated_position_m: float,
    ) -> tuple[PoleCalculationResult, ...]:
        """Calculate all active pole segments, ordered bottom-up."""
        return tuple(
            self.calculate_one(pole, evaluated_position_m)
            for pole in self.assembly.active_poles(evaluated_position_m)
        )

    def aggregate_at(
        self,
        evaluated_position_m: float,
    ) -> PoleAggregationResult:
        """Aggregate all active pole results at one EvaluatedPosition."""
        pole_results = self.calculate_at(evaluated_position_m)
        directional_totals = tuple(
            self._aggregate_direction(
                pole_results=pole_results,
                direction=direction.name,
                angle_rad=direction.angle_rad,
            )
            for direction in self.wind_condition.directions
        )

        return PoleAggregationResult(
            evaluated_position_m=float(evaluated_position_m),
            pole_results=pole_results,
            total_fix_load_n=fsum(
                result.fix_load_n for result in pole_results
            ),
            total_seismic_load_n=fsum(
                result.seismic_load_n for result in pole_results
            ),
            total_seismic_moment_nm=fsum(
                result.seismic_moment_nm for result in pole_results
            ),
            directional_totals=directional_totals,
        )

    @staticmethod
    def _aggregate_direction(
        pole_results: tuple[PoleCalculationResult, ...],
        direction: str,
        angle_rad: float,
    ) -> PoleDirectionalTotal:
        matching_results = tuple(
            directional
            for pole_result in pole_results
            for directional in pole_result.directional_results
            if directional.direction == direction
        )
        return PoleDirectionalTotal(
            direction=direction,
            angle_rad=angle_rad,
            total_wind_load_n=fsum(
                result.wind_load_n for result in pole_results
            ),
            total_wind_load_x_n=fsum(
                result.wind_load_x_n for result in matching_results
            ),
            total_wind_load_y_n=fsum(
                result.wind_load_y_n for result in matching_results
            ),
            total_wind_moment_x_nm=fsum(
                result.wind_moment_x_nm for result in matching_results
            ),
            total_wind_moment_y_nm=fsum(
                result.wind_moment_y_nm for result in matching_results
            ),
        )

    @staticmethod
    def _directional_result(
        wind_load_n: float,
        lever_arm_m: float,
        direction: str,
        angle_rad: float,
    ) -> PoleDirectionalResult:
        direction_cosine = round(cos(angle_rad + pi), 3)
        direction_sine = round(sin(angle_rad), 3)
        wind_x = wind_load_n * direction_cosine
        wind_y = wind_load_n * direction_sine
        return PoleDirectionalResult(
            direction=direction,
            angle_rad=angle_rad,
            wind_load_x_n=wind_x,
            wind_load_y_n=wind_y,
            wind_moment_x_nm=lever_arm_m * wind_y,
            wind_moment_y_nm=lever_arm_m * wind_x,
        )
