# P4est.jl

**P4est.jl** is a Julia package that wraps
[p4est](https://github.com/cburstedde/p4est), a C library to manage multiple
connected adaptive quadtrees or octrees in parallel.


## Installation
If you have not yet installed Julia, please [follow the instructions for your
operating system](https://julialang.org/downloads/platform/). P4est.jl works
with Julia v1.6.

P4est.jl is a registered Julia package. Hence, you can install it by executing
the following commands in the Julia REPL:
```julia
julia> import Pkg; Pkg.add("P4est")
```
P4est.jl depends on the binary distribution of the [p4est](https://github.com/cburstedde/p4est)
library, which is available in the Julia package `P4est_jll.jl` and which is automatically
installed as a dependency.

*Note: Currently, `P4est_jll.jl` only provides serial binaries without MPI
support. This limitation is planned to be lifted in the future.*

By default, P4est.jl provides pre-generated Julia bindings to all exported C
functions of the underlying p4est library. You can force the build script to
re-generate the bindings by setting the environment variable
`JULIA_P4EST_GENERATE_BINDINGS` to a non-empty string.

In addition, when `JULIA_P4EST_GENERATE_BINDINGS` is non-empty you can also
configure P4est.jl to use a custom build of p4est. For this, set the following
environment variables and build P4est.jl again afterwards:
1. **Set `JULIA_P4EST_PATH`.**

   You can set the environment variable `JULIA_P4EST_PATH` to the install
   prefix of your p4est library.
   P4est.jl will then assume to find the corresponding library as
   `joinpath(ENV["JULIA_P4EST_PATH"], "lib", "libp4est.{so,dylib,dll}")`
   and the include files in
   `joinpath(ENV["JULIA_P4EST_PATH"], "include")`.
2. **Set `JULIA_P4EST_LIBRARY` and `JULIA_P4EST_INCLUDE`.**

   Alternatively, you can specify the p4est library and the include
   directory directly. Note that `JULIA_P4EST_LIBRARY` expects the full path to
   the p4est library, while `JULIA_P4EST_INCLUDE` must be the full path to the
   directory with the p4est header files.

For example, if your custom p4est build is installed to `/opt/p4est`, you can
use it from P4est.jl by executing
```bash
julia --project -e 'ENV["JULIA_P4EST_GENERATE_BINDINGS"] = "yes";
                    ENV["JULIA_P4EST_PATH"] = "/opt/p4est";
                    using Pkg; Pkg.build("P4est"; verbose=true)'
```

P4est.jl supports [p4est](https://github.com/cburstedde/p4est) both with and
without MPI enabled. By default, it uses the p4est library from the binary
Julia package `P4est_jll`, which currently is not compiled with MPI support.
However, you may specify a custom p4est build with MPI enabled using the
environment variables desribed above. In this case, you need to set a few
additional variables to make sure that P4est.jl can create the correct C
bindings:
1. **Set `JULIA_P4EST_USES_MPI` to `yes`.**

   This is always required, since it tells P4est.jl to use the MPI include directory
   while generating the C bindings.
2. **Set `JULIA_P4EST_MPI_PATH`.**

   You can set the environment variable `JULIA_P4EST_MPI_PATH` to the install
   prefix of your MPI library.
   P4est.jl will then assume to find the corresponding include files in
   `joinpath(ENV["JULIA_P4EST_MPI_PATH"], "include")`.
3. **Set `JULIA_P4EST_MPI_INCLUDE`.**

   Alternatively, you can specify the MPI include directory directly. Note that
   `JULIA_P4EST_MPI_INCLUDE` must be the full path to the directory with the
   `mpi.h` header file.
Please note that you should specify the path to the MPI version with which you
also built the parallel version of p4est, in order to avoid errors from
mismatching definitions.

For example, if your custom p4est build is installed to `/opt/p4est` and was
built using the MPI library installed to `/opt/mpich`, you can use it from
P4est.jl by executing
```bash
julia --project -e 'ENV["JULIA_P4EST_GENERATE_BINDINGS"] = "yes";
                    ENV["JULIA_P4EST_PATH"] = "/opt/p4est";
                    ENV["JULIA_P4EST_USES_MPI"] = "yes";
                    ENV["JULIA_P4EST_MPI_PATH"] = "/opt/mpich";
                    using Pkg; Pkg.build("P4est"; verbose=true)'
```

## Usage
In the Julia REPL, first load the package P4est.jl
```julia
julia> using P4est
```
You can then access the full [p4est](https://github.com/cburstedde/p4est) API that is defined
by the headers. For example, to create a periodic connectivity and check its validity, execute
the following lines:
```@repl
using P4est
conn_ptr = p4est_connectivity_new_periodic()
p4est_connectivity_is_valid(conn_ptr)
p4est_ptr = p4est_new_ext(sc_MPI_Comm(0), conn_ptr, 0, 2, 0, 0, C_NULL, C_NULL)
p4est_ = unsafe_wrap(p4est_ptr)
p4est_.connectivity == conn_ptr
p4est_.connectivity.num_trees
```
As can be seen, `unsafe_wrap` allows to convert pointers to [p4est](https://github.com/cburstedde/p4est)
C structs to the corresponding Julia wrapper type provided by
[CBinding.jl](https://github.com/analytech-solutions/CBinding.jl). Once
converted, [CBinding.jl](https://github.com/analytech-solutions/CBinding.jl)
will automatically wrap pointers nested structures (such as
`Ptr{p4est_connectivity}` in `p4est_` in the example above) with the
corresponding Julia type.

Many functions and types in [p4est](https://github.com/cburstedde/p4est) have been documented
with comments by the [p4est](https://github.com/cburstedde/p4est) authors; you can access this
documentation as you would for any Julia-native entity through `?`:
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

For more information on how to use [p4est](https://github.com/cburstedde/p4est) via P4est.jl,
please refer to the [documentation for p4est itself](http://www.p4est.org/) or to the header files
(`*.h`) in the [p4est repository](https://github.com/cburstedde/p4est/tree/master/src).

## Authors
P4est.jl was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
(University of Cologne, Germany),
[Hendrik Ranocha](https://ranocha.de)  (University of Münster, Germany), and
[Alexander Astanin](https://www.mi.uni-koeln.de/NumSim/astanin)
(University of Cologne, Germany).
Together, they are the principal developers of P4est.jl.
The [p4est](https://github.com/cburstedde/p4est) library itself is written by
Carsten Burstedde, Lucas C. Wilcox, and Tobin Isaac.


## License and contributing
P4est.jl is licensed under the MIT license (see [License](@ref)).
[p4est](https://github.com/cburstedde/p4est) itself is licensed under the GNU
General Public License, version 2.
