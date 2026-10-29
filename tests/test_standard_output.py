"""Tests for standard-controlled backend output mapping."""

import json
import unittest

from application.output import StandardOutputMapperFactory
from application.output.standard_3 import (
    _legacy_limit_text,
    _legacy_status_text,
)
from manual_check import build_manual_output


class StandardOutputFactoryTests(unittest.TestCase):
    def test_deferred_standards_return_explicit_empty_skeletons(self):
        for standard in (1, 2, 4, 5, 6, 7, 9):
            with self.subTest(standard=standard):
                output = StandardOutputMapperFactory.create(standard).map()
                self.assertEqual(output.design_standard, standard)
                self.assertEqual(output.status, "NOT_IMPLEMENTED")
                self.assertEqual(output.evaluated_positions, ())
                self.assertIsNone(output.numbered_output)

    def test_standard_eight_is_explicitly_unavailable(self):
        with self.assertRaisesRegex(NotImplementedError, "Haiden Kitei"):
            StandardOutputMapperFactory.create(8)


class Standard3OutputMapperTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.output = build_manual_output(3)
        cls.value = cls.output.to_dict()

    def test_output_is_ready_and_json_serializable(self):
        self.assertEqual(self.output.design_standard, 3)
        self.assertEqual(self.output.status, "READY")
        json.dumps(self.value)

    def test_dynamic_collections_follow_manual_input(self):
        self.assertEqual(len(self.output.overhead_wires), 1)
        self.assertEqual(len(self.output.arms), 1)
        self.assertEqual(len(self.output.arms[0]["objects"]), 2)
        self.assertEqual(len(self.output.evaluated_positions), 1)
        self.assertEqual(
            len(self.output.evaluated_positions[0]["load_rows"]),
            4,
        )

    def test_numbered_mapping_contains_every_pdf_slot(self):
        self.assertEqual(set(self.output.numbered_output), set(range(1, 105)))
        expected = {
            1: 60.0,
            2: 1.23,
            3: 2214.0,
            20: 9.03,
            29: 146.7,
            40: 304.8,
            41: 25.5,
            42: 53.3,
            43: 59.1,
            47: 0.028,
            48: "< 1.0",
            49: "・・・O.K",
            53: 89.81,
            70: 1343.4,
            91: 2398.4,
            92: 25.5,
            94: 6382.8,
            95: 13992.1,
            96: 155.8,
            99: 0.663,
            100: "< 1.0",
            101: "・・・O.K",
            102: 1343.4,
            103: 2623.7,
            104: 13992.1,
        }
        for number, value in expected.items():
            with self.subTest(number=number):
                self.assertEqual(self.output.numbered_output[number], value)

    def test_semantic_keys_always_include_units(self):
        position = self.output.evaluated_positions[0]
        self.assertEqual(position["evaluated_position_m"], 0.0)
        self.assertEqual(position["totals"]["combined_moment_nm"], 13992.1)
        self.assertEqual(position["totals"]["bending_stress_n_mm2"], 155.8)

    def test_legacy_comparison_and_status_text_support_ok_and_ng(self):
        self.assertEqual(_legacy_limit_text("OK"), "< 1.0")
        self.assertEqual(_legacy_status_text("OK"), "・・・O.K")
        self.assertEqual(_legacy_limit_text("NG"), "> 1.0")
        self.assertEqual(_legacy_status_text("NG"), "・・・N.G")


if __name__ == "__main__":
    unittest.main()
