import unittest

import numpy as np
import numpy.testing as npt

class TestServer(unittest.TestCase):
    def test_sort_array(self):
        arr = np.array([1, 3, 2])
        arr.sort()
        npt.assert_array_equal(arr, [1, 2, 3])


if __name__ == "__main__":
    unittest.main()