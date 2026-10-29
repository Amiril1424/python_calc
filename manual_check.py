"""Manual runner for validating each design standard against VBA.

Run from the ``python_calc`` directory::

    python manual_check.py

Set ``SELECTED_D_ST`` to 1, 2, 3, 4, 5, 6, 7, or 9, then edit only the
matching ``build_d_st_*_input`` function. Only d_st 3 currently contains the
previous example. Other standards intentionally stop until VBA input is added,
so placeholder values cannot be mistaken for approved engineering input.
"""

from dataclasses import dataclass
import json
from pprint import pprint

from application.calculation_service import CalculationService
from application.output import Standard3OutputSource, StandardOutputMapperFactory
from calculation.pole_assembly import PoleAssembly
from calculation.standard_126_workflow import Standard126CalculationWorkflow
from calculation.standard_34_workflow import Standard34CalculationWorkflow
from calculation.standard_arm_workflows import (
    Standard5CalculationWorkflow,
    Standard7CalculationWorkflow,
    Standard9CalculationWorkflow,
)
from domain.arm import Arm, ArmAssembly, ArmLoadObject, ArmPart
from domain.conditions import SeismicCondition
from domain.direct_object import DirectObject
from domain.loads import OverdesignFactor
from domain.overhead_wire import OverheadWire
from domain.pole import PoleObject
from domain.standards import DesignStandardFactory


# Change only this value to select the manual-check standard.
SELECTED_D_ST = 7


class ManualInputNotConfiguredError(RuntimeError):
    """Raised when a VBA comparison case has not been entered yet."""


@dataclass(frozen=True)
class ManualScenario:
    """Input required to construct one standard calculation workflow."""

    design_standard: int
    title: str
    evaluated_positions_m: tuple[float, ...]
    structure_height_m: float | None
    poles: tuple[PoleObject, ...]
    direct_objects: tuple[DirectObject, ...] = ()
    overhead_wires: tuple[OverheadWire, ...] = ()
    arm_assembly: ArmAssembly | None = None
    base_elevation_m: float = 0.0
    pole_overdesign_factor: float = 1.0

    # Wind-pressure input. Supply only values required by the standard.
    area_density_code: int | None = None
    basic_wind_speed_m_s: float | None = None

    # Seismic input.
    k_value: float | None = None
    eqa_m_s2: float = 4.71
    eqr: float = 1.0
    enable_optional_seismic: bool = False

    # Wind-case option for d_st 3 and 4.
    include_oblique_wind: bool = False


def _not_configured(design_standard: int) -> ManualScenario:
    raise ManualInputNotConfiguredError(
        f"Input manual untuk d_st = {design_standard} belum dikonfigurasi. "
        f"Isi fungsi build_d_st_{design_standard}_input() menggunakan data VBA."
    )


def _build_act_standard_input(
    *,
    design_standard: int,
    title: str,
) -> ManualScenario:
    """Shared VBA case supplied for d_st 1 and d_st 6."""
    poles = (
        PoleObject(
            name="Pole-1",
            pole_type="Straight",
            diameter_lower_mm=165.2,
            diameter_upper_mm=165.2,
            thickness_lower_mm=4.5,
            thickness_upper_mm=4.5,
            material="STK400",
            top_elevation_m=14.84,
        ),
        PoleObject(
            name="Pole-2",
            pole_type="Straight",
            diameter_lower_mm=190.7,
            diameter_upper_mm=190.7,
            thickness_lower_mm=5.5,
            thickness_upper_mm=5.5,
            material="STK540",
            top_elevation_m=9.69,
        ),
        PoleObject(
            name="Pole-3",
            pole_type="Straight",
            diameter_lower_mm=216.3,
            diameter_upper_mm=216.3,
            thickness_lower_mm=7.0,
            thickness_upper_mm=7.0,
            material="STK540",
            top_elevation_m=4.0,
        ),
    )
    direct_objects = (
        DirectObject(
            name="Lightning Rod",
            object_type="Omni",
            front_area_m2=0.1,
            side_area_m2=0.1,
            mass_per_unit_kg=10,
            elevation_m=16,
            base_wind_coefficient=0.7,
            quantity=1,
            fixed_angle_deg=0,
        ),
        DirectObject(
            name="3-yagi antenna",
            object_type="Omni",
            front_area_m2=0.3,
            side_area_m2=0.3,
            mass_per_unit_kg=11,
            elevation_m=10,
            base_wind_coefficient=1.2,
            quantity=1,
            fixed_angle_deg=0,
        ),
        DirectObject(
            name="Mounting Bracket yagi",
            object_type="Omni",
            front_area_m2=0.11,
            side_area_m2=0.11,
            mass_per_unit_kg=10,
            elevation_m=10,
            base_wind_coefficient=1.2,
            quantity=1,
            fixed_angle_deg=0,
        ),
    )
    overhead_wires = (
        OverheadWire(
            name="DV3.2-2C",
            mass_per_length_kg_m=0.19,
            diameter_mm=11.5,
            elevation_m=7,
            span_length_m=10,
            sag_ratio_percent=3,
            base_wind_coefficient=1.0,
            fixed_angle_deg=0,
            vertical_angle_deg=0,
        ),
    )
    return ManualScenario(
        design_standard=design_standard,
        title=title,
        evaluated_positions_m=(9.69, 4.0, 0.0),
        # d_st 1, 2, and 6 derive this automatically from the highest Pole.
        structure_height_m=None,
        poles=poles,
        direct_objects=direct_objects,
        overhead_wires=overhead_wires,
        area_density_code=2,
        basic_wind_speed_m_s=34,
        k_value=0.5,
        pole_overdesign_factor=1.0,
    )


# =============================================================================
# INPUT d_st = 1 — Act Disaster Prevention
# Pole + Direct Object + OHW; no Arm.
# Required condition: structure height, Area Density Code, and k_value.
# =============================================================================
def build_d_st_1_input() -> ManualScenario:
    return _build_act_standard_input(
        design_standard=1,
        title="Act Disaster Prevention - VBA comparison case",
    )


# =============================================================================
# INPUT d_st = 2 — Fixed Wind Disaster Prevention
# Pole + Direct Object + OHW; no Arm.
# Required: structure height and k_value. Wind speed may be supplied; otherwise
# the standard default is used.
# =============================================================================
def build_d_st_2_input() -> ManualScenario:
    # TODO: Replace this guard with ManualScenario(...) after VBA input arrives.
    return _not_configured(2)


# =============================================================================
# INPUT d_st = 3 — Old Lighting Pole
# Pole + Direct Object + OHW + optional Arm.
# No seismic by default. Straight 90°, optionally oblique 45°.
# Case 3 reference: Pole + Arm + Arm Object + OHW.
# =============================================================================
def build_d_st_3_input() -> ManualScenario:
    # PoleObject.top_elevation_m is cumulative. Pole-2 is the 0.1 m lower
    # straight segment; Pole-1 is the 10.0 m taper segment above it.
    poles = (
        PoleObject(
            name="Pole-2",
            pole_type="Straight",
            diameter_lower_mm=175,
            diameter_upper_mm=175,
            thickness_lower_mm=4,
            thickness_upper_mm=4,
            material="STK400",
            top_elevation_m=0.1,
        ),
        PoleObject(
            name="Pole-1",
            pole_type="Taper",
            diameter_lower_mm=175,
            diameter_upper_mm=75,
            thickness_lower_mm=4,
            thickness_upper_mm=4,
            material="STK400",
            top_elevation_m=10.1,
        ),
    )
    overhead_wires = (
        OverheadWire(
            name="OHW-1",
            mass_per_length_kg_m=0.19,
            diameter_mm=11.5,
            elevation_m=6,
            span_length_m=10,
            sag_ratio_percent=3,
            base_wind_coefficient=1.0,
            fixed_angle_deg=0,
            vertical_angle_deg=0,
        ),
    )

    # Arm Object has no independent Fix Angle. It inherits its Arm Fix Angle.
    arm_assembly = ArmAssembly(
        arm_parts=(
            ArmPart(
                arm=Arm(
                    name="Arm-1",
                    arm_type="SingleRoundStraight",
                    material="STK400",
                    diameter_mm=60.5,
                    thickness_mm=3.8,
                    total_length_m=0.18,
                    exposed_length_m=0.18,
                    installation_height_m=10.1,
                    fixed_angle_deg=0,
                ),
                mounted_objects=(
                    ArmLoadObject(
                        name="AO-11",
                        object_type="Omni",
                        front_area_m2=0.13,
                        side_area_m2=0.13,
                        mass_per_unit_kg=14,
                        horizontal_load_distance_m=0.18,
                        base_wind_coefficient=1.0,
                        quantity=1,
                    ),
                ),
            ),
        )
    )
    return ManualScenario(
        design_standard=3,
        title="Old Lighting Pole - Case 3 Pole + Arm + AO + OHW",
        evaluated_positions_m=(0.0,),
        structure_height_m=10.1,
        poles=poles,
        overhead_wires=overhead_wires,
        arm_assembly=arm_assembly,
        pole_overdesign_factor=1.0,
        include_oblique_wind=False,
    )


# =============================================================================
# INPUT d_st = 4 — Small Sign Board
# Pole + Direct Object + OHW; no Arm.
# No seismic by default. Straight 90°, optionally oblique 45°.
# =============================================================================
def build_d_st_4_input() -> ManualScenario:
    # TODO: Replace this guard with ManualScenario(...) after VBA input arrives.
    return _not_configured(4)


# =============================================================================
# INPUT d_st = 5 — Large Sign Board
# Pole + Direct Object + OHW + required ArmAssembly.
# Straight 90° and oblique 45°; no seismic by default.
# =============================================================================
def build_d_st_5_input() -> ManualScenario:
    # TODO: Replace this guard with ManualScenario(...) after VBA input arrives.
    return _not_configured(5)


# =============================================================================
# INPUT d_st = 6 — Act Tower
# Pole + Direct Object + OHW; no Arm.
# Required condition: structure height, Area Density Code, and k_value.
# =============================================================================
def build_d_st_6_input() -> ManualScenario:
    return _build_act_standard_input(
        design_standard=6,
        title="Act Tower - VBA comparison case",
    )


# =============================================================================
# INPUT d_st = 7 — New JIL
# Pole + Direct Object + OHW + required ArmAssembly; eight wind directions.
# Seismic uses mass × EQa × EQr and significant-figure rounding.
# =============================================================================
def build_d_st_7_input() -> ManualScenario:
    poles = (
        PoleObject(
            name="Pole-3",
            pole_type="Straight",
            diameter_lower_mm=175,
            diameter_upper_mm=175,
            thickness_lower_mm=4,
            thickness_upper_mm=4,
            material="STK400",
            top_elevation_m=1.6,
        ),
        PoleObject(
            name="Pole-2",
            pole_type="Taper",
            diameter_lower_mm=175,
            diameter_upper_mm=75,
            thickness_lower_mm=4,
            thickness_upper_mm=4,
            material="STK400",
            top_elevation_m=7.6,
        ),
        PoleObject(
            name="Pole-1",
            pole_type="Straight",
            diameter_lower_mm=75,
            diameter_upper_mm=75,
            thickness_lower_mm=4,
            thickness_upper_mm=4,
            material="STK400",
            top_elevation_m=10.1,
        ),
    )
    overhead_wires = (
        OverheadWire(
            name="OHW-1 DV3.2-2C",
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
    arm_assembly = ArmAssembly(
        arm_parts=(
            ArmPart(
                arm=Arm(
                    name="Arm-1",
                    arm_type="SingleRoundStraight",
                    material="STK400",
                    diameter_mm=60.5,
                    thickness_mm=3.8,
                    total_length_m=0.18,
                    exposed_length_m=0.18,
                    installation_height_m=10.0,
                    fixed_angle_deg=0,
                ),
                mounted_objects=(
                    ArmLoadObject(
                        name="AO-1",
                        object_type="Directional",
                        front_area_m2=0.1,
                        side_area_m2=0.1,
                        mass_per_unit_kg=14,
                        horizontal_load_distance_m=0.18,
                        base_wind_coefficient=1.0,
                        quantity=1,
                    ),
                ),
            ),
        )
    )
    return ManualScenario(
        design_standard=7,
        title="New JIL - Pole + Arm + AO + OHW",
        evaluated_positions_m=(7.6, 0.0),
        structure_height_m=10.1,
        poles=poles,
        overhead_wires=overhead_wires,
        arm_assembly=arm_assembly,
        pole_overdesign_factor=1.0,
        eqa_m_s2=4.71,
        eqr=1.0,
    )


# =============================================================================
# INPUT d_st = 9 — Old Traffic Signal
# Pole + Direct Object + OHW + required ArmAssembly; eight wind directions.
# Decimal rounding and no seismic by default.
# =============================================================================
def build_d_st_9_input() -> ManualScenario:
    # TODO: Replace this guard with ManualScenario(...) after VBA input arrives.
    return _not_configured(9)


SCENARIO_BUILDERS = {
    1: build_d_st_1_input,
    2: build_d_st_2_input,
    3: build_d_st_3_input,
    4: build_d_st_4_input,
    5: build_d_st_5_input,
    6: build_d_st_6_input,
    7: build_d_st_7_input,
    9: build_d_st_9_input,
}


def build_workflow(scenario: ManualScenario):
    """Create the correct workflow for the selected standard."""
    if scenario.design_standard in {1, 2, 6}:
        if not scenario.poles:
            raise ValueError(
                "Pole wajib tersedia untuk menentukan structure_height_m"
            )
        structure_height_m = max(
            pole.top_elevation_m for pole in scenario.poles
        )
    else:
        if scenario.structure_height_m is None:
            raise ValueError(
                f"structure_height_m wajib diisi untuk d_st = "
                f"{scenario.design_standard}"
            )
        structure_height_m = scenario.structure_height_m

    standard = DesignStandardFactory.create(
        design_standard=scenario.design_standard,
        structure_height_m=structure_height_m,
        area_density_code=scenario.area_density_code,
        basic_wind_speed_m_s=scenario.basic_wind_speed_m_s,
        k_value=scenario.k_value,
        eqa_m_s2=scenario.eqa_m_s2,
        eqr=scenario.eqr,
        enable_optional_seismic=scenario.enable_optional_seismic,
        include_oblique_wind=scenario.include_oblique_wind,
    )
    common = {
        "design_standard": standard,
        "pole_assembly": PoleAssembly(
            scenario.poles,
            base_elevation_m=scenario.base_elevation_m,
        ),
        "direct_objects": scenario.direct_objects,
        "overhead_wires": scenario.overhead_wires,
        "overdesign_factor": OverdesignFactor(
            value=scenario.pole_overdesign_factor
        ),
    }

    if scenario.design_standard in {1, 2, 6}:
        if scenario.k_value is None:
            raise ValueError(
                f"k_value wajib diisi untuk d_st = {scenario.design_standard}"
            )
        return Standard126CalculationWorkflow(
            **common,
            seismic_condition=SeismicCondition.ground(scenario.k_value),
        )

    if scenario.design_standard in {3, 4}:
        return Standard34CalculationWorkflow(
            **common,
            arm_assembly=scenario.arm_assembly,
        )

    if scenario.arm_assembly is None:
        raise ValueError(
            f"arm_assembly wajib diisi untuk d_st = {scenario.design_standard}"
        )

    workflow_by_standard = {
        5: Standard5CalculationWorkflow,
        7: Standard7CalculationWorkflow,
        9: Standard9CalculationWorkflow,
    }
    return workflow_by_standard[scenario.design_standard](
        **common,
        arm_assembly=scenario.arm_assembly,
    )


def print_calculation_result(scenario: ManualScenario, result) -> None:
    """Print calculation values for comparison, without report selection."""
    evaluated = getattr(result, "evaluated_position_result", result)
    print()
    print("=" * 100)
    print(
        f"d_st = {scenario.design_standard} | {scenario.title} | "
        f"EvaluatedPosition = {evaluated.evaluated_position_m:.3f} m"
    )
    print("=" * 100)
    section = evaluated.section_properties
    print("\nSECTION")
    print(f"  Pole                 : {evaluated.evaluated_pole_name}")
    print(f"  Material             : {evaluated.material_name}")
    print(f"  Diameter             : {section.diameter_mm:.3f} mm")
    print(f"  Thickness            : {section.thickness_mm:.3f} mm")
    print(f"  Cross-section area   : {section.cross_section_area_cm2:.3f} cm2")
    print(f"  Moment of inertia    : {section.moment_of_inertia_cm4:.3f} cm4")
    print(f"  Radius of gyration   : {section.radius_of_gyration_cm:.3f} cm")
    print(f"  Section modulus      : {section.section_modulus_cm3:.3f} cm3")

    print("\nTOTAL LOAD")
    print(f"  FixLoad              : {evaluated.total_fix_load_n:.3f} N")
    if hasattr(evaluated, "total_seismic_load_n"):
        print(f"  Seismic load         : {evaluated.total_seismic_load_n:.3f} N")
        print(f"  Seismic moment       : {evaluated.total_seismic_moment_nm:.3f} N.m")

    print("\nOBJECT GROUP AGGREGATION")
    aggregations = (
        ("Pole", result.pole_aggregation, "pole_results"),
        ("Direct Object", result.direct_object_aggregation, "direct_object_results"),
        ("OHW", result.overhead_wire_aggregation, "wire_results"),
        ("Arm", getattr(result, "arm_aggregation", None), "arm_results"),
    )
    for name, aggregation, items_attribute in aggregations:
        if aggregation is None:
            print(f"  {name:<14}: not used")
            continue
        items = getattr(aggregation, items_attribute)
        fix_load = getattr(aggregation, "total_fix_load_n", 0.0)
        seismic = getattr(aggregation, "total_seismic_load_n", 0.0)
        print(
            f"  {name:<14}: count={len(items)}, "
            f"FixLoad={fix_load:.3f} N, Seismic={seismic:.3f} N"
        )

    directions = getattr(result, "direction_results", None)
    if directions is None:
        directions = evaluated.directional_results

    print("\nDIRECTION RESULTS")
    for item in directions:
        name = getattr(item, "wind_case_name", getattr(item, "direction", "?"))
        angle_deg = getattr(item, "wind_direction_deg", None)
        angle_text = "" if angle_deg is None else f" ({angle_deg:.0f} deg)"
        wind = getattr(
            item,
            "resultant_wind_load_n",
            getattr(item, "total_wind_load_n", 0.0),
        )
        moment = getattr(item, "combined_wind_moment_nm", 0.0)
        torque = getattr(item, "wind_torsional_moment_nm", None)
        text = (
            f"  {name}{angle_text}: Wind={wind:.3f} N, "
            f"Moment={moment:.3f} N.m"
        )
        if torque is not None:
            text += f", Torque={torque:.3f} N.m"
        bending = getattr(item, "bending_stress", None)
        if bending is not None:
            text += (
                f", Stress={bending.bending_stress_n_mm2:.3f} N/mm2, "
                f"Utilization={bending.safety_factor:.3f}, "
                f"Status={bending.status}"
            )
        print(text)

    arm = getattr(result, "arm_aggregation", None)
    if arm is not None and arm.arm_results:
        print("\nARM SAFETY")
        for item in arm.arm_results:
            safety = item.wind_combination_safety
            print(
                f"  {item.arm_name}: Z={item.installation_height_m:.3f} m, "
                f"FixMoment={item.total_fix_load_moment_at_arm_support_nm:.3f} N.m, "
                f"WindMoment={item.total_wind_moment_at_arm_support_nm:.3f} N.m, "
                f"Stress={safety.bending_stress_n_mm2:.3f} N/mm2, "
                f"Utilization={safety.utilization_ratio:.3f}, "
                f"Status={safety.status}"
            )

    stress_result = getattr(result, "stress_result", None)
    if stress_result is not None:
        print("\nSTRESS RESULT")
        pprint(stress_result, sort_dicts=False, width=140)


def run_manual_check(selected_d_st: int = SELECTED_D_ST) -> None:
    """Run only the selected standard and all its evaluated positions."""
    try:
        builder = SCENARIO_BUILDERS[int(selected_d_st)]
    except (KeyError, ValueError, TypeError):
        supported = ", ".join(str(code) for code in SCENARIO_BUILDERS)
        raise ValueError(f"SELECTED_D_ST harus salah satu dari: {supported}") from None

    scenario = builder()
    workflow = build_workflow(scenario)
    results = CalculationService(workflow).calculate(
        scenario.evaluated_positions_m
    )
    for result in results:
        print_calculation_result(scenario, result)


def build_manual_output(selected_d_st: int = SELECTED_D_ST):
    """Build the standard-controlled backend output for a manual scenario."""
    try:
        builder = SCENARIO_BUILDERS[int(selected_d_st)]
    except (KeyError, ValueError, TypeError):
        supported = ", ".join(str(code) for code in SCENARIO_BUILDERS)
        raise ValueError(f"SELECTED_D_ST harus salah satu dari: {supported}") from None

    scenario = builder()
    results = CalculationService(build_workflow(scenario)).calculate(
        scenario.evaluated_positions_m
    )
    mapper = StandardOutputMapperFactory.create(scenario.design_standard)
    if scenario.design_standard == 3:
        return mapper.map(
            Standard3OutputSource(
                calculation_results=results,
                poles=scenario.poles,
                direct_objects=scenario.direct_objects,
                overhead_wires=scenario.overhead_wires,
                arm_assembly=scenario.arm_assembly,
            )
        )
    return mapper.map()


def print_manual_output_json(selected_d_st: int = SELECTED_D_ST) -> None:
    """Print the selected standard output as backend-ready JSON."""
    print(
        json.dumps(
            build_manual_output(selected_d_st).to_dict(),
            ensure_ascii=False,
            indent=2,
        )
    )


if __name__ == "__main__":
    try:
        run_manual_check()
    except ManualInputNotConfiguredError as error:
        print(error)
