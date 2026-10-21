"""Application service coordinating a complete structural calculation."""

from collections.abc import Iterable

from calculation.result import (
    Standard126CalculationResult,
    Standard34CalculationResult,
)
from calculation.standard_126_workflow import Standard126CalculationWorkflow
from calculation.standard_34_workflow import Standard34CalculationWorkflow


class CalculationService:
    """Provide one framework-independent entry point to the engine."""

    def __init__(
        self,
        workflow: Standard126CalculationWorkflow | Standard34CalculationWorkflow,
    ) -> None:
        if not isinstance(
            workflow,
            (Standard126CalculationWorkflow, Standard34CalculationWorkflow),
        ):
            raise TypeError(
                "workflow must be a supported standard calculation workflow"
            )
        self.workflow = workflow

    def calculate(
        self,
        evaluated_positions_m: Iterable[float],
    ) -> tuple[
        Standard126CalculationResult | Standard34CalculationResult,
        ...,
    ]:
        """Calculate each requested EvaluatedPosition in supplied order."""
        positions = tuple(float(position) for position in evaluated_positions_m)
        if not positions:
            raise ValueError("At least one EvaluatedPosition is required")
        return tuple(
            self.workflow.calculate_at(position) for position in positions
        )

