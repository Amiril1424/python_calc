"""Manual input runner for comparing calculation-engine results.

Run this file from the ``python_calc`` directory:

    python manual_check.py

Edit only the MANUAL INPUT section when checking another case.
"""

from math import fsum

from calculation.direct_object_calculator import DirectObjectCalculator
from calculation.evaluated_position_calculator import EvaluatedPositionCalculator
from calculation.overhead_wire_calculator import OverheadWireCalculator
from calculation.pole_assembly import PoleAssembly
from calculation.pole_calculator import PoleCalculator
from domain.conditions import SeismicCondition, WindCondition
from domain.direct_object import DirectObject
from domain.loads import OverdesignFactor
from domain.overhead_wire import OverheadWire
from domain.pole import PoleObject


# ============================================================================
# MANUAL INPUT
# ============================================================================

EVALUATED_POSITIONS_M = (6.65, 1.65, 0.0)

WIND_CONDITION = WindCondition(
    design_standard=3,
    structure_height_m=8.15,
)

SEISMIC_CONDITION = SeismicCondition.ground(k_value=0.5)

POLE_OVERDESIGN_FACTOR = OverdesignFactor(value=1.0)

POLES = (
    PoleObject(
        name="Pole-1",
        pole_type="Straight",
        diameter_lower_mm=75,
        diameter_upper_mm=75,
        thickness_lower_mm=4.5,
        thickness_upper_mm=4.5,
        material="STK400",
        top_elevation_m=8.15,
        quantity=1,
    ),
    PoleObject(
        name="Pole-2",
        pole_type="Taper",
        diameter_lower_mm=165.2,
        diameter_upper_mm=75,
        thickness_lower_mm=4.5,
        thickness_upper_mm=4.5,
        material="STK400",
        top_elevation_m=6.65,
        quantity=1,
    ),
    PoleObject(
        name="Pole-3",
        pole_type="Straight",
        diameter_lower_mm=165.2,
        diameter_upper_mm=165.2,
        thickness_lower_mm=4.5,
        thickness_upper_mm=4.5,
        material="STK400",
        top_elevation_m=1.65,
        quantity=1,
    ),
)

DIRECT_OBJECTS = (
    DirectObject(
        name="DO1",
        object_type="Directional",
        front_area_m2=0.049,
        side_area_m2=0.041,
        mass_per_unit_kg=5.8,
        elevation_m=8.15,
        base_wind_coefficient=1.0,
        quantity=1,
        fixed_angle_deg=0,
    ),
)

OVERHEAD_WIRES = (
    OverheadWire(
        name="OHW1",
        mass_per_length_kg_m=0.19,
        diameter_mm=11.5,
        elevation_m=5.75,
        span_length_m=15,
        sag_ratio_percent=3,
        base_wind_coefficient=1.0,
        fixed_angle_deg=180,
        vertical_angle_deg=0,
    ),
)


# ============================================================================
# CALCULATION SETUP
# ============================================================================

pole_calculator = PoleCalculator(
    assembly=PoleAssembly(POLES, base_elevation_m=0),
    wind_condition=WIND_CONDITION,
    seismic_condition=SEISMIC_CONDITION,
    overdesign_factor=POLE_OVERDESIGN_FACTOR,
)

direct_object_calculator = DirectObjectCalculator(
    direct_objects=DIRECT_OBJECTS,
    wind_condition=WIND_CONDITION,
    seismic_condition=SEISMIC_CONDITION,
)

overhead_wire_calculator = OverheadWireCalculator(
    wires=OVERHEAD_WIRES,
    wind_condition=WIND_CONDITION,
    seismic_condition=SEISMIC_CONDITION,
)

evaluated_position_calculator = EvaluatedPositionCalculator(
    pole_calculator=pole_calculator,
    direct_object_calculator=direct_object_calculator,
    overhead_wire_calculator=overhead_wire_calculator,
)


def print_header(title: str) -> None:
    print()
    print("=" * 100)
    print(title)
    print("=" * 100)


def print_pole_results(result) -> None:
    print("\nPOLE RESULTS")
    if not result.pole_results:
        print("  No active Pole")
        return

    for item in result.pole_results:
        geometry = item.geometry
        print(
            f"  {geometry.pole_name}: "
            f"L={geometry.active_length_m:.3f} m, "
            f"DiaBottom={geometry.diameter_at_active_bottom_mm:.3f} mm, "
            f"Mass={item.mass_kg:.3f} kg, "
            f"FixLoad={item.fix_load_n:.3f} N, "
            f"CF={item.cf:.3f}, "
            f"Area={item.projected_area_m2:.6f} m2, "
            f"Wind={item.wind_load_n:.3f} N, "
            f"Seismic={item.seismic_load_n:.3f} N, "
            f"LoadCenterHeight={geometry.load_center_height_m:.3f} m, "
            f"M-Seismic={item.seismic_moment_nm:.3f} Nm"
        )


def print_direct_object_results(result) -> None:
    print("\nDIRECT OBJECT RESULTS")
    if not result.direct_object_results:
        print("  No active Direct Object")
        return

    for item in result.direct_object_results:
        print(
            f"  {item.object_name}: "
            f"Mass={item.total_mass_kg:.3f} kg, "
            f"FixLoad={item.fix_load_n:.3f} N, "
            f"CF={item.cf:.3f}, "
            f"Seismic={item.seismic_load_n:.3f} N, "
            f"LoadCenterHeight={item.load_center_height_m:.3f} m, "
            f"M-Seismic={item.seismic_moment_nm:.3f} Nm"
        )


def print_overhead_wire_results(result) -> None:
    print("\nOVERHEAD WIRE RESULTS")
    if not result.wire_results:
        print("  No active OHW")
        return

    for item in result.wire_results:
        print(
            f"  {item.wire_name}: "
            f"WireLength={item.tributary_wire_length_m:.3f} m, "
            f"Mass={item.total_mass_kg:.3f} kg, "
            f"FixLoad={item.fix_load_n:.3f} N, "
            f"CF={item.cf:.3f}, "
            f"Area={item.projected_area_m2:.6f} m2, "
            f"Seismic={item.seismic_load_n:.3f} N, "
            f"LoadCenterHeight={item.load_center_height_m:.3f} m, "
            f"M-Seismic={item.seismic_moment_nm:.3f} Nm, "
            f"SeismicTension={item.seismic_tension_n:.3f} N"
        )


def print_scalar_totals(pole_result, direct_result, wire_result) -> None:
    total_fix_load = fsum(
        (
            pole_result.total_fix_load_n,
            direct_result.total_fix_load_n,
            wire_result.total_fix_load_n,
        )
    )
    total_seismic_load = fsum(
        (
            pole_result.total_seismic_load_n,
            direct_result.total_seismic_load_n,
            wire_result.total_seismic_load_n,
        )
    )
    total_seismic_moment = fsum(
        (
            pole_result.total_seismic_moment_nm,
            direct_result.total_seismic_moment_nm,
            wire_result.total_seismic_moment_nm,
        )
    )

    print("\nCOMBINED SCALAR TOTALS")
    print(f"  Total FixLoad         = {total_fix_load:.3f} N")
    print(f"  Total SeismicLoad     = {total_seismic_load:.3f} N")
    print(f"  Total Seismic Moment  = {total_seismic_moment:.3f} Nm")
    print(
        "  Total Seismic Tension = "
        f"{wire_result.total_seismic_tension_n:.3f} N"
    )


def find_direction(items, direction: str):
    return next(item for item in items if item.direction == direction)


def print_directional_totals(pole_result, direct_result, wire_result) -> None:
    print("\nCOMBINED WIND RESULTS PER DIRECTION")
    print(
        "  Dir |     Wind N |    Wind X |    Wind Y | "
        "Moment X Nm | Moment Y Nm"
    )
    print("  " + "-" * 75)

    for direction in ("N", "S", "E", "W", "NE", "SW", "NW", "SE"):
        pole = find_direction(pole_result.directional_totals, direction)
        direct = find_direction(direct_result.directional_totals, direction)
        wire = find_direction(wire_result.directional_totals, direction)

        wind = fsum(
            (
                pole.total_wind_load_n,
                direct.total_wind_load_n,
                wire.total_wind_load_n,
            )
        )
        wind_x = fsum(
            (
                pole.total_wind_load_x_n,
                direct.total_wind_load_x_n,
                wire.total_wind_load_x_n,
            )
        )
        wind_y = fsum(
            (
                pole.total_wind_load_y_n,
                direct.total_wind_load_y_n,
                wire.total_wind_load_y_n,
            )
        )
        moment_x = fsum(
            (
                pole.total_wind_moment_x_nm,
                direct.total_wind_moment_x_nm,
                wire.total_wind_moment_x_nm,
            )
        )
        moment_y = fsum(
            (
                pole.total_wind_moment_y_nm,
                direct.total_wind_moment_y_nm,
                wire.total_wind_moment_y_nm,
            )
        )

        print(
            f"  {direction:>3} | "
            f"{wind:10.3f} | "
            f"{wind_x:9.3f} | "
            f"{wind_y:9.3f} | "
            f"{moment_x:11.3f} | "
            f"{moment_y:11.3f}"
        )


def print_ohw_tension_results(wire_result) -> None:
    if not wire_result.wire_results:
        return

    print("\nOHW TENSION RESULTS PER DIRECTION")
    print(
        "  Dir |  Tension N | Tension X | Tension Y | "
        "M-Tension X | M-Tension Y | M-Seismic Tension"
    )
    print("  " + "-" * 99)
    for item in wire_result.directional_totals:
        print(
            f"  {item.direction:>3} | "
            f"{item.total_wind_tension_n:10.3f} | "
            f"{item.total_wind_tension_x_n:9.3f} | "
            f"{item.total_wind_tension_y_n:9.3f} | "
            f"{item.total_wind_tension_moment_x_nm:11.3f} | "
            f"{item.total_wind_tension_moment_y_nm:11.3f} | "
            f"{item.total_seismic_tension_moment_nm:17.3f}"
        )


def print_complete_evaluated_position_result(result) -> None:
    """Print Section_each-style totals and strength results."""
    section = result.section_properties

    print("\nEVALUATED POSITION SECTION PROPERTY")
    print(f"  Evaluated Pole        = {result.evaluated_pole_name}")
    print(f"  Material              = {result.material_name}")
    print(f"  Diameter              = {section.diameter_mm:.3f} mm")
    print(f"  Thickness             = {section.thickness_mm:.3f} mm")
    print(f"  Cross Section Area    = {section.cross_section_area_cm2:.3f} cm2")
    print(f"  Section Modulus       = {section.section_modulus_cm3:.3f} cm3")
    print(f"  Moment of Inertia     = {section.moment_of_inertia_cm4:.3f} cm4")
    print(f"  Radius of Gyration    = {section.radius_of_gyration_cm:.3f} cm")

    print("\nCOMPLETE DIRECTIONAL STRENGTH RESULTS")
    print(
        "  Dir | Resultant Wind N | Combined M-Wind Nm | "
        "Stress-W N/mm2 | Util-W | W-Result | "
        "Combined M-Seismic Nm | Stress-S N/mm2 | Util-S | S-Result"
    )
    print("  " + "-" * 143)
    for item in result.directional_results:
        wind_strength = item.wind_strength
        seismic_strength = item.seismic_strength
        print(
            f"  {item.direction:>3} | "
            f"{item.resultant_wind_load_n:16.3f} | "
            f"{item.combined_wind_moment_nm:18.3f} | "
            f"{wind_strength.calculated_stress_n_mm2:14.3f} | "
            f"{wind_strength.utilization_ratio:6.3f} | "
            f"{wind_strength.status:>8} | "
            f"{item.combined_seismic_moment_nm:21.3f} | "
            f"{seismic_strength.calculated_stress_n_mm2:14.3f} | "
            f"{seismic_strength.utilization_ratio:6.3f} | "
            f"{seismic_strength.status:>8}"
        )

    north = result.report_result
    wind_strength = north.wind_strength
    seismic_strength = north.seismic_strength

    print("\nOMNI REPORT RESULT - DIRECTION N (90 DEG)")
    print(f"  Total FixLoad                   = {result.total_fix_load_n:.3f} N")
    print(f"  Total WindLoad                  = {north.total_wind_load_n:.3f} N")
    print(f"  Resultant WindLoad              = {north.resultant_wind_load_n:.3f} N")
    print(f"  Combined Wind Moment            = {north.combined_wind_moment_nm:.3f} Nm")
    print(f"  Wind Bending Stress             = {wind_strength.calculated_stress_n_mm2:.3f} N/mm2")
    print(f"  Wind Allowable Bending Stress   = {wind_strength.allowable_stress_n_mm2:.3f} N/mm2")
    print(f"  Wind Utilization Ratio          = {wind_strength.utilization_ratio:.3f}")
    print(f"  Wind Safety Result              = {wind_strength.status}")
    print(f"  Total SeismicLoad               = {result.total_seismic_load_n:.3f} N")
    print(f"  Resultant SeismicLoad           = {north.resultant_seismic_load_n:.3f} N")
    print(f"  Combined Seismic Moment         = {north.combined_seismic_moment_nm:.3f} Nm")
    print(f"  Seismic Bending Stress          = {seismic_strength.calculated_stress_n_mm2:.3f} N/mm2")
    print(f"  Seismic Allowable Bend. Stress  = {seismic_strength.allowable_stress_n_mm2:.3f} N/mm2")
    print(f"  Seismic Utilization Ratio       = {seismic_strength.utilization_ratio:.3f}")
    print(f"  Seismic Safety Result           = {seismic_strength.status}")


def run_manual_check() -> None:
    for evaluated_position_m in EVALUATED_POSITIONS_M:
        pole_result = pole_calculator.aggregate_at(evaluated_position_m)
        direct_result = direct_object_calculator.aggregate_at(
            evaluated_position_m
        )
        wire_result = overhead_wire_calculator.aggregate_at(
            evaluated_position_m
        )
        complete_result = evaluated_position_calculator.calculate_at(
            evaluated_position_m
        )

        print_header(
            f"EVALUATED POSITION = {evaluated_position_m:.3f} m"
        )
        print_pole_results(pole_result)
        print_direct_object_results(direct_result)
        print_overhead_wire_results(wire_result)
        print_scalar_totals(pole_result, direct_result, wire_result)
        print_directional_totals(pole_result, direct_result, wire_result)
        print_ohw_tension_results(wire_result)
        print_complete_evaluated_position_result(complete_result)


if __name__ == "__main__":
    run_manual_check()
