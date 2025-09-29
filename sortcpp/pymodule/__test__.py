import unittest

import numpy as np
import numpy.testing as npt
import pandas as pd

class TestServer(unittest.TestCase):
    def test_sort_array(self):
        arr = np.array([1, 3, 2])
        arr.sort()
        npt.assert_array_equal(arr, [1, 2, 3])

    def test_pandas_sort_series(self):
        s = pd.Series([1, 3, 2])
        s_sorted = s.sort_values(ignore_index=True)
        npt.assert_array_equal(s_sorted.to_numpy(), np.array([1, 2, 3]))

if __name__ == "__main__":
    unittest.main()