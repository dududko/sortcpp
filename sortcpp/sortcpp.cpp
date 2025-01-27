#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include "src/sortcpp.h"

namespace py = pybind11;

void bind(pybind11::module& m) {
    m.def("sort_array", &sort_array, "A function that sorts an array of integers");
}

PYBIND11_MODULE(_sortcpp, m) {
    bind(m);
}
