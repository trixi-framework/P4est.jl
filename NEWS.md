# Changelog

P4est.jl follows the interpretation of
[semantic versioning (semver)](https://julialang.github.io/Pkg.jl/dev/compatibility/#Version-specifier-format-1)
used in the Julia ecosystem. Notable changes will be documented in this file
for human readability.


## Changes in the v0.3 lifecycle

#### Added


#### Changed


#### Deprecated


#### Removed


## Changes in v0.3

#### Added

- Function `P4est.uses_mpi()` to check if the p4est library used by P4est.jl uses MPI

#### Changed

- The P4est_jll version is updated to v2.8 which enables MPI support by default
- Default bindings are updated accordingly
- p4est binaries provided by P4est_jll now require the use of a proper MPI communicator
  
#### Deprecated


#### Removed

