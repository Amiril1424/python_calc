"""Output DTOs kept outside the engineering calculation domain."""

from dataclasses import asdict, dataclass
from typing import Any

from calculation.result import Standard34CalculationResult
from domain.arm import ArmAssembly
from domain.direct_object import DirectObject
from domain.overhead_wire import OverheadWire
from domain.pole import PoleObject


@dataclass(frozen=True)
class Standard3OutputSource:
    """Calculation results plus immutable request data needed by the report."""

    calculation_results: tuple[Standard34CalculationResult, ...]
    poles: tuple[PoleObject, ...]
    direct_objects: tuple[DirectObject, ...] = ()
    overhead_wires: tuple[OverheadWire, ...] = ()
    arm_assembly: ArmAssembly | None = None


@dataclass(frozen=True)
class Standard3Output:
    """Backend output for the confirmed d_st=3 report profile."""

    design_standard: int
    design_standard_name: str
    schema_version: str
    status: str
    conditions: dict[str, Any]
    overhead_wires: tuple[dict[str, Any], ...]
    arms: tuple[dict[str, Any], ...]
    evaluated_positions: tuple[dict[str, Any], ...]
    numbered_output: dict[int, Any]

    def to_dict(self) -> dict[str, Any]:
        """Return a JSON-ready dictionary with stable string number keys."""
        value = asdict(self)
        value["numbered_output"] = {
            str(number): item
            for number, item in self.numbered_output.items()
        }
        return value


@dataclass(frozen=True)
class SkeletonStandardOutput:
    """Explicit empty profile for a standard whose mapping is deferred."""

    design_standard: int
    design_standard_name: str
    schema_version: str = "1.0"
    status: str = "NOT_IMPLEMENTED"
    conditions: None = None
    overhead_wires: tuple = ()
    arms: tuple = ()
    evaluated_positions: tuple = ()
    numbered_output: None = None

    def to_dict(self) -> dict[str, Any]:
        return asdict(self)
