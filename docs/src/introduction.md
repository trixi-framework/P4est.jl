# Introduction

Installation instructions and first usage examples are shown on the
[main page](@ref P4est.jl). This page collects some additional examples and
translation rules from the C library
[`p4est`](https://github.com/cburstedde/p4est) to its Julia wrapper
[P4est.jl](https://github.com/trixi-framework/P4est.jl).


## Translation rules

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
useful/required to also load the wrappers of the C `struct`s froom their
pointers. In this case, we use the naming convention to append `_obj`, e.g.,
`connectivity_obj = unsafe_load(connectivity)`. A full example is

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
