# Introduction

Installation instructions and first usage examples are shown on the
[main page](@ref P4est.jl). This page collects some additional examples and
translation guidelines from the C library
[`p4est`](https://github.com/cburstedde/p4est) to its Julia wrapper
[P4est.jl](https://github.com/trixi-framework/P4est.jl).


## High-level overview of the setup

The Julia bindings of [`p4est`](https://github.com/cburstedde/p4est) are
generated using [Clang.jl](https://github.com/JuliaInterop/Clang.jl). This
process is described in the
[`dev`](https://github.com/trixi-framework/P4est.jl/tree/main/dev) folder of
[P4est.jl](https://github.com/trixi-framework/P4est.jl). Since all MPI datatypes
are mapped to types from MPI.jl, the generated bindings are agnostic of the
local MPI installation. Hence, there should be no need to generate new bindings
as a user. If there are problems, please let us know, e.g., by
[creating on issue](https://github.com/trixi-framework/P4est.jl/issues/new) on GitHub.
New bindings only need to be generated for a new version of
[`p4est`](https://github.com/cburstedde/p4est) that comes with a different
API. We will probably provide some new bindings when we learn about this.


## Translation guidelines

Many functions of [`p4est`](https://github.com/cburstedde/p4est) work with
pointers, e.g.,

```C
int p4est_connectivity_is_valid (p4est_connectivity_t * connectivity);
```

or return pointers to newly created `struct`s, e.g.,

```C
p4est_connectivity_t *p4est_connectivity_new_periodic (void);
```

[P4est.jl](https://github.com/trixi-framework/P4est.jl) wraps these C
functions accordingly and works with pointers. We also follow the naming
scheme of [`p4est`](https://github.com/cburstedde/p4est). For example,
we use `connectivity::Ptr{p4est_connectivity}`. However, it is sometimes
useful/required to also load the wrappers of the C `struct`s from their
pointers. In this case, we use the naming convention to append `_obj`, e.g.,
`connectivity_obj = unsafe_load(connectivity)`. A full example is given here:

```@repl
using P4est, MPI; MPI.Init()
connectivity = p4est_connectivity_new_periodic()
@doc(p4est_connectivity)
connectivity_obj = unsafe_load(connectivity)
connectivity_obj.num_vertices
connectivity_obj.num_trees
connectivity_obj.num_corners
p4est_connectivity_destroy(connectivity)
```


### Note on MPI datatypes

MPI types used by [`p4est`](https://github.com/cburstedde/p4est) are mapped
to the types provided by [MPI.jl](https://github.com/JuliaParallel/MPI.jl).

| [`p4est`](https://github.com/cburstedde/p4est) | [P4est.jl](https://github.com/trixi-framework/P4est.jl) |
|:-----------------------------------------------|:--------------------------------------------------------|
| `sc_MPI_Comm`                                  | `MPI.MPI_Comm`                                          |
| `MPI_Datatype`                                 | `MPI.MPI_Datatype`                                      |
| `MPI_File`                                     | `MPI.MPI_File`                                          |

In particular, it is currently not possible to use
[`p4est`](https://github.com/cburstedde/p4est) without MPI support.
