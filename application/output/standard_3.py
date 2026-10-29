"""Confirmed d_st=3 output mapping for the legacy numbered report."""

from math import hypot

from calculation.result import Standard34CalculationResult
from calculation.rounding import CalculationValueType, rounding_profile_for
from domain.arm import ArmPart
from domain.standards import DesignStandardCode

from .models import Standard3Output, Standard3OutputSource


def _status_code(display_status: str) -> str:
    return "OK" if display_status.replace(".", "").upper() == "OK" else "NG"


def _legacy_limit_text(status_code: str) -> str:
    """Return the comparison text printed by the legacy report."""
    return "< 1.0" if status_code == "OK" else "> 1.0"


def _legacy_status_text(status_code: str) -> str:
    """Return the legacy dotted O.K/N.G display text."""
    return "・・・O.K" if status_code == "OK" else "・・・N.G"


class Standard3OutputMapper:
    """Map d_st=3 calculation results without changing engineering values."""

    _STANDARD = DesignStandardCode.OLD_LIGHTING_POLE

    def __init__(self) -> None:
        self.rounding = rounding_profile_for(self._STANDARD)

    def map(self, source: Standard3OutputSource) -> Standard3Output:
        if not isinstance(source, Standard3OutputSource):
            raise TypeError("source must be a Standard3OutputSource")
        if not source.calculation_results:
            raise ValueError("At least one d_st=3 calculation result is required")
        if any(
            result.design_standard.code is not self._STANDARD
            for result in source.calculation_results
        ):
            raise ValueError("Standard3OutputMapper accepts only d_st=3 results")

        first = source.calculation_results[0]
        policy = first.design_standard.wind_pressure_policy
        wind_speed = float(policy.wind_speed_m_s)
        wind_pressure = self.rounding.apply(
            policy.wind_pressure_at(0.0), CalculationValueType.WIND_PRESSURE
        )
        arms = self._arm_outputs(source)
        wires = self._wire_outputs(source, first)
        positions = tuple(
            self._evaluated_position_output(result)
            for result in source.calculation_results
        )
        numbered = self._numbered_output(
            source=source,
            first=first,
            wind_speed=wind_speed,
            wind_pressure=wind_pressure,
            wires=wires,
            arms=arms,
            positions=positions,
        )
        return Standard3Output(
            design_standard=3,
            design_standard_name="Old Lighting Pole",
            schema_version="1.0",
            status="READY",
            conditions={
                "standard_label": "JIL",
                "wind_speed_m_s": wind_speed,
                "air_density_kg_m3": float(policy.air_density_kg_m3),
                "wind_pressure_n_m2": wind_pressure,
                "pole_shape_factor": 0.7,
                "arm_object_shape_factor": 1.0,
                "overhead_wire_shape_factor": 1.0,
                "short_term_allowable_bending_stress_n_mm2": (
                    first.direction_results[0]
                    .bending_stress.short_term_allowable_bending_n_mm2
                ),
                "wind_case": {
                    "code": first.direction_results[0].wind_case_name,
                    "direction_deg": first.direction_results[0].wind_direction_deg,
                },
            },
            overhead_wires=wires,
            arms=arms,
            evaluated_positions=positions,
            numbered_output=numbered,
        )

    def _wire_outputs(self, source, first):
        inputs = {wire.name: wire for wire in source.overhead_wires}
        result_by_name = {}
        for calculation in source.calculation_results:
            for result in calculation.overhead_wire_aggregation.wire_results:
                result_by_name.setdefault(result.wire_name, result)
        outputs = []
        for wire in source.overhead_wires:
            result = result_by_name.get(wire.name)
            if result is None:
                continue
            direction = result.directional_results[0]
            fixed_tension = self.rounding.apply(
                wire.tension_from_line_load(result.fix_load_per_length_n_m),
                CalculationValueType.LOAD,
            )
            outputs.append({
                "name": wire.name,
                "diameter_mm": wire.diameter_mm,
                "mass_per_length_kg_m": wire.mass_per_length_kg_m,
                "elevation_m": wire.elevation_m,
                "span_length_m": wire.span_length_m,
                "sag_ratio_percent": wire.sag_ratio_percent,
                "wind_coefficient": result.cf,
                "fix_load_per_length_n_m": result.fix_load_per_length_n_m,
                "fixed_tension_n": fixed_tension,
                "combined_wind_line_load_n_m": direction.combined_wind_line_load_n_m,
                "wind_tension_n": direction.wind_tension_n,
            })
        return tuple(outputs)

    def _arm_outputs(self, source):
        if source.arm_assembly is None:
            return ()
        result_by_name = {}
        for calculation in source.calculation_results:
            if calculation.arm_aggregation is None:
                continue
            for result in calculation.arm_aggregation.arm_results:
                result_by_name.setdefault(result.arm_name, result)
        outputs = []
        for part in source.arm_assembly.arm_parts:
            result = result_by_name.get(part.arm.name)
            if result is None:
                continue
            objects = tuple(
                self._arm_object_output(part, object_result)
                for object_result in result.object_results
            )
            safety = result.wind_combination_safety
            outputs.append({
                "name": part.arm.name,
                "arm_type": part.arm.arm_type.value,
                "material": part.arm.material.name,
                "diameter_mm": part.arm.diameter_mm,
                "thickness_mm": part.arm.thickness_mm,
                "total_length_m": part.arm.total_length_m,
                "exposed_length_m": part.arm.exposed_length_m,
                "installation_height_m": part.arm.installation_height_m,
                "fixed_angle_deg": part.arm.fixed_angle_deg,
                "quantity": 1,
                "specification": {
                    "section_area_cm2": result.specification.section_area_cm2,
                    "section_modulus_cm3": result.specification.section_modulus_cm3,
                    "moment_of_inertia_cm4": result.specification.moment_of_inertia_cm4,
                    "radius_of_gyration_cm": result.specification.radius_of_gyration_cm,
                    "fix_load_n": result.specification.fix_load_n,
                    "projected_area_m2": result.specification.front_projected_area_m2,
                    "wind_coefficient": part.arm.shape_factor,
                },
                "objects": objects,
                "totals": {
                    "fix_load_n": result.total_fix_load_n,
                    "wind_load_n": sum(item["wind_load_n"] for item in objects),
                    "moment_due_to_fix_load_nm": result.total_fix_load_moment_at_arm_support_nm,
                    "moment_due_to_wind_load_nm": result.total_wind_moment_at_arm_support_nm,
                    "combined_moment_nm": safety.moment_nm,
                    "bending_stress_n_mm2": safety.bending_stress_n_mm2,
                    "allowable_stress_n_mm2": safety.allowable_stress_n_mm2,
                    "utilization_ratio": safety.utilization_ratio,
                    "limit_ratio": 1.0,
                    "status_code": _status_code(safety.status),
                    "status_display": safety.status,
                },
            })
        return tuple(outputs)

    def _arm_object_output(self, part: ArmPart, result):
        if result.object_index == 0:
            quantity = 1
            coefficient = part.arm.shape_factor
        else:
            mounted = part.mounted_objects[result.object_index - 1]
            quantity = mounted.quantity
            coefficient = mounted.base_wind_coefficient
        direction = result.directional_results[0]
        return {
            "index": result.object_index,
            "name": result.object_name,
            "object_type": str(result.object_type),
            "quantity": quantity,
            "fix_load_n": result.fix_load_n,
            "projected_area_m2": direction.directional_projected_area_m2,
            "wind_coefficient": coefficient,
            "wind_load_n": direction.wind_load_n,
            "horizontal_load_distance_m": result.horizontal_load_distance_m,
            "moment_due_to_fix_load_nm": result.fix_load_moment_at_arm_support_nm,
            "moment_due_to_wind_load_nm": result.wind_moment_at_arm_support_nm,
        }

    def _evaluated_position_output(self, result: Standard34CalculationResult):
        direction = result.direction_results[0]
        load_rows = []
        if result.arm_aggregation is not None:
            arm_direction = result.arm_aggregation.directional_totals[0]
            for arm in result.arm_aggregation.arm_results:
                load_rows.append({
                    "source_type": "ARM",
                    "name": arm.arm_name,
                    "quantity": 1,
                    "fix_load_n": arm.total_fix_load_n,
                    "wind_load_n": arm_direction.total_wind_load_n,
                })
        for item in result.direct_object_aggregation.direct_object_results:
            directional = item.directional_results[0]
            load_rows.append({
                "source_type": "DIRECT_OBJECT",
                "name": item.object_name,
                "quantity": item.quantity,
                "fix_load_n": item.fix_load_n,
                "projected_area_m2": directional.projected_area_m2,
                "wind_coefficient": item.cf,
                "wind_load_n": directional.wind_load_n,
            })
        for item in result.overhead_wire_aggregation.wire_results:
            directional = item.directional_results[0]
            load_rows.append({
                "source_type": "OVERHEAD_WIRE",
                "name": item.wire_name,
                "quantity": 1,
                "fix_load_n": item.fix_load_n,
                "projected_area_m2": directional.directional_projected_area_m2,
                "wind_coefficient": item.cf,
                "wind_load_n": directional.wind_load_n,
            })
        for item in reversed(result.pole_aggregation.pole_results):
            directional = item.directional_results[0]
            load_rows.append({
                "source_type": "POLE",
                "name": item.geometry.pole_name,
                "quantity": 1,
                "fix_load_n": item.fix_load_n,
                "projected_area_m2": item.projected_area_m2,
                "wind_coefficient": item.cf,
                "wind_load_n": item.wind_load_n,
                "load_center_height_m": item.geometry.load_center_height_m,
                "wind_moment_nm": item.wind_moment_nm,
            })
        stress = direction.bending_stress
        return {
            "evaluated_position_m": result.evaluated_position_m,
            "evaluated_pole_name": result.evaluated_pole_name,
            "material": result.material_name,
            "diameter_mm": result.section_properties.diameter_mm,
            "thickness_mm": result.section_properties.thickness_mm,
            "section_modulus_cm3": result.section_properties.section_modulus_cm3,
            "load_rows": tuple(load_rows),
            "totals": {
                "vertical_fix_load_n": result.total_fix_load_n,
                "ordinary_wind_load_n": direction.total_wind_load_n,
                "wire_wind_tension_n": direction.total_wind_tension_n,
                "resultant_horizontal_load_n": direction.resultant_wind_load_n,
                "moment_due_to_arm_fix_load_nm": (
                    0.0 if result.arm_aggregation is None else sum(
                        item.total_fix_load_moment_at_arm_support_nm
                        for item in result.arm_aggregation.arm_results
                    )
                ),
                "ordinary_wind_moment_nm": direction.combined_wind_moment_x_nm,
                "wire_tension_moment_nm": abs(direction.combined_wind_moment_y_nm) - (
                    0.0 if result.arm_aggregation is None else sum(
                        item.total_fix_load_moment_at_arm_support_nm
                        for item in result.arm_aggregation.arm_results
                    )
                ),
                "combined_moment_nm": direction.combined_wind_moment_nm,
                "bending_stress_n_mm2": stress.bending_stress_n_mm2,
                "allowable_stress_n_mm2": stress.short_term_allowable_bending_n_mm2,
                "utilization_ratio": stress.safety_factor,
                "limit_ratio": 1.0,
                "status_code": _status_code(stress.status),
                "status_display": stress.status,
            },
        }

    def _numbered_output(self, *, source, first, wind_speed, wind_pressure,
                         wires, arms, positions):
        numbered = {number: None for number in range(1, 105)}
        allowable = first.direction_results[0].bending_stress.short_term_allowable_bending_n_mm2
        air_density = float(
            first.design_standard.wind_pressure_policy.air_density_kg_m3
        )
        numbered.update({
            1: wind_speed, 2: air_density, 3: wind_pressure,
            4: 0.7, 5: 1.0, 6: 1.0, 7: allowable,
        })
        if wires:
            wire = wires[0]
            numbered.update({
                8: wire["name"], 9: wire["diameter_mm"],
                10: wire["mass_per_length_kg_m"], 11: wire["span_length_m"],
                12: wire["sag_ratio_percent"], 13: wire["span_length_m"],
                14: wire["fixed_tension_n"], 15: wire["wind_tension_n"],
                16: wire["combined_wind_line_load_n_m"],
            })
        if arms:
            arm = arms[0]
            objects = arm["objects"]
            body = objects[0]
            mounted = objects[1] if len(objects) > 1 else None
            total = arm["totals"]
            arm_status = total["status_code"]
            numbered.update({
                17: arm["diameter_mm"], 18: arm["thickness_mm"],
                19: arm["material"], 20: arm["specification"]["section_modulus_cm3"],
                21: body["name"], 22: None if mounted is None else mounted["name"],
                23: body["fix_load_n"], 24: None if mounted is None else mounted["fix_load_n"],
                25: body["quantity"], 26: None if mounted is None else mounted["quantity"],
                27: body["fix_load_n"], 28: None if mounted is None else mounted["fix_load_n"],
                29: total["fix_load_n"], 30: body["projected_area_m2"],
                31: None if mounted is None else mounted["projected_area_m2"],
                32: body["wind_coefficient"], 33: None if mounted is None else mounted["wind_coefficient"],
                34: body["wind_load_n"], 35: None if mounted is None else mounted["wind_load_n"],
                36: body["quantity"], 37: None if mounted is None else mounted["quantity"],
                38: body["wind_load_n"], 39: None if mounted is None else mounted["wind_load_n"],
                40: total["wind_load_n"], 41: total["moment_due_to_fix_load_nm"],
                42: total["moment_due_to_wind_load_nm"], 43: total["combined_moment_nm"],
                44: total["bending_stress_n_mm2"], 45: total["bending_stress_n_mm2"],
                46: total["allowable_stress_n_mm2"], 47: total["utilization_ratio"],
                48: _legacy_limit_text(arm_status),
                49: _legacy_status_text(arm_status),
            })
        position = positions[-1]
        totals = position["totals"]
        numbered.update({
            50: position["diameter_mm"], 51: position["thickness_mm"],
            52: position["material"], 53: position["section_modulus_cm3"],
            70: totals["vertical_fix_load_n"], 91: totals["ordinary_wind_load_n"],
            92: totals["moment_due_to_arm_fix_load_nm"],
            93: totals["ordinary_wind_moment_nm"],
            94: totals["wire_tension_moment_nm"],
            95: totals["combined_moment_nm"],
            96: totals["bending_stress_n_mm2"],
            97: totals["bending_stress_n_mm2"],
            98: totals["allowable_stress_n_mm2"],
            99: totals["utilization_ratio"],
            100: _legacy_limit_text(totals["status_code"]),
            101: _legacy_status_text(totals["status_code"]),
            102: totals["vertical_fix_load_n"],
            103: totals["resultant_horizontal_load_n"],
            104: totals["combined_moment_nm"],
        })
        slots = position["load_rows"][:4]
        for index, row in enumerate(slots):
            numbered[54 + index] = row["name"]
            numbered[58 + index] = row["fix_load_n"]
            numbered[62 + index] = row["quantity"]
            numbered[66 + index] = row["fix_load_n"]
            numbered[71 + index] = row.get("projected_area_m2")
            numbered[75 + index] = row.get("wind_coefficient")
            numbered[79 + index] = row["wind_load_n"]
            numbered[83 + index] = row["quantity"]
            numbered[87 + index] = row["wind_load_n"]
        return numbered
