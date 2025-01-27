#include <gtest/gtest.h>
#include "sortcpp.h"

// Test case for an already sorted array
TEST(SortArrayTest, HandlesAlreadySortedArray) {
    std::vector<int> input = {1, 2, 3, 4, 5};
    std::vector<int> expected = {1, 2, 3, 4, 5};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for a reverse-sorted array
TEST(SortArrayTest, HandlesReverseSortedArray) {
    std::vector<int> input = {5, 4, 3, 2, 1};
    std::vector<int> expected = {1, 2, 3, 4, 5};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for an array with duplicate elements
TEST(SortArrayTest, HandlesArrayWithDuplicates) {
    std::vector<int> input = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    std::vector<int> expected = {1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for an empty array
TEST(SortArrayTest, HandlesEmptyArray) {
    std::vector<int> input = {};
    std::vector<int> expected = {};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for a single-element array
TEST(SortArrayTest, HandlesSingleElementArray) {
    std::vector<int> input = {42};
    std::vector<int> expected = {42};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for an array with negative numbers
TEST(SortArrayTest, HandlesArrayWithNegativeNumbers) {
    std::vector<int> input = {-3, -1, -4, -1, -5, -9, -2, -6, -5, -3, -5};
    std::vector<int> expected = {-9, -6, -5, -5, -5, -4, -3, -3, -2, -1, -1};
    EXPECT_EQ(sort_array(input), expected);
}

// Test case for an array with mixed positive and negative numbers
TEST(SortArrayTest, HandlesMixedPositiveAndNegativeNumbers) {
    std::vector<int> input = {-3, 1, -4, 1, 5, -9, 2, 6, -5, 3, 5};
    std::vector<int> expected = {-9, -5, -4, -3, 1, 1, 2, 3, 5, 5, 6};
    EXPECT_EQ(sort_array(input), expected);
}