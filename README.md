# P4est.jl

[![Docs-stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://trixi-framework.github.io/P4est.jl/stable)
[![Slack](https://img.shields.io/badge/chat-slack-e01e5a)](https://join.slack.com/t/trixi-framework/shared_invite/zt-sgkc6ppw-6OXJqZAD5SPjBYqLd8MU~g)
[![Build Status](https://github.com/trixi-framework/P4est.jl/workflows/CI/badge.svg)](https://github.com/trixi-framework/P4est.jl/actions?query=workflow%3ACI)
[![Codecov](https://codecov.io/gh/trixi-framework/P4est.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/trixi-framework/P4est.jl)
[![Coveralls](https://coveralls.io/repos/github/trixi-framework/P4est.jl/badge.svg?branch=main)](https://coveralls.io/github/trixi-framework/P4est.jl?branch=main)
[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
[![Downloads](https://shields.io/endpoint?url=https://pkgs.genieframework.com/api/v1/badge/P4est)](https://pkgs.genieframework.com?packages=P4est)

[P4est.jl](https://github.com/trixi-framework/P4est.jl) is a Julia package
that wraps [`p4est`](https://github.com/cburstedde/p4est), a C library to manage
multiple connected adaptive quadtrees or octrees in parallel.

[P4est.jl](https://github.com/trixi-framework/P4est.jl) mainly provides low-level
wrappers of functionality from [`p4est`](https://github.com/cburstedde/p4est).
The Julia package [P4estTypes.jl](https://github.com/lcw/P4estTypes.jl) builds
on top of [P4est.jl](https://github.com/trixi-framework/P4est.jl) and provides a
high-level interface.


## Installation

If you have not yet installed Julia, please [follow the instructions for your
operating system](https://julialang.org/downloads/platform/).
[P4est.jl](https://github.com/trixi-framework/P4est.jl) works with Julia v1.6
and later.

[P4est.jl](https://github.com/trixi-framework/P4est.jl) is a registered Julia
package. Hence, you can install it by executing the following commands in the
Julia REPL:

```julia
julia> import Pkg; Pkg.add(["P4est", "MPI"])
```

With this command, you install both
[P4est.jl](https://github.com/trixi-framework/P4est.jl) and
[MPI.jl](https://github.com/JuliaParallel/MPI.jl).
Currently, [P4est.jl](https://github.com/trixi-framework/P4est.jl) supports
only builds of the C library [`p4est`](https://github.com/cburstedde/p4est)
with MPI support, so you need to initialize MPI appropriately as described
in the [Usage](#usage) section below.

[P4est.jl](https://github.com/trixi-framework/P4est.jl) depends on the binary
distribution of the [`p4est`](https://github.com/cburstedde/p4est) library,
which is available in the Julia package P4est\_jll.jl and which is automatically
installed as a dependency. The binaries provided by P4est\_jll.jl support MPI
and are compiled against the default MPI binaries of MPI.jl. At the time of
writing, these are the binaries provided by MicrosoftMPI\_jll.jl on Windows and
MPICH\_jll.jl on all other platforms.

By default, [P4est.jl](https://github.com/trixi-framework/P4est.jl) provides
pre-generated Julia bindings to all exported C functions of the underlying
[`p4est`](https://github.com/cburstedde/p4est) library. If you want/need to
generate new bindings, please follow the instructions in the `dev` folder and
copy the generated files to the appropriate places in `src`.


### Using a custom version of MPI and/or `p4est`

The C library [`p4est`](https://github.com/cburstedde/p4est) needs to be
compiled against the same MPI implementation used by
[MPI.jl](https://github.com/JuliaParallel/MPI.jl). Thus, if you want to
configure [MPI.jl](https://github.com/JuliaParallel/MPI.jl) to not use the
default MPI binary provided by JLL wrappers, you also need to build the C
library [`p4est`](https://github.com/cburstedde/p4est) locally using the same
MPI implementation. This is typically the situation on HPC clusters. If you
are just using a single workstation, the default installation instructions
should be sufficient.

[P4est.jl](https://github.com/trixi-framework/P4est.jl) allows using a
[`p4est`](https://github.com/cburstedde/p4est) binary different from the default
one provided by P4est\_jll.jl.
To enable this, you first need to obtain a local binary installation of
[`p4est`](https://github.com/cburstedde/p4est). Next, you need to configure
[MPI.jl](https://github.com/JuliaParallel/MPI.jl) to use the same MPI
implementation used to build your local installation of
[`p4est`](https://github.com/cburstedde/p4est), see
[the documentation of MPI.jl](https://juliaparallel.org/MPI.jl/stable/configuration/).
At the time of writing, this can be done by first setting up the
[Preferences.jl](https://github.com/JuliaPackaging/Preferences.jl)
setting containing the path to your local build of the shared library of
[`p4est`](https://github.com/cburstedde/p4est).

```julia
julia> using Preferences, UUIDs

julia> set_preferences!(
           UUID("7d669430-f675-4ae7-b43e-fab78ec5a902"), # UUID of P4est.jl
           "libp4est" => "/path/to/your/libp4est.so", force = true)
```
Alternatively, you can use the convenience function `set_library_p4est!` to set
the path:

```julia
julia> using P4est

julia> P4est.set_library_p4est!("/path/to/your/libp4est.so")
[ Info: Please restart Julia and reload P4est.jl for the library changes to take effect
```
On Windows you also need to set the path to the local build of the shared library
of [`libsc`](https://github.com/cburstedde/libsc/tree/master), which is a subpackage
of `p4est`. On other systems, this is not necessary as the library is already linked
by `libp4est.so`, but it can be used to employ also a custom build of `libsc`.
```julia
julia> set_preferences!(
           UUID("7d669430-f675-4ae7-b43e-fab78ec5a902"), # UUID of P4est.jl
           "libsc" => "/path/to/your/libsc.so", force = true)
```
Again, for convenience you can also use
```julia
julia> P4est.set_library_sc!("/path/to/your/libsc.so")
[ Info: Please restart Julia and reload P4est.jl for the library changes to take effect
```
To delete the preferences again, you can call `P4est.set_library_p4est!()` and
`P4est.set_library_sc!()`, respectively.

Note that you should restart your Julia session after changing the preferences.

Next, you need to set up the preferences for MPI, which can be done by
```julia
julia> using MPIPreferences

julia> MPIPreferences.use_system_binary()
```

if you use the default system MPI binary installation to build
[`p4est`](https://github.com/cburstedde/p4est).

To sum up, follow these steps to use
[P4est.jl](https://github.com/trixi-framework/P4est.jl) with a custom
installation of the underlying C libraries.
- Create a Julia project for your setup.
  ```julia
  julia> import Pkg; Pkg.activate(".")
  ```
  This uses the Julia project in your current working directory or creates a
  new one if there is none.
- Install the required packages.
  ```julia
  julia> Pkg.add(["MPIPreferences", "MPI", "P4est"])
  ```
- Set [P4est.jl](https://github.com/trixi-framework/P4est.jl) preferences.
  ```julia
  julia> using P4est

  julia> P4est.set_library_p4est!("/path/to/your/libp4est.so")
  [ Info: Please restart Julia and reload P4est.jl for the library changes to take effect

  julia> P4est.set_library_sc!("/path/to/your/libsc.so")
  [ Info: Please restart Julia and reload P4est.jl for the library changes to take effect
  ```
- Set [MPI.jl](https://github.com/JuliaParallel/MPI.jl) preferences.
  ```julia
  julia> using MPIPreferences

  julia> MPIPreferences.use_system_binary()
  ```
- Restart the Julia REPL and load the packages.
  ```julia
  julia> import Pkg; Pkg.activate(".")

  julia> using P4est, MPI; MPI.Init()
  ```

Currently, custom builds of [`p4est`](https://github.com/cburstedde/p4est)
without MPI support are not supported.


## Usage

The `P4est.uses_mpi()` function can be used to check if the
[`p4est`](https://github.com/cburstedde/p4est) binaries that
[P4est.jl](https://github.com/trixi-framework/P4est.jl) uses were compiled with
MPI enabled. This returns `true` for the default binaries provided by the
P4est_jll.jl package. In this case
[P4est.jl](https://github.com/trixi-framework/P4est.jl) can be used as follows.

In the Julia REPL, first load the packages
[P4est.jl](https://github.com/trixi-framework/P4est.jl) and
[MPI.jl](https://github.com/JuliaParallel/MPI.jl) in any order and
initialize MPI.

```julia
julia> using P4est, MPI; MPI.Init()
```

You can then access the full [`p4est`](https://github.com/cburstedde/p4est) API
that is defined by the headers. For example, to create a periodic connectivity
and check its validity, execute the following lines:

```julia
julia> using P4est, MPI; MPI.Init()

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

julia> p4est_obj = unsafe_load(p4est)
P4est.LibP4est.p4est(1140850688, 1, 0, 0, 0x0000000000000000, Ptr{Nothing} @0x0000000000000000, 0, 0, 0, 10, 10, Ptr{Int64} @0x00000000021a5f70, Ptr{p4est_quadrant} @0x0000000002274330, Ptr{p4est_connectivity} @0x000000000255cdf0, Ptr{sc_array} @0x00000000023b64a0, Ptr{sc_mempool} @0x0000000000000000, Ptr{sc_mempool} @0x00000000023b1620, Ptr{p4est_inspect} @0x0000000000000000)

julia> p4est_obj.connectivity == connectivity
true

julia> connectivity_obj = unsafe_load(p4est_obj.connectivity)
p4est_connectivity(4, 1, 1, Ptr{Float64} @0x00000000021e8170, Ptr{Int32} @0x00000000020d2450, 0x0000000000000000, Cstring(0x0000000000000000), Ptr{Int32} @0x0000000002468e10, Ptr{Int8} @0x00000000022035e0, Ptr{Int32} @0x0000000002667230, Ptr{Int32} @0x000000000219eea0, Ptr{Int32} @0x000000000279ae00, Ptr{Int8} @0x00000000021ff910)

julia> connectivity_obj.num_trees
1

julia> p4est_destroy(p4est)

julia> p4est_connectivity_destroy(connectivity)
```

As shown here, `unsafe_load` allows to convert pointers to
[`p4est`](https://github.com/cburstedde/p4est) C `struct`s to the corresponding
Julia wrapper type generated by
[Clang.jl](https://github.com/JuliaInterop/Clang.jl). They follow the basic
[C interface of Julia](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/).

If you start Julia on multiple MPI ranks, you can check whether everything is
set up correctly by the following extended smoke test. Copy the following
code to a local file:

```julia
using P4est, MPI; MPI.Init()
connectivity = p4est_connectivity_new_periodic()
p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)
p4est_obj = unsafe_load(p4est)
MPI.Barrier(MPI.COMM_WORLD)
rank = MPI.Comm_rank(MPI.COMM_WORLD)
@info "Setup" rank p4est_obj.local_num_quadrants p4est_obj.global_num_quadrants
p4est_destroy(p4est)
p4est_connectivity_destroy(connectivity)
```

Run Julia with the MPI implementation used by MPI.jl and execute the script
shown above. You should get an output like

```
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 2 processors
Initial level 2 potential global quadrants 16 per tree 16
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 2 processors
Initial level 2 potential global quadrants 16 per tree 16
Done p4est_new with 13 total quadrants
Done p4est_new with 13 total quadrants
┌ Info: Setup
│   rank = 0
│   p4est_obj.local_num_quadrants = 5
└   p4est_obj.global_num_quadrants = 13
┌ Info: Setup
│   rank = 1
│   p4est_obj.local_num_quadrants = 8
└   p4est_obj.global_num_quadrants = 13
```

To suppress the relatively verbose output of
[`p4est`](https://github.com/cburstedde/p4est) in the example above, you can
call `P4est.init(C_NULL, SC_LP_ERROR)` before calling other functions from
[`p4est`](https://github.com/cburstedde/p4est).

Many functions and types in [`p4est`](https://github.com/cburstedde/p4est) have
been documented with comments by the [`p4est`](https://github.com/cburstedde/p4est)
authors; you can access this documentation as you would for any Julia-native
entity through `?`:

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

The same is of course true for the higher-level interface functions provided
by [P4est.jl](https://github.com/trixi-framework/P4est.jl), e.g.,

```
help?> P4est.init
  P4est.init(log_handler, log_threshold)

  Calls p4est_init if it has not already been called, otherwise do nothing. Thus, P4est.init can safely be
  called multiple times.

  To use the default log handler and suppress most output created by default by p4est, call this function as

  P4est.init(C_NULL, SC_LP_ERROR)

  before calling other functions from p4est.
```

For more information on how to use [`p4est`](https://github.com/cburstedde/p4est),
please refer to the [documentation for p4est itself](http://www.p4est.org/) or
to the header files (`*.h`) in the
[`p4est` repository](https://github.com/cburstedde/p4est/tree/master/src).

For more information on how to use the Julia wrapper
[P4est.jl](https://github.com/trixi-framework/P4est.jl), please consult the
[documentation](https://trixi-framework.github.io/P4est.jl/stable).


## Authors

P4est.jl is mainly maintained by
[Michael Schlottke-Lakemper](https://lakemper.eu)
(RWTH Aachen University/High-Performance Computing Center Stuttgart (HLRS), Germany)
and [Hendrik Ranocha](https://ranocha.de) (Johannes Gutenberg University Mainz, Germany).
The full list of contributors can be found in [AUTHORS.md](AUTHORS.md).
The [`p4est`](https://github.com/cburstedde/p4est) library itself is written by
Carsten Burstedde, Lucas C. Wilcox, and Tobin Isaac.


## License and contributing

P4est.jl is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).
[`p4est`](https://github.com/cburstedde/p4est) itself is licensed under the GNU
General Public License, version 2.
