# sortcpp

Bazel, C++ and pybind11 sample with c++ tests, python tests and python wheel packaging.

Inspired by [Mizux/bazel-pybind11](https://github.com/Mizux/bazel-pybind11)

## Features

- bazel modules
- bazelisk
- gazelle with python and cpp plugin
- pyproject + poetry + rules_python + rules_pycross
- buildifier
- usage of numpy dependancy
- supports remote build/execution

## IDE

### VS Code
- [X] **starlark** autocompletion [link](https://github.com/withered-magic/starpls)
- [X] **c++** autocompletion [link](https://github.com/hedronvision/bazel-compile-commands-extractor)
- [X] **python** autocompletion [link](./vs_code_python_autocompletion.bzl)

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

## Gazelle - Automated BUILD file generation

Gazelle automatically generates and updates BUILD.bazel files for your project. This workspace is configured with multi-language Gazelle support.

### Using Gazelle

Gazelle is configured to support Python and C++ (other languages can also be configured).

```bash
# Generate/update BUILD files for all languages (C++, Python, Go)
bazel run //:gazelle

# Check what Gazelle would change without applying (dry-run)
bazel run //:gazelle.check
```

**For C++ projects**, Gazelle will:
- Detect header and source files
- Generate appropriate `cc_library`, `cc_binary`, and `cc_test` targets
- Resolve dependencies between targets
- Support Conan dependencies when configured (TODO)

**For Python projects**, Gazelle will:
- Generate `py_library`, `py_binary`, and `py_test` targets
- Detect imports and create appropriate dependencies
- Handle package structure and module dependencies
- Integrate with Poetry/pip dependencies

The configuration is defined in [BUILD.bazel:11-16](BUILD.bazel#L11-L16).

### Adding new external Python dependencies

When adding new external Python dependencies, follow these steps:

1. **Add dependency to pyproject.toml**:
   ```toml
   [tool.poetry.dependencies]
   new-package = "^1.0.0"
   ```

2. **Update Poetry lock file**:
   ```bash
   poetry lock
   ```

3. **Generate new Bazel lock file**:
   ```bash
   bazel run //:update_poetry_lock_file
   ```

4. **Update Gazelle mappings and BUILD files**:
   ```bash
   bazel run //:gazelle
   ```

This workflow uses `rules_pycross` for cross-platform Python dependency management and Poetry for dependency resolution.


### Build in Docker

```bash
# Start interactive Docker container with Bazel
docker run --rm -it \
  --platform linux/amd64 \
  --entrypoint /bin/bash \
  -v "$(pwd)":/src/workspace \
  -v /tmp/build_output:/tmp/build_output \
  -w /src/workspace \
  gcr.io/bazel-public/bazel:8.4.1
```

Inside the container, you can use regular Bazel commands:

```bash
# Build all targets
bazel build //...

# Run tests
bazel test //...

# Build Python wheel
bazel build //sortcpp:wheel

# Use remote execution (if configured)
bazel build //... --config=cache --config=remote_amd
```

This provides a consistent Linux AMD64 environment for builds and testing.

## Remote Build and Execution

This project supports remote build and execution for faster builds through caching and distributed execution.

### Setup

Remote execution can be configured with services like [BuildBuddy](https://www.buildbuddy.io/docs/quickstart/). Setup typically takes about 10 minutes to configure.

Once configured, you can use flags like:
```bash
# Build with remote cache and execution
bazel build //... --config=cache --config=remote

# Test with remote execution
bazel test //... --config=cache --config=remote
```

### Benefits

- **Faster builds**: Distributed execution across multiple machines
- **Build caching**: Shared cache across team and CI/CD
- **Cross-platform builds**: Build for different architectures without local toolchains
- **Build insights**: Web UI for build analysis and debugging

For setup instructions, see the [BuildBuddy Quickstart Guide](https://www.buildbuddy.io/docs/quickstart/).

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
