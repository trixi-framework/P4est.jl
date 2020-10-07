# P4est.jl

<!-- [![Docs-stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://trixi-framework.github.io/Trixi.jl/stable) -->
[![Build Status](https://travis-ci.com/trixi-framework/P4est.jl.svg?branch=master)](https://travis-ci.com/trixi-framework/P4est.jl)
[![Codecov](https://codecov.io/gh/trixi-framework/P4est.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/trixi-framework/P4est.jl)
[![Coveralls](https://coveralls.io/repos/github/trixi-framework/P4est.jl/badge.svg?branch=master)](https://coveralls.io/github/trixi-framework/P4est.jl?branch=master)
[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)

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
P4est.jl depends on the binary distribution of the `p4est` library, which is
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
You can then access the full `p4est` API that is defined by the headers. For example, to create a
periodic connectivity and check its validity, execute the following lines:
```julia
julia> c = p4est_connectivity_new_periodic()
Ptr{p4est_connectivity} @0x0000000001ad2080

julia> p4est_connectivity_is_valid(c)
1

julia> unsafe_wrap(c)
p4est_connectivity(num_vertices=4, num_trees=1, num_corners=1, vertices=Ptr{Float64} @0x0000000001b3b720, tree_to_vertex=Ptr{Int32} @0x0000000001bb5870, tree_attr_bytes=0x0000000000000000, tree_to_attr=Ptr{Int8} @0x0000000000000000, tree_to_tree=Ptr{Int32} @0x0000000001e17750, tree_to_face=Ptr{Int8} @0x0000000001a36c90, tree_to_corner=Ptr{Int32} @0x0000000001c37dd0, ctt_offset=Ptr{Int32} @0x0000000001fbea60, corner_to_tree=Ptr{Int32} @0x00000000019f6530, corner_to_corner=Ptr{Int8} @0x00000000013ce610)
```
As can be seen, `unsafe_wrap` allows to convert pointers to `p4est` structs to
the corresponding Julia wrapper type.

For more information on how to use `p4est` via P4est.jl, please refer to the
[documentation for p4est itself](http://www.p4est.org/) or the header files
(`*.h`) in the
[p4est repository](https://github.com/cburstedde/p4est/tree/master/src).

## Authors
P4est.jl was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
and
[Alexander Astanin](https://www.mi.uni-koeln.de/NumSim/astanin)
(both University of Cologne, Germany), who are also the principal developers.


## License and contributing
P4est.jl is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
[p4est](https://github.com/cburstedde/p4est) itself is licensed under the GNU
General Public License, version 2.
