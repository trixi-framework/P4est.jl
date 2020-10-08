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
julia> conn_ptr = p4est_connectivity_new_periodic()
Ptr{p4est_connectivity} @0x0000000001ad2080

julia> p4est_connectivity_is_valid(conn_ptr)
1

julia> p4est_ptr = p4est_new_ext(sc_MPI_Comm(0), conn_ptr, 0, 2, 0, 0, C_NULL, C_NULL)
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 1 processors
Initial level 2 potential global quadrants 16 per tree 16
Done p4est_new with 10 total quadrants
Ptr{p4est} @0x00000000029e9fc0

julia> p4est_ = unsafe_wrap(p4est_ptr)
p4est(mpicomm=0, mpisize=1, mpirank=0, mpicomm_owned=0, data_size=0x0000000000000000, user_pointer=Ptr{Nothing} @0x0000000000000000, revision=0, first_local_tree=0, last_local_tree=0, local_num_quadrants=10, global_num_quadrants=10, global_first_quadrant=Ptr{Int64} @0x00000000025b2880, global_first_position=Ptr{p4est_quadrant} @0x0000000001ee1390, connectivity=Ptr{p4est_connectivity} @0x000000000256de60, trees=Ptr{sc_array} @0x0000000002210e20, user_data_pool=Ptr{sc_mempool} @0x0000000000000000, quadrant_pool=Ptr{sc_mempool} @0x00000000020a5820, inspect=Ptr{p4est_inspect} @0x0000000000000000)

julia> p4est_.connectivity == conn_ptr
true

julia> p4est_.connectivity.num_trees
1
```
As can be seen, `unsafe_wrap` allows to convert pointers to `p4est` C structs to
the corresponding Julia wrapper type provided by
[CBinding.jl](https://github.com/analytech-solutions/CBinding.jl). Once
converted, `CBinding.jl` will automatically wrap pointers nested structures (such as
`Ptr{p4est_connectivity}` in `p4est_` in the example above) with the
corresponding Julia type.

Many functions and types in `p4est` have been documented with comments by the
`p4est` authors; you can access this documentation as you would for any
Julia-native entity through `?`:
```
help?> p4est_memory_used
search: p4est_memory_used p4est_mesh_memory_used p4est_ghost_memory_used p4est_connectivity_memory_used P4EST_HAVE_MEMORY_H @P4EST_HAVE_MEMORY_H

  𝐣𝐥.@cextern p4est_memory_used(p4est::𝐣𝐥.Ptr{p4est_t})::size_t


  Calculate local memory usage of a forest structure. Not collective. The memory used on the current rank is returned. The connectivity structure is not counted since it is not owned; use
  p4estconnectivitymemory_usage (p4est->connectivity).

  Parameters
  ============

    •    p4est: Valid forest structure.

  Returns
  =========

            Memory used in bytes.


  Reference
  ===========

  p4est.h:177 (~/.julia/artifacts/bb31421737f71afecd6a7760afa471cd27c9d211/include/p4est.h:177:21)

```

For more information on how to use `p4est` via P4est.jl, please refer to the
[documentation for p4est itself](http://www.p4est.org/) or to the header files
(`*.h`) in the
[p4est repository](https://github.com/cburstedde/p4est/tree/master/src).

## Authors
P4est.jl was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
and
[Alexander Astanin](https://www.mi.uni-koeln.de/NumSim/astanin)
(both University of Cologne, Germany), who are also the principal developers.
The `p4est` library itself is written by Carsten Burstedde, Lucas C. Wilcox, and
Tobin Isaac.


## License and contributing
P4est.jl is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
[p4est](https://github.com/cburstedde/p4est) itself is licensed under the GNU
General Public License, version 2.
