# Changelog

P4est.jl follows the interpretation of
[semantic versioning (semver)](https://julialang.github.io/Pkg.jl/dev/compatibility/#Version-specifier-format-1)
used in the Julia ecosystem. Notable changes will be documented in this file
for human readability.


## Changes in the v0.4 lifecycle

#### Added

- `PointerWrapper`s were added in version v0.4.1 of P4est.jl.

#### Changed


#### Deprecated


#### Removed



## Changes when updating to v0.4 from v0.3.x

#### Added

- Functions `P4est.version()`, `P4est.package_id()`

#### Changed

- We switched from v0.9 of
  [`CBinding.jl`](https://github.com/analytech-solutions/CBinding.jl)
  to [Clang.jl](https://github.com/JuliaInterop/Clang.jl) to generate the
  bindings of [`p4est`](https://github.com/cburstedde/p4est). Please consult
  the [README.md](README.md) and/or documentation from scratch.

#### Deprecated


#### Removed



## Changes in the v0.3 lifecycle

#### Added


#### Changed


#### Deprecated


#### Removed



## Changes when updating to v0.3 from v0.2.x

#### Added

- Function `P4est.uses_mpi()` to check if the p4est library used by P4est.jl uses MPI

#### Changed

- The P4est_jll version is updated to v2.8 which enables MPI support by default
- Default bindings are updated accordingly
- p4est binaries provided by P4est_jll now require the use of a proper MPI communicator

#### Deprecated


#### Removed


