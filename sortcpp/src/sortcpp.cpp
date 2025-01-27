#include "sortcpp.h"
#include <algorithm> // for std::sort
#include <vector>

std::vector<int> sort_array(std::vector<int> arr) {
    // Use std::sort to sort the array
    std::sort(arr.begin(), arr.end());
    return arr;
}