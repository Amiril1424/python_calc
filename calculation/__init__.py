"""Calculation services for the structural calculation engine."""

from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from .standard_126_workflow import Standard126CalculationWorkflow
    from .standard_34_workflow import Standard34CalculationWorkflow


def __getattr__(name: str) -> Any:
    """Load complete workflows only when explicitly requested."""
    if name == "Standard126CalculationWorkflow":
        from .standard_126_workflow import Standard126CalculationWorkflow

        return Standard126CalculationWorkflow
    if name == "Standard34CalculationWorkflow":
        from .standard_34_workflow import Standard34CalculationWorkflow

        return Standard34CalculationWorkflow
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")

__all__ = [
    "Standard126CalculationWorkflow",
    "Standard34CalculationWorkflow",
]

