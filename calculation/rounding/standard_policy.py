"""Select a rounding policy from a design-standard identity."""

from domain.standards.codes import DesignStandardCode

from .base import RoundingPolicy
from .decimal_rounding import DecimalRoundingPolicy
from .significant_figure_rounding import SignificantFigureRoundingPolicy


_DECIMAL_ROUNDING = DecimalRoundingPolicy()
_SIGNIFICANT_FIGURE_ROUNDING = SignificantFigureRoundingPolicy()


def rounding_policy_for(
    design_standard: int | DesignStandardCode,
) -> RoundingPolicy:
    """Return the confirmed rounding method without running calculations."""
    standard = DesignStandardCode(design_standard)
    if standard is DesignStandardCode.NEW_JIL:
        return _SIGNIFICANT_FIGURE_ROUNDING
    return _DECIMAL_ROUNDING
