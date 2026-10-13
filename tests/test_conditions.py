"""Tests for confirmed wind and seismic condition rules."""

import unittest

from domain.conditions import SeismicCondition, WindCondition


class WindConditionTests(unittest.TestCase):
    def test_fixed_standard_pressures_follow_vba(self):
        self.assertEqual(WindCondition(2, 10).wind_pressure_at(10), 2214.0)
        self.assertEqual(WindCondition(3, 10).wind_pressure_at(10), 2214.0)
        self.assertEqual(WindCondition(4, 10).wind_pressure_at(10), 984.0)
        self.assertEqual(WindCondition(5, 10).wind_pressure_at(10), 1537.5)

    def test_standard_six_applies_minimum_pressure(self):
        condition = WindCondition(
            design_standard=6,
            structure_height_m=40,
            atmospheric_category=2,
            basic_wind_speed_m_s=1,
        )

        self.assertEqual(condition.wind_pressure_at(10), 2350.0)

    def test_kz_uses_each_pole_top_elevation(self):
        condition = WindCondition(
            design_standard=1,
            structure_height_m=40,
            atmospheric_category=2,
            basic_wind_speed_m_s=60,
        )

        self.assertNotEqual(condition.kz_at(10), condition.kz_at(27))

    def test_wind_direction_order_matches_vba(self):
        condition = WindCondition(2, 10)

        self.assertEqual(
            [direction.name for direction in condition.directions],
            ["N", "S", "E", "W", "NE", "SW", "NW", "SE"],
        )


class SeismicConditionTests(unittest.TestCase):
    def test_ground_uses_input_k_value(self):
        self.assertEqual(SeismicCondition.ground(0.5).k_value, 0.5)

    def test_rooftop_uses_class_k_value(self):
        self.assertEqual(SeismicCondition.rooftop("A").k_value, 1.5)
        self.assertEqual(SeismicCondition.rooftop("B").k_value, 1.0)
        self.assertEqual(SeismicCondition.rooftop("S").k_value, 2.0)


if __name__ == "__main__":
    unittest.main()
