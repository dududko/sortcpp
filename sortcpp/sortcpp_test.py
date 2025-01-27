import unittest
from sortcpp._sortcpp import sort_array

class TestSortArray(unittest.TestCase):
    def test_handles_already_sorted_array(self):
        input_array = [1, 2, 3, 4, 5]
        expected = [1, 2, 3, 4, 5]
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_reverse_sorted_array(self):
        input_array = [5, 4, 3, 2, 1]
        expected = [1, 2, 3, 4, 5]
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_array_with_duplicates(self):
        input_array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        expected = [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_empty_array(self):
        input_array = []
        expected = []
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_single_element_array(self):
        input_array = [42]
        expected = [42]
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_array_with_negative_numbers(self):
        input_array = [-3, -1, -4, -1, -5, -9, -2, -6, -5, -3, -5]
        expected = [-9, -6, -5, -5, -5, -4, -3, -3, -2, -1, -1]
        self.assertEqual(sort_array(input_array), expected)

    def test_handles_mixed_positive_and_negative_numbers(self):
        input_array = [-3, 1, -4, 1, 5, -9, 2, 6, -5, 3, 5]
        expected = [-9, -5, -4, -3, 1, 1, 2, 3, 5, 5, 6]
        self.assertEqual(sort_array(input_array), expected)

if __name__ == "__main__":
    unittest.main(verbosity=2)
