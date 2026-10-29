"""Factory selecting an output mapper independently from calculation."""

from domain.standards import DesignStandardCode

from .models import SkeletonStandardOutput
from .standard_3 import Standard3OutputMapper


_STANDARD_NAMES = {
    1: "Act Disaster Prevention",
    2: "Fixed Wind Disaster Prevention",
    3: "Old Lighting Pole",
    4: "Small Sign Board",
    5: "Large Sign Board",
    6: "Act Tower",
    7: "New JIL",
    9: "Old Traffic Signal",
}


class SkeletonStandardOutputMapper:
    """Return a visible placeholder instead of silently using another map."""

    def __init__(self, design_standard: DesignStandardCode) -> None:
        self.design_standard = design_standard

    def map(self, source=None) -> SkeletonStandardOutput:
        return SkeletonStandardOutput(
            design_standard=int(self.design_standard),
            design_standard_name=_STANDARD_NAMES[int(self.design_standard)],
        )


class StandardOutputMapperFactory:
    """Select one report/output mapper by design-standard identity."""

    @staticmethod
    def create(design_standard: int | DesignStandardCode):
        standard = DesignStandardCode(design_standard)
        if standard is DesignStandardCode.HAIDEN_KITEI:
            raise NotImplementedError(
                "Output mapping has not been prepared for Haiden Kitei "
                "(d_st = 8)"
            )
        if standard is DesignStandardCode.OLD_LIGHTING_POLE:
            return Standard3OutputMapper()
        return SkeletonStandardOutputMapper(standard)
