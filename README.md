# sortcpp

Bazel, C++ and pybind11 sample with c++ tests, python tests and python wheel packaging.

Inspired by [Mizux/bazel-pybind11](https://github.com/Mizux/bazel-pybind11)

## Prerequisites

* [Bazelisk](https://github.com/bazelbuild/bazelisk?tab=readme-ov-file#installation)

## How to use:
### Test

Test all targets
```
bazel test //...
```

Test individual targets
```
bazel test //sortcpp/src:sortcpp_test
bazel test //sortcpp:sortcpp_test
```

To see stdout check the log files or use bazel run
```
bazel run //sortcpp/src:sortcpp_test
bazel run //sortcpp:sortcpp_test
```

### Build

To build all targets in the workspace
```
bazel build //...
```

### Build python wheel 
```
bazel build //sortcpp:wheel
tar tvf $(bazel cquery //sortcpp:wheel --output files 2>/dev/null)
```

### Install python wheel
```
bazel build //sortcpp:wheel
tar tvf $(bazel cquery //sortcpp:wheel --output files 2>/dev/null)
pip install $(bazel cquery //src/python:wheel --output files 2>/dev/null) --force-reinstall
```

### How to use the installed python package
```
from sortcpp import sort_array
sort_array([9, 5, 3])
sort_array([9, -1, 10, 0, 3])
```

### Build in docker

```
docker run \
  --platform linux/amd64 \
  --entrypoint /bin/bash \
  -v "$(pwd)":/src/workspace \
  -v /tmp/build_output:/tmp/build_output \
  -w /src/workspace \
  gcr.io/bazel-public/bazel:8.0.1 \
  -c "bazel build //... && bazel test //... && bazel build //sortcpp:wheel"
```



## Other examples on how to build python wheels

- Pybind11 + cmake + bazel + gtest
https://github.com/Mizux/bazel-pybind11/tree/main

- bazel
https://github.com/tensorflow/tensorflow

- Pybind11 + cmake + Scikit Build (invokes cmake under the hood)
https://github.com/scikit-build/scikit-build-sample-projects/tree/main/projects/hello-pybind11

- pybind + cmake + pypa/cibuildwheel (build python wheels for multiple target platforms)
https://github.com/pybind/cmake_example

- cpp con with presentation on python bindings
https://www.youtube.com/watch?v=rB7c69Z5Kus

- nanobind
https://nanobind.readthedocs.io/en/latest/