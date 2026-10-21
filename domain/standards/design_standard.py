"""Immutable aggregate of policies for one design standard."""

from dataclasses import dataclass

from calculation.rounding import RoundingPolicy
from calculation.seismic import SeismicPolicy
from calculation.stress import StressPolicy
from calculation.wind import WindCasePolicy, WindPressurePolicy

from .codes import DesignStandardCode
from .features import CalculationFeatures


@dataclass(frozen=True)
class DesignStandard:
    """Complete policy configuration consumed by calculation services."""

    code: DesignStandardCode
    name: str
    features: CalculationFeatures
    wind_pressure_policy: WindPressurePolicy
    wind_case_policy: WindCasePolicy
    seismic_policy: SeismicPolicy
    stress_policy: StressPolicy
    rounding_policy: RoundingPolicy
