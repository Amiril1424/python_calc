"""Arm and arm-mounted-object domain objects."""

from .loads import LoadObject


class ArmObject(LoadObject):
    """Represent one object mounted on an arm."""

    pass


class ArmAssembly(LoadObject):
    """Represent an arm and the objects attached to it."""

    pass

