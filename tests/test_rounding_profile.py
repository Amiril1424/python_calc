"""Tests for calculated-result precision mapping."""

import unittest

from calculation.rounding import (
    CalculationValueType,
    rounding_profile_for,
)


class CalculationRoundingProfileTests(unittest.TestCase):
    def test_decimal_profile_uses_confirmed_digits(self):
        profile = rounding_profile_for(3)

        self.assertEqual(
            profile.apply(165.256, CalculationValueType.CALCULATED_POLE_DIAMETER),
            165.3,
        )
        self.assertEqual(
            profile.apply(1.23456, CalculationValueType.PROJECTED_AREA),
            1.235,
        )
        self.assertEqual(
            profile.apply(1234.56, CalculationValueType.WIND_PRESSURE),
            1235.0,
        )
        self.assertEqual(
            profile.apply(123.456, CalculationValueType.LOAD),
            123.5,
        )
        self.assertEqual(
            profile.apply(0.123456, CalculationValueType.SAFETY_FACTOR),
            0.123,
        )

    def test_decimal_load_center_height_is_not_rounded(self):
        profile = rounding_profile_for(3)

        self.assertEqual(
            profile.apply(1.23456789, CalculationValueType.LOAD_CENTER_HEIGHT),
            1.23456789,
        )

    def test_new_jil_profile_uses_confirmed_significant_figures(self):
        profile = rounding_profile_for(7)

        self.assertEqual(
            profile.apply(165.256, CalculationValueType.CALCULATED_POLE_DIAMETER),
            165.3,
        )
        self.assertEqual(
            profile.apply(1.23456, CalculationValueType.LOAD_CENTER_HEIGHT),
            1.23,
        )
        self.assertEqual(
            profile.apply(1.23456, CalculationValueType.PROJECTED_AREA),
            1.23,
        )
        self.assertEqual(
            profile.apply(1234.56, CalculationValueType.WIND_PRESSURE),
            1235.0,
        )
        self.assertEqual(
            profile.apply(123.456, CalculationValueType.LOAD),
            123.0,
        )
        self.assertEqual(
            profile.apply(12.3456, CalculationValueType.WIRE_LOAD_COMBINATION),
            12.35,
        )
        self.assertEqual(
            profile.apply(0.123456, CalculationValueType.STRESS),
            0.123,
        )

    def test_input_has_no_rounding_category(self):
        self.assertNotIn(
            "input",
            {value_type.value for value_type in CalculationValueType},
        )


if __name__ == "__main__":
    unittest.main()
