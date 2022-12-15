# P4est.jl

[![Docs-stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://trixi-framework.github.io/P4est.jl/stable)
[![Build Status](https://github.com/trixi-framework/P4est.jl/workflows/CI/badge.svg)](https://github.com/trixi-framework/P4est.jl/actions?query=workflow%3ACI)
[![Codecov](https://codecov.io/gh/trixi-framework/P4est.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/trixi-framework/P4est.jl)
[![Coveralls](https://coveralls.io/repos/github/trixi-framework/P4est.jl/badge.svg?branch=main)](https://coveralls.io/github/trixi-framework/P4est.jl?branch=main)
[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)

[P4est.jl](https://github.com/trixi-framework/P4est.jl) is a Julia package
that wraps [p4est](https://github.com/cburstedde/p4est), a C library to manage
multiple connected adaptive quadtrees or octrees in parallel.


## Installation

If you have not yet installed Julia, please [follow the instructions for your
operating system](https://julialang.org/downloads/platform/). P4est.jl works
with Julia v1.6 and up.

[P4est.jl](https://github.com/trixi-framework/P4est.jl) is a registered Julia
package. Hence, you can install it by executing the following commands in the
Julia REPL:

```julia
julia> import Pkg; Pkg.add("P4est")
```

[P4est.jl](https://github.com/trixi-framework/P4est.jl) depends on the binary
distribution of the [p4est](https://github.com/cburstedde/p4est) library, which
is available in the Julia package P4est\_jll.jl and which is automatically
installed as a dependency. The binaries provided by P4est\_jll.jl support MPI
and are compiled against the default MPI binaries of MPI.jl. At the time of
writing, these are the binaries provided by MicrosoftMPI\_jll.jl on Windows and
MPICH\_jll.jl on all other platforms. Note that the Julia MPI wrapper
[MPI.jl](https://github.com/JuliaParallel/MPI.jl) should be configured to use
the same MPI binaries.

By default, [P4est.jl](https://github.com/trixi-framework/P4est.jl) provides
pre-generated Julia bindings to all exported C functions of the underlying
[p4est](https://github.com/cburstedde/p4est) library. If you want/need to
generate new bindings, please follow the instructions in the `dev` folder and
copy the generated files to the appropriate places in `src`.


### Using a custom build of p4est

[P4est.jl](https://github.com/trixi-framework/P4est.jl) allows using a
[p4est](https://github.com/cburstedde/p4est) binary different from the default
one provided by P4est\_jll.jl.

To enable this, you first need to obtain a local binary installation of
[p4est](https://github.com/cburstedde/p4est). Next, you need to configure
[MPI.jl](https://github.com/JuliaParallel/MPI.jl) to use the same MPI
implementation used to build your local installation of
[p4est](https://github.com/cburstedde/p4est), see
[the documentation of MPI.jl](https://juliaparallel.org/MPI.jl/stable/configuration/).
At the time of writing, this can be done via

```julia
julia> using MPIPreferences; MPIPreferences.use_system_binary()
```

if you use the default system MPI binary installation to build
[p4est](https://github.com/cburstedde/p4est).

Next, you need to set up the
[Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl)
setting containing the path to your local build of the shared library
[p4est](https://github.com/cburstedde/p4est).

```julia
julia> using Preferences, UUIDs

julia> set_preferences!(
           UUID("7d669430-f675-4ae7-b43e-fab78ec5a902"), # UUID of P4est.jl
           "libp4est" => "/path/to/your/libp4est.so", force = true)
```

Currently, custom builds of [p4est](https://github.com/cburstedde/p4est)
without MPI support are not supported.


TODO: Clang

When `JULIA_P4EST_GENERATE_BINDINGS` is non-empty you can also
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
without MPI enabled. If your custom build supports MPI, you need to set a few
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

The `P4est.uses_mpi()` function can be used to check if the
[p4est](https://github.com/cburstedde/p4est) binaries that
[P4est.jl](https://github.com/trixi-framework/P4est.jl) uses were compiled with
MPI enabled. This returns `true` for the default binaries provided by the
P4est_jll.jl package. In this case
[P4est.jl](https://github.com/trixi-framework/P4est.jl) can be used as follows.

In the Julia REPL, first load the packages P4est.jl and MPI.jl in any order and initialize MPI

```julia
julia> using P4est, MPI
julia> MPI.Init()
```

You can then access the full [p4est](https://github.com/cburstedde/p4est) API
that is defined by the headers. For example, to create a periodic connectivity
and check its validity, execute the following lines:

```julia
julia> connectivity = p4est_connectivity_new_periodic()
Ptr{p4est_connectivity} @0x0000000002412d20

julia> p4est_connectivity_is_valid(connectivity)
1

julia> p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 1 processors
Initial level 2 potential global quadrants 16 per tree 16
Done p4est_new with 10 total quadrants
Ptr{p4est} @0x0000000002dd1fd0

julia> _p4est = unsafe_load(p4est)
P4est.LibP4est.p4est(1140850688, 1, 0, 0, 0x0000000000000000, Ptr{Nothing} @0x0000000000000000, 0, 0, 0, 10, 10, Ptr{Int64} @0x00000000021a5f70, Ptr{p4est_quadrant} @0x0000000002274330, Ptr{p4est_connectivity} @0x000000000255cdf0, Ptr{sc_array} @0x00000000023b64a0, Ptr{sc_mempool} @0x0000000000000000, Ptr{sc_mempool} @0x00000000023b1620, Ptr{p4est_inspect} @0x0000000000000000)

julia> _p4est.connectivity == connectivity
true

julia> _connectivity = unsafe_load(_p4est.connectivity)
p4est_connectivity(4, 1, 1, Ptr{Float64} @0x00000000021e8170, Ptr{Int32} @0x00000000020d2450, 0x0000000000000000, Cstring(0x0000000000000000), Ptr{Int32} @0x0000000002468e10, Ptr{Int8} @0x00000000022035e0, Ptr{Int32} @0x0000000002667230, Ptr{Int32} @0x000000000219eea0, Ptr{Int32} @0x000000000279ae00, Ptr{Int8} @0x00000000021ff910)

julia> _connectivity.num_trees
1
```

As can be seen, `unsafe_load` allows to convert pointers to [p4est](https://github.com/cburstedde/p4est)
C structs to the corresponding Julia wrapper type generated by
[Clang.jl](https://github.com/JuliaInterop/Clang.jl). They follow the basic
[C interface of Julia](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/).

Many functions and types in [p4est](https://github.com/cburstedde/p4est) have been documented
with comments by the [p4est](https://github.com/cburstedde/p4est) authors; you can access this
documentation as you would for any Julia-native entity through `?`:
```
help?> p4est_memory_used
search: p4est_memory_used p4est_mesh_memory_used p4est_ghost_memory_used p4est_connectivity_memory_used

  p4est_memory_used(p4est_)

  Calculate local memory usage of a forest structure. Not collective. The memory used on the current rank is
  returned. The connectivity structure is not counted since it is not owned; use
  p4est_connectivity_memory_usage (p4est->connectivity).

  Parameters
  ––––––––––––

    •  p4est:[in] Valid forest structure.

  Returns
  –––––––––

  Memory used in bytes.

  Prototype
  –––––––––––

  size_t p4est_memory_used (p4est_t * p4est);
```

For more information on how to use [p4est](https://github.com/cburstedde/p4est) via P4est.jl,
please refer to the [documentation for p4est itself](http://www.p4est.org/) or to the header files
(`*.h`) in the [p4est repository](https://github.com/cburstedde/p4est/tree/master/src).


## Authors

P4est.jl is mainly maintained by
[Michael Schlottke-Lakemper](https://lakemper.eu)
(RWTH Aachen University, Germany)
and [Hendrik Ranocha](https://ranocha.de) (University of Hamburg, Germany).
The full list of contributors can be found in [AUTHORS.md](AUTHORS.md).
The [p4est](https://github.com/cburstedde/p4est) library itself is written by
Carsten Burstedde, Lucas C. Wilcox, and Tobin Isaac.


## License and contributing

P4est.jl is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
[p4est](https://github.com/cburstedde/p4est) itself is licensed under the GNU
General Public License, version 2.
