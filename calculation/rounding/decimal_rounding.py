"""Ordinary decimal-place rounding used by non-New-JIL standards."""

from decimal import Decimal

from .base import RoundingPolicy


class DecimalRoundingPolicy(RoundingPolicy):
    """Round using decimal places, preserving the engine's Python behaviour."""

    def apply(
        self,
        value: int | float | Decimal,
        precision: int,
    ) -> float:
        """Return ``value`` rounded to ``precision`` decimal places."""
        if isinstance(precision, bool) or not isinstance(precision, int):
            raise ValueError("Decimal precision must be a non-negative integer")
        if precision < 0:
            raise ValueError("Decimal precision must be a non-negative integer")
        if isinstance(value, bool):
            raise TypeError("Value must be a real number, not bool")

        try:
            rounded_value = round(value, precision)
        except (TypeError, ValueError):
            raise TypeError("Value must be a real number") from None
        return float(rounded_value)
