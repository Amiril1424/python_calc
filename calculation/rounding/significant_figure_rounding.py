"""Significant-figure rounding policy for New JIL calculations."""

from decimal import Decimal

from calculation.significant_figure import SignificantFigureRounder

from .base import RoundingPolicy


class SignificantFigureRoundingPolicy(RoundingPolicy):
    """Delegate rounding to the VBA-compatible significant-figure object."""

    def apply(
        self,
        value: int | float | Decimal,
        precision: int,
    ) -> float:
        """Return ``value`` rounded to ``precision`` significant figures."""
        return SignificantFigureRounder(precision).apply(value)
