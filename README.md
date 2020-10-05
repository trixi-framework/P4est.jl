# P4est.jl

<!-- [![Docs-stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://trixi-framework.github.io/Trixi.jl/stable) -->
<!-- [![Build Linux & macOS](https://travis-ci.com/trixi-framework/P4est.jl.svg?branch=master)](https://travis-ci.com/trixi-framework/P4est.jl) -->
<!-- [![Build Windows](https://ci.appveyor.com/api/projects/status/3vw2i3iy9n9641wq?svg=true)](https://ci.appveyor.com/project/ranocha/trixi2vtk-jl) -->
<!-- [![Codecov](https://codecov.io/gh/trixi-framework/P4est.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/trixi-framework/P4est.jl) -->
<!-- [![Coveralls](https://coveralls.io/repos/github/trixi-framework/P4est.jl/badge.svg?branch=master)](https://coveralls.io/github/trixi-framework/P4est.jl?branch=master) -->
[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
<!-- [![GitHub commits since tagged version](https://img.shields.io/github/commits-since/trixi-framework/P4est.jl/v0.2.0.svg?style=social&logo=github)](https://github.com/trixi-framework/P4est.jl) -->

**P4est.jl** is a Julia package that wraps
[p4est](https://github.com/cburstedde/p4est), a C library to manage multiple
connected adaptive quadtrees or octrees in parallel.


## Installation
If you have not yet installed Julia, please [follow the instructions for your
operating system](https://julialang.org/downloads/platform/). P4est.jl works
with Julia v1.5.

P4est.jl is a registered Julia package. Hence, you can install it by executing
the following commands in the Julia REPL:
```julia
julia> import Pkg; Pkg.add("P4est")
```
P4est.jl depends on the binary distribution of the p4est library, which is
available in the Julia package `P4est_jll.jl` and which is automatically
installed as a dependency.

*Note: Currently, P4est_jll.jl is not available under Windows and provides only
serial binaries without MPI support. Both limitations are planned to be lifted
in the future.*


## Usage
In the Julia REPL, first load the package P4est.jl
```julia
julia> using P4est
```
You can then access the full p4est API under `LibP4est`. For example, to create a
mesh, call `LibP4est.p4est_new` with the appropriate arguments.

## Authors
P4est.jl was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
and
[Alexander Astanin](https://www.mi.uni-koeln.de/NumSim/astanin)
(both University of Cologne, Germany), who are also the principal developers of
P4est.jl.


## License and contributing
P4est.jl is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
