"""Integration tests for the Pole calculation flow."""

import unittest

from calculation.pole_assembly import PoleAssembly
from calculation.pole_calculator import PoleCalculator
from domain.conditions import SeismicCondition, WindCondition
from domain.loads import OverdesignFactor
from domain.pole import PoleObject


class PoleCalculatorTests(unittest.TestCase):
    def setUp(self):
        self.pole = PoleObject(
            name="P1",
            pole_type="Straight",
            diameter_lower_mm=200,
            diameter_upper_mm=200,
            thickness_lower_mm=5,
            thickness_upper_mm=5,
            material="STK400",
            top_elevation_m=4,
        )
        self.calculator = PoleCalculator(
            assembly=PoleAssembly([self.pole]),
            wind_condition=WindCondition(2, 4),
            seismic_condition=SeismicCondition.ground(0.5),
        )

    def test_complete_pole_result(self):
        result = self.calculator.calculate_one(self.pole, 0)

        self.assertEqual(result.geometry.active_length_m, 4)
        self.assertEqual(result.nnc, 0.7)
        self.assertEqual(result.cf, 0.7)
        self.assertEqual(result.wind_pressure_n_m2, 2214.0)
        self.assertEqual(result.projected_area_m2, 0.8)
        self.assertEqual(result.seismic_load_n, result.fix_load_n * 0.5)
        self.assertEqual(result.wind_moment_nm, result.wind_load_n * 2)
        self.assertEqual(len(result.directional_results), 8)
        self.assertEqual(result.overdesign_factor, 1.0)

    def test_overdesign_factor_affects_fixload_and_seismic_load(self):
        base_result = self.calculator.calculate_one(self.pole, 0)
        amplified_calculator = PoleCalculator(
            assembly=PoleAssembly([self.pole]),
            wind_condition=WindCondition(2, 4),
            seismic_condition=SeismicCondition.ground(0.5),
            overdesign_factor=OverdesignFactor(1.2),
        )

        amplified_result = amplified_calculator.calculate_one(self.pole, 0)

        self.assertEqual(amplified_result.overdesign_factor, 1.2)
        self.assertAlmostEqual(
            amplified_result.fix_load_n,
            base_result.fix_load_n * 1.2,
        )
        self.assertAlmostEqual(
            amplified_result.seismic_load_n,
            base_result.seismic_load_n * 1.2,
        )

    def test_signed_xy_components_follow_vba(self):
        result = self.calculator.calculate_one(self.pole, 0)
        by_direction = {
            item.direction: item for item in result.directional_results
        }

        self.assertEqual(by_direction["E"].wind_load_x_n, -result.wind_load_n)
        self.assertEqual(by_direction["E"].wind_load_y_n, 0)
        self.assertEqual(by_direction["N"].wind_load_x_n, 0)
        self.assertEqual(by_direction["N"].wind_load_y_n, result.wind_load_n)
        self.assertEqual(
            by_direction["N"].wind_moment_x_nm,
            result.wind_moment_nm,
        )

    def test_quantity_other_than_one_is_rejected(self):
        with self.assertRaises(ValueError):
            PoleObject(
                name="P2",
                pole_type="Straight",
                diameter_lower_mm=200,
                diameter_upper_mm=200,
                thickness_lower_mm=5,
                thickness_upper_mm=5,
                material="STK400",
                top_elevation_m=4,
                quantity=2,
            )


class PoleAggregationTests(unittest.TestCase):
    def setUp(self):
        self.lower = PoleObject(
            name="Lower",
            pole_type="Straight",
            diameter_lower_mm=220,
            diameter_upper_mm=220,
            thickness_lower_mm=6,
            thickness_upper_mm=6,
            material="STK540",
            top_elevation_m=4,
        )
        self.upper = PoleObject(
            name="Upper",
            pole_type="Straight",
            diameter_lower_mm=180,
            diameter_upper_mm=180,
            thickness_lower_mm=5,
            thickness_upper_mm=5,
            material="STK400",
            top_elevation_m=10,
        )
        self.calculator = PoleCalculator(
            assembly=PoleAssembly([self.upper, self.lower]),
            wind_condition=WindCondition(2, 10),
            seismic_condition=SeismicCondition.ground(0.5),
        )

    def test_scalar_totals_equal_sum_of_active_poles(self):
        aggregate = self.calculator.aggregate_at(0)
        results = aggregate.pole_results

        self.assertEqual(len(results), 2)
        self.assertAlmostEqual(
            aggregate.total_fix_load_n,
            sum(result.fix_load_n for result in results),
        )
        self.assertAlmostEqual(
            aggregate.total_seismic_load_n,
            sum(result.seismic_load_n for result in results),
        )
        self.assertAlmostEqual(
            aggregate.total_seismic_moment_nm,
            sum(result.seismic_moment_nm for result in results),
        )

    def test_directional_totals_equal_sum_of_active_poles(self):
        aggregate = self.calculator.aggregate_at(0)
        east = next(
            item
            for item in aggregate.directional_totals
            if item.direction == "E"
        )

        self.assertAlmostEqual(
            east.total_wind_load_n,
            sum(result.wind_load_n for result in aggregate.pole_results),
        )
        self.assertAlmostEqual(
            east.total_wind_load_x_n,
            sum(
                next(
                    item.wind_load_x_n
                    for item in result.directional_results
                    if item.direction == "E"
                )
                for result in aggregate.pole_results
            ),
        )
        self.assertAlmostEqual(
            east.total_wind_moment_y_nm,
            sum(
                next(
                    item.wind_moment_y_nm
                    for item in result.directional_results
                    if item.direction == "E"
                )
                for result in aggregate.pole_results
            ),
        )

    def test_direction_signs_are_preserved_after_aggregation(self):
        aggregate = self.calculator.aggregate_at(0)
        by_direction = {
            item.direction: item for item in aggregate.directional_totals
        }

        self.assertLess(by_direction["E"].total_wind_load_x_n, 0)
        self.assertGreater(by_direction["W"].total_wind_load_x_n, 0)
        self.assertGreater(by_direction["N"].total_wind_load_y_n, 0)
        self.assertLess(by_direction["S"].total_wind_load_y_n, 0)

    def test_only_poles_above_evaluated_position_are_aggregated(self):
        aggregate = self.calculator.aggregate_at(4)

        self.assertEqual(
            [result.geometry.pole_name for result in aggregate.pole_results],
            ["Upper"],
        )

    def test_no_active_pole_returns_zero_totals(self):
        aggregate = self.calculator.aggregate_at(10)

        self.assertEqual(aggregate.pole_results, ())
        self.assertEqual(aggregate.total_fix_load_n, 0.0)
        self.assertEqual(aggregate.total_seismic_load_n, 0.0)
        self.assertEqual(aggregate.total_seismic_moment_nm, 0.0)
        self.assertEqual(len(aggregate.directional_totals), 8)
        self.assertTrue(
            all(
                item.total_wind_load_n == 0.0
                for item in aggregate.directional_totals
            )
        )


if __name__ == "__main__":
    unittest.main()
