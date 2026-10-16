"""Load calculation and aggregation for Direct Objects."""

from collections.abc import Iterable
from math import cos, fsum, pi, sin

from domain.conditions import SeismicCondition, WindCondition
from domain.direct_object import DirectObject

from .result import (
    DirectObjectAggregationResult,
    DirectObjectCalculationResult,
    DirectObjectDirectionalResult,
    DirectObjectDirectionalTotal,
)


class DirectObjectCalculator:
    """Calculate Direct Objects at one EvaluatedPosition."""

    def __init__(
        self,
        direct_objects: Iterable[DirectObject],
        wind_condition: WindCondition,
        seismic_condition: SeismicCondition,
    ) -> None:
        self.direct_objects = tuple(direct_objects)
        if any(
            not isinstance(direct_object, DirectObject)
            for direct_object in self.direct_objects
        ):
            raise TypeError(
                "DirectObjectCalculator accepts only DirectObject instances"
            )
        self.wind_condition = wind_condition
        self.seismic_condition = seismic_condition

    def active_objects(
        self,
        evaluated_position_m: float,
    ) -> tuple[DirectObject, ...]:
        """Return objects at or above the EvaluatedPosition, per VBA."""
        return tuple(
            direct_object
            for direct_object in self.direct_objects
            if direct_object.elevation_m >= evaluated_position_m
        )

    def calculate_one(
        self,
        direct_object: DirectObject,
        evaluated_position_m: float,
    ) -> DirectObjectCalculationResult:
        if direct_object.elevation_m < evaluated_position_m:
            raise ValueError(
                f"Direct Object {direct_object.name!r} is below "
                "the EvaluatedPosition"
            )

        load_center_height = direct_object.load_center_height_m(
            evaluated_position_m
        )
        kz = self.wind_condition.kz_at(direct_object.elevation_m)
        cf = direct_object.wind_coefficient(
            design_standard=self.wind_condition.design_standard,
            kz=kz,
        )
        wind_pressure = self.wind_condition.wind_pressure_at(
            direct_object.elevation_m
        )
        fix_load = direct_object.fix_load_n()
        seismic_load = direct_object.calculate_seismic_load(
            fix_load_n=fix_load,
            k_value=self.seismic_condition.k_value,
        )
        seismic_moment = direct_object.calculate_moment(
            seismic_load,
            load_center_height,
        )
        directional_results = tuple(
            self._directional_result(
                direct_object=direct_object,
                direction=direction.name,
                wind_angle_rad=direction.angle_rad,
                cf=cf,
                wind_pressure_n_m2=wind_pressure,
                load_center_height_m=load_center_height,
            )
            for direction in self.wind_condition.directions
        )

        return DirectObjectCalculationResult(
            object_name=direct_object.name,
            object_type=direct_object.object_type.value,
            evaluated_position_m=float(evaluated_position_m),
            elevation_m=direct_object.elevation_m,
            load_center_height_m=load_center_height,
            quantity=direct_object.quantity,
            mass_per_unit_kg=direct_object.mass_per_unit_kg,
            total_mass_kg=direct_object.total_mass_kg(),
            nnc=direct_object.base_wind_coefficient,
            kz=kz,
            cf=cf,
            wind_pressure_n_m2=wind_pressure,
            fix_load_n=fix_load,
            seismic_load_n=seismic_load,
            seismic_moment_nm=seismic_moment,
            directional_results=directional_results,
        )

    def calculate_at(
        self,
        evaluated_position_m: float,
    ) -> tuple[DirectObjectCalculationResult, ...]:
        return tuple(
            self.calculate_one(direct_object, evaluated_position_m)
            for direct_object in self.active_objects(evaluated_position_m)
        )

    def aggregate_at(
        self,
        evaluated_position_m: float,
    ) -> DirectObjectAggregationResult:
        results = self.calculate_at(evaluated_position_m)
        directional_totals = tuple(
            self._aggregate_direction(
                results,
                direction.name,
                direction.angle_rad,
            )
            for direction in self.wind_condition.directions
        )
        return DirectObjectAggregationResult(
            evaluated_position_m=float(evaluated_position_m),
            direct_object_results=results,
            active_object_count=len(results),
            total_fix_load_n=fsum(result.fix_load_n for result in results),
            total_seismic_load_n=fsum(
                result.seismic_load_n for result in results
            ),
            total_seismic_moment_nm=fsum(
                result.seismic_moment_nm for result in results
            ),
            directional_totals=directional_totals,
        )

    @staticmethod
    def _directional_result(
        direct_object: DirectObject,
        direction: str,
        wind_angle_rad: float,
        cf: float,
        wind_pressure_n_m2: float,
        load_center_height_m: float,
    ) -> DirectObjectDirectionalResult:
        angle_of_attack = direct_object.angle_of_attack_rad(wind_angle_rad)
        sine, cosine = direct_object.direction_factors(wind_angle_rad)
        projected_area = direct_object.projected_area(wind_angle_rad)
        wind_load = direct_object.calculate_wind_load(
            projected_area,
            cf,
            wind_pressure_n_m2,
        )
        wind_x = wind_load * round(cos(wind_angle_rad + pi), 3)
        wind_y = wind_load * round(sin(wind_angle_rad), 3)
        return DirectObjectDirectionalResult(
            direction=direction,
            angle_rad=wind_angle_rad,
            angle_of_attack_rad=angle_of_attack,
            sin_angle_of_attack=sine,
            cos_angle_of_attack=cosine,
            projected_area_m2=projected_area,
            wind_load_n=wind_load,
            wind_load_x_n=wind_x,
            wind_load_y_n=wind_y,
            wind_moment_nm=wind_load * load_center_height_m,
            wind_moment_x_nm=wind_y * load_center_height_m,
            wind_moment_y_nm=wind_x * load_center_height_m,
        )

    @staticmethod
    def _aggregate_direction(
        results: tuple[DirectObjectCalculationResult, ...],
        direction: str,
        angle_rad: float,
    ) -> DirectObjectDirectionalTotal:
        direction_results = tuple(
            directional
            for result in results
            for directional in result.directional_results
            if directional.direction == direction
        )
        return DirectObjectDirectionalTotal(
            direction=direction,
            angle_rad=angle_rad,
            total_wind_load_n=fsum(
                result.wind_load_n for result in direction_results
            ),
            total_wind_load_x_n=fsum(
                result.wind_load_x_n for result in direction_results
            ),
            total_wind_load_y_n=fsum(
                result.wind_load_y_n for result in direction_results
            ),
            total_wind_moment_nm=fsum(
                result.wind_moment_nm for result in direction_results
            ),
            total_wind_moment_x_nm=fsum(
                result.wind_moment_x_nm for result in direction_results
            ),
            total_wind_moment_y_nm=fsum(
                result.wind_moment_y_nm for result in direction_results
            ),
        )
