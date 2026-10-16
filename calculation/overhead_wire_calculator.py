"""Load and tension calculation for overhead wires."""

from collections.abc import Iterable
from math import cos, fsum, pi, sin

from domain.conditions import SeismicCondition, WindCondition
from domain.overhead_wire import OverheadWire

from .result import (
    OverheadWireAggregationResult,
    OverheadWireCalculationResult,
    OverheadWireDirectionalResult,
    OverheadWireDirectionalTotal,
)


class OverheadWireCalculator:
    """Calculate OHW loads at one EvaluatedPosition."""

    def __init__(
        self,
        wires: Iterable[OverheadWire],
        wind_condition: WindCondition,
        seismic_condition: SeismicCondition,
    ) -> None:
        self.wires = tuple(wires)
        if any(not isinstance(wire, OverheadWire) for wire in self.wires):
            raise TypeError(
                "OverheadWireCalculator accepts only OverheadWire instances"
            )
        self.wind_condition = wind_condition
        self.seismic_condition = seismic_condition

    def active_wires(
        self,
        evaluated_position_m: float,
    ) -> tuple[OverheadWire, ...]:
        return tuple(
            wire
            for wire in self.wires
            if wire.elevation_m >= evaluated_position_m
        )

    def calculate_one(
        self,
        wire: OverheadWire,
        evaluated_position_m: float,
    ) -> OverheadWireCalculationResult:
        if wire.elevation_m < evaluated_position_m:
            raise ValueError(
                f"OHW {wire.name!r} is below the EvaluatedPosition"
            )

        load_center_height = wire.load_center_height_m(evaluated_position_m)
        kz = self.wind_condition.kz_at(wire.elevation_m)
        cf = wire.wind_coefficient(
            self.wind_condition.design_standard,
            kz,
        )
        wind_pressure = self.wind_condition.wind_pressure_at(wire.elevation_m)
        fix_load = wire.fix_load_n()
        seismic_load = wire.calculate_seismic_load(
            fix_load,
            self.seismic_condition.k_value,
        )
        seismic_moment = wire.calculate_moment(
            seismic_load,
            load_center_height,
        )
        seismic_tension = wire.seismic_tension_n()
        directional_results = tuple(
            self._directional_result(
                wire,
                direction.name,
                direction.angle_rad,
                cf,
                wind_pressure,
                load_center_height,
                seismic_tension,
            )
            for direction in self.wind_condition.directions
        )

        return OverheadWireCalculationResult(
            wire_name=wire.name,
            evaluated_position_m=float(evaluated_position_m),
            elevation_m=wire.elevation_m,
            load_center_height_m=load_center_height,
            tributary_wire_length_m=wire.tributary_wire_length_m(),
            total_mass_kg=wire.total_mass_kg(),
            nnc=wire.base_wind_coefficient,
            kz=kz,
            cf=cf,
            wind_pressure_n_m2=wind_pressure,
            projected_area_m2=wire.projected_area(),
            fix_load_per_length_n_m=wire.fix_load_per_length_n_m(),
            fix_load_n=fix_load,
            seismic_load_n=seismic_load,
            seismic_moment_nm=seismic_moment,
            seismic_tension_n=seismic_tension,
            directional_results=directional_results,
        )

    def calculate_at(
        self,
        evaluated_position_m: float,
    ) -> tuple[OverheadWireCalculationResult, ...]:
        return tuple(
            self.calculate_one(wire, evaluated_position_m)
            for wire in self.active_wires(evaluated_position_m)
        )

    def aggregate_at(
        self,
        evaluated_position_m: float,
    ) -> OverheadWireAggregationResult:
        results = self.calculate_at(evaluated_position_m)
        return OverheadWireAggregationResult(
            evaluated_position_m=float(evaluated_position_m),
            wire_results=results,
            active_wire_count=len(results),
            total_fix_load_n=fsum(result.fix_load_n for result in results),
            total_seismic_load_n=fsum(
                result.seismic_load_n for result in results
            ),
            total_seismic_moment_nm=fsum(
                result.seismic_moment_nm for result in results
            ),
            total_seismic_tension_n=fsum(
                result.seismic_tension_n for result in results
            ),
            directional_totals=tuple(
                self._aggregate_direction(
                    results,
                    direction.name,
                    direction.angle_rad,
                )
                for direction in self.wind_condition.directions
            ),
        )

    @staticmethod
    def _directional_result(
        wire: OverheadWire,
        direction: str,
        wind_angle_rad: float,
        cf: float,
        wind_pressure_n_m2: float,
        load_center_height_m: float,
        seismic_tension_n: float,
    ) -> OverheadWireDirectionalResult:
        angle_of_attack = wire.angle_of_attack_rad(wind_angle_rad)
        sine, cosine = wire.direction_factors(wind_angle_rad)
        directional_area = wire.projected_area(wind_angle_rad)
        wind_load = wire.calculate_wind_load(
            directional_area,
            cf,
            wind_pressure_n_m2,
        )
        wind_x = wind_load * round(cos(wind_angle_rad + pi), 3)
        wind_y = wind_load * round(sin(wind_angle_rad), 3)
        combined_line_load = wire.combined_wind_line_load_n_m(
            wind_pressure_n_m2,
            cf,
            wind_angle_rad,
        )
        wind_tension = wire.tension_from_line_load(combined_line_load)
        tension_x, tension_y = wire.wind_tension_components_n(wind_tension)

        return OverheadWireDirectionalResult(
            direction=direction,
            angle_rad=wind_angle_rad,
            angle_of_attack_rad=angle_of_attack,
            sin_angle_of_attack=sine,
            cos_angle_of_attack=cosine,
            directional_projected_area_m2=directional_area,
            wind_load_n=wind_load,
            wind_load_x_n=wind_x,
            wind_load_y_n=wind_y,
            wind_moment_nm=wind_load * load_center_height_m,
            wind_moment_x_nm=wind_y * load_center_height_m,
            wind_moment_y_nm=wind_x * load_center_height_m,
            combined_wind_line_load_n_m=combined_line_load,
            wind_tension_n=wind_tension,
            wind_tension_x_n=tension_x,
            wind_tension_y_n=tension_y,
            wind_tension_moment_nm=(
                wind_tension * load_center_height_m * cosine
            ),
            wind_tension_moment_x_nm=tension_y * load_center_height_m,
            wind_tension_moment_y_nm=tension_x * load_center_height_m,
            seismic_tension_moment_nm=(
                seismic_tension_n * load_center_height_m * cosine
            ),
        )

    @staticmethod
    def _aggregate_direction(
        results: tuple[OverheadWireCalculationResult, ...],
        direction: str,
        angle_rad: float,
    ) -> OverheadWireDirectionalTotal:
        items = tuple(
            directional
            for result in results
            for directional in result.directional_results
            if directional.direction == direction
        )
        return OverheadWireDirectionalTotal(
            direction=direction,
            angle_rad=angle_rad,
            total_wind_load_n=fsum(item.wind_load_n for item in items),
            total_wind_load_x_n=fsum(item.wind_load_x_n for item in items),
            total_wind_load_y_n=fsum(item.wind_load_y_n for item in items),
            total_wind_moment_nm=fsum(item.wind_moment_nm for item in items),
            total_wind_moment_x_nm=fsum(
                item.wind_moment_x_nm for item in items
            ),
            total_wind_moment_y_nm=fsum(
                item.wind_moment_y_nm for item in items
            ),
            total_wind_tension_n=fsum(item.wind_tension_n for item in items),
            total_wind_tension_x_n=fsum(
                item.wind_tension_x_n for item in items
            ),
            total_wind_tension_y_n=fsum(
                item.wind_tension_y_n for item in items
            ),
            total_wind_tension_moment_nm=fsum(
                item.wind_tension_moment_nm for item in items
            ),
            total_wind_tension_moment_x_nm=fsum(
                item.wind_tension_moment_x_nm for item in items
            ),
            total_wind_tension_moment_y_nm=fsum(
                item.wind_tension_moment_y_nm for item in items
            ),
            total_seismic_tension_moment_nm=fsum(
                item.seismic_tension_moment_nm for item in items
            ),
        )
