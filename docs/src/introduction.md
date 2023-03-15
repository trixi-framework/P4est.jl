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


## [Translation guidelines](@id translation_guidelines)

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
functions accordingly and works with pointers. For a convenient alternative
to using raw pointers directly, see the next section on [`PointerWrapper`s](@ref pointer_wrappers). We also
follow the naming scheme of [`p4est`](https://github.com/cburstedde/p4est).
For example, we use `connectivity::Ptr{p4est_connectivity}`. However, it is
sometimes useful/required to also load the wrappers of the C `struct`s from their
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


## [`PointerWrapper`s](@id pointer_wrappers)

As we have seen in the previous section on [translation guidelines](@ref translation_guidelines), many functions
provided by [`p4est`](https://github.com/cburstedde/p4est) return pointers to `struct`s,
which requires one to [`unsafe_load`](https://docs.julialang.org/en/v1/base/c/#Base.unsafe_load)
the pointer in order to access the underlying data.
[P4est.jl](https://github.com/trixi-framework/P4est.jl) offers a convenient alternative to
directly using `unsafe_load` by providing the [`PointerWrapper`](@ref) data type.
If you, e.g., have a pointer to a `p4est_connectivity` (i.e., an object of type `Ptr{p4est_connectivity}`)
called `connectivity`, you can use `connectivity_pw = PointerWrapper(connectivity)` to obtain
a wrapped version of the pointer, where the underlying data can be accessed simply by
`connectivity_pw.num_trees[]` without the need to call `unsafe_load` manually. This works even for nested
structures, e.g, where the named field of a `struct` is a pointer to a `struct`. A full example on how to
use the `PointerWrapper` is given here (note the nested access at `p4est_pw.connectivity.num_trees[]`
compared to `unsafe_load(unsafe_load(p4est).connectivity).num_trees` without a `PointerWrapper`):

```@repl
using P4est, MPI; MPI.Init()
connectivity = p4est_connectivity_new_periodic()
connectivity_pw = PointerWrapper(connectivity)
connectivity_pw.num_trees[]
p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
p4est_pw = PointerWrapper(p4est)
p4est_pw.connectivity.num_trees[]
p4est_connectivity_destroy(connectivity)
p4est_destroy(p4est)
```

In addition, you can use a `PointerWrapper` as an array if the underlying datastructure is an array, i.e.
you can access the `i`-th element of the underlying array by `pw[i]` for a `PointerWrapper` `pw`. See the
following code for a full example:

```@repl
using P4est, MPI; MPI.Init()
connectivity = p4est_connectivity_new_periodic()
p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
p4est_pw = PointerWrapper(p4est)
p4est_pw.global_first_quadrant[2]
p4est_connectivity_destroy(connectivity)
p4est_destroy(p4est)
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
