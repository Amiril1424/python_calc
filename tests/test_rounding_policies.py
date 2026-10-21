"""Tests for design-standard rounding policies."""

import unittest
from decimal import Decimal

from calculation.rounding import (
    DecimalRoundingPolicy,
    RoundingPolicy,
    SignificantFigureRoundingPolicy,
    rounding_policy_for,
)
from calculation.significant_figure import SignificantFigureRounder
from domain.standards import DesignStandardCode


class DecimalRoundingPolicyTests(unittest.TestCase):
    def setUp(self):
        self.policy = DecimalRoundingPolicy()

    def test_rounds_by_decimal_places(self):
        self.assertEqual(self.policy(123.4567, 2), 123.46)
        self.assertEqual(self.policy(-123.4567, 2), -123.46)
        self.assertEqual(self.policy(0.001234, 4), 0.0012)
        self.assertEqual(self.policy(987654.321, 0), 987654.0)
        self.assertEqual(self.policy(0, 3), 0.0)

    def test_accepts_decimal_value(self):
        self.assertEqual(self.policy(Decimal("12.3456"), 3), 12.346)

    def test_rejects_invalid_decimal_precision(self):
        for precision in (-1, 2.5, True):
            with self.subTest(precision=precision):
                with self.assertRaises(ValueError):
                    self.policy(1.234, precision)


class SignificantFigureRoundingPolicyTests(unittest.TestCase):
    def setUp(self):
        self.policy = SignificantFigureRoundingPolicy()

    def test_matches_existing_vba_compatible_rounder(self):
        for value, significant_figures in (
            (1234.56, 3),
            (-1234.56, 3),
            (0.012345, 4),
            (987654.0, 2),
            (0.0, 4),
        ):
            with self.subTest(
                value=value,
                significant_figures=significant_figures,
            ):
                self.assertEqual(
                    self.policy(value, significant_figures),
                    SignificantFigureRounder(significant_figures)(value),
                )

    def test_exact_half_keeps_vba_tie_to_even_rule(self):
        self.assertEqual(self.policy(1.25, 2), 1.2)
        self.assertEqual(self.policy(1.35, 2), 1.4)
        self.assertEqual(self.policy(-1.25, 2), -1.2)
        self.assertEqual(self.policy(-1.35, 2), -1.4)


class StandardRoundingPolicyTests(unittest.TestCase):
    def test_new_jil_selects_significant_figure_policy(self):
        policy = rounding_policy_for(DesignStandardCode.NEW_JIL)

        self.assertIsInstance(policy, RoundingPolicy)
        self.assertIsInstance(policy, SignificantFigureRoundingPolicy)

    def test_other_standards_select_decimal_policy(self):
        for standard in DesignStandardCode:
            if standard is DesignStandardCode.NEW_JIL:
                continue
            with self.subTest(standard=standard):
                self.assertIsInstance(
                    rounding_policy_for(standard),
                    DecimalRoundingPolicy,
                )

    def test_haiden_kitei_has_metadata_policy_but_no_calculation(self):
        standard = DesignStandardCode.HAIDEN_KITEI

        self.assertIsInstance(
            rounding_policy_for(standard),
            DecimalRoundingPolicy,
        )
        self.assertFalse(standard.calculation_is_available)

    def test_integer_standard_code_can_select_policy(self):
        self.assertIsInstance(
            rounding_policy_for(7),
            SignificantFigureRoundingPolicy,
        )

    def test_invalid_standard_code_is_rejected(self):
        with self.assertRaises(ValueError):
            rounding_policy_for(10)


if __name__ == "__main__":
    unittest.main()
