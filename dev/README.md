# Building Julia bindings of `p4est` with Clang.jl

The general process for creating bindings with Clang.jl is as follows:

1. Create a `generator.jl` file with the relevant Julia code (not a lot).
2. Create a corresponding `generator.toml` file with certain settings.
3. Run `julia generator.jl` to create new file `LibP4est.jl`.
4. Apply manual fixes using `./fixes.sh`
5. Run `julia LibP4est.jl`.
6. Get error(s).
7. Try to finagle something with `generator.toml`, `prologue.jl`/`epilogue.jl`,
   or `fixes.sh`.
8. Go back to 3.
9. Despair.

If you want to try this yourself using the setup provided in this directory,
set up all dependencies using
```shell
julia --project -e 'using Pkg; Pkg.instantiate()'
```
This is only required once.

To generate new bindings, run
```shell
julia --project generator.jl && ./fixes.sh
```
to create a new `LibP4est.jl` file. If you did not get an error yet - 🥳🕺

Next, try if it actually works by running the following smoke test after
starting the REPL with `julia --project`:
```julia
julia> include("LibP4est.jl")
Main.LibP4est

julia> using .LibP4est

julia> (p4est_version_major(), p4est_version_minor()) == (2, 8)
true
```

Finally, try to repeat the example from
[P4est.jl](https://github.com/trixi-framework/P4est.jl/blob/e9979cd48c9c6211a084fb2cf7ef99e4f21301cb/README.md#usage),
albeit with a slightly modified syntax:
```julia
julia> include("LibP4est.jl")
Main.LibP4est

julia> using .LibP4est, MPI

julia> MPI.Init()
THREAD_SERIALIZED::ThreadLevel = 2

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

The generated file `LibP4est.jl` is used in `P4est/src/LibP4est_v2.jl`.


## Types are missing

Need an `prologue.jl` file with
```julia
const ptrdiff_t = Cptrdiff_t
```

## Many functions and special macros that use C voodoo

Need to populate `output_ignorelist` for Clang generator.

## Many constants that refer to non-existent constants

Mostly `MPI_XXX`, e.g., `MPI_SUCCESS`, `MPI_COMM_WORLD` etc.
Add dummy definitions to `prologue.jl`, e.g.,
```julia
const MPI_SUCCESS = C_NULL
```

## Some p4est constants do not contain valid C code (but Fortran)

For example,
```c
#define P4EST_F90_LOCIDX INTEGER(KIND=C_INT32_T)
```
Need to write manual postprocessing script that removes offending lines from
`LibP4est.jl`: `./fixes.sh`

## Some p4est constants contain weird function definitions

Add entries like `P4EST_NOTICE` to remove list.

## Some MPI types are erroneously deleted where it would be bad

Replace, e.g. `mpicomm::Cint` by `mpicomm::MPI_Comm`.
