load("@rules_python//python/private:semver.bzl", "semver")

# Implementation of the repository rule
def _vs_code_python_autocompletion_repo_impl(repo_ctx):
    for k in repo_ctx.attr.pypi_dependencies:
        package = repo_ctx.attr.pypi_dependencies[k]

        # For each python package create symbolic link to the external repository
        repo_ctx.symlink(repo_ctx.path(k).get_child("../site-packages").get_child(package), package)

    # Create an empty readme file in the repository
    repo_ctx.file("readme.txt", "")

    # Generate a BUILD.bazel file
    repo_ctx.file("BUILD.bazel", """exports_files(["readme.txt"])""")

# Define the repository rule
vs_code_python_autocompletion_repo = repository_rule(
    implementation = _vs_code_python_autocompletion_repo_impl,
    doc = "Creates symbolic links to Python packages for VS Code autocompletion",
    attrs = {
        "pypi_dependencies": attr.label_keyed_string_dict(
            mandatory = True,
            doc = "A dictionary of pypi dependencies to be symlinked",
        ),
    },
)

# Implementation of the module extension
def _vs_code_python_autocompletion_impl(module_ctx):
    tags = module_ctx.modules[0].tags.requirements[0]

    # Extract the attribute values
    hub_name = tags.hub_name
    python_version = tags.python_version
    requirements_lock = module_ctx.read(tags.requirements_lock).splitlines()

    # Normalize the Python version
    python_version = semver(python_version)
    python_version = "{}{}".format(python_version.major, python_version.minor)

    deps = {}
    for line in requirements_lock:
        line = line.strip()

        # Ignore empty lines or comments or --hash lines
        if line and not line.startswith("#") and not line.startswith("--hash"):
            package = line.split("==")[0]  # Extract the package name (before '==')
            package = package.strip().replace("-", "_")  # Normalize name
            deps["@@rules_python++pip+pypi_313_" + package] = package
            print("@@rules_python++pip+{hub_name}_{python_version}_{package}".format(
                hub_name = hub_name,
                python_version = python_version,
                package = package,
            ))

    # Call the repository rule to create the necessary symbolic links
    vs_code_python_autocompletion_repo(
        name = "py_deps",
        pypi_dependencies = deps,
    )

# Define the module extension
vs_code_python_autocompletion = module_extension(
    implementation = _vs_code_python_autocompletion_impl,
    doc = "Creates symbolic links to Python packages for VS Code autocompletion based on requirements_lock.txt",
    tag_classes = {
        "requirements": tag_class(
            attrs = {
                "requirements_lock": attr.label(
                    mandatory = True,
                    doc = "The requirements lock file",
                    allow_single_file = True,
                ),
                "hub_name": attr.string(
                    mandatory = True,
                    doc = "The name of the hub to use for the requirements",
                ),
                "python_version": attr.string(
                    mandatory = True,
                    doc = "The Python version to use for the requirements",
                ),
            },
        ),
    },
)
