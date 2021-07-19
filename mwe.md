# MWEs

Run all minimum working examples (MWEs) by starting Julia with `julia --project.`
If not already installed, get all required packages by executing
```julia
julia> import Pkg

julia> Pkg.instantiate()
```
before the first example.

## MWE 1
File: [`mwe1.jl`](mwe1.jl)
```julia
julia> include("mwe1.jl")
┌ Warning: Failed to find `sc_extern_c_hack_3` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `sc_extern_c_hack_4` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `P2EST_DATA_UNINITIALIZED` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `p8est_ghost_tree_contains` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
Main.LibP4est

julia> using .LibP4est

julia> conn_ptr = p4est_connectivity_new_periodic()
CBinding.Cptr{var"c\"struct p4est_connectivity\""}(0x0000000003be1990)

julia> p4est_connectivity_is_valid(conn_ptr)
1

julia> p4est_ptr = p4est_new_ext(sc_MPI_Comm(0), conn_ptr, 0, 2, 0, 0, C_NULL, C_NULL)
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 1 processors
Initial level 2 potential global quadrants 16 per tree 16
Done p4est_new with 10 total quadrants
CBinding.Cptr{var"c\"struct p4est\""}(0x00000000024a5040)

julia> p4est_ = p4est_ptr[]
var"(c\"struct p4est\")" (120-byte struct)
  mpicomm               = 0
  mpisize               = 1
  mpirank               = 0
  mpicomm_owned         = 0
  data_size             = 0x0000000000000000
  user_pointer          = CBinding.Cptr{Nothing}(0x0000000000000000)
  revision              = 0
  first_local_tree      = 0
  last_local_tree       = 0
  local_num_quadrants   = 10
  global_num_quadrants  = 10
  global_first_quadrant = CBinding.Cptr{Int64}(0x0000000002157470)
  global_first_position = CBinding.Cptr{var"c\"struct p4est_quadrant\""}(0x00000000024ac8d0)
  connectivity          = CBinding.Cptr{var"c\"struct p4est_connectivity\""}(0x0000000003be1990)
  trees                 = CBinding.Cptr{var"c\"struct sc_array\""}(0x0000000001c73bf0)
  user_data_pool        = CBinding.Cptr{var"c\"struct sc_mempool\""}(0x0000000000000000)
  quadrant_pool         = CBinding.Cptr{var"c\"struct sc_mempool\""}(0x0000000003c1b160)
  inspect               = CBinding.Cptr{var"c\"struct p4est_inspect\""}(0x0000000000000000)

julia> p4est_.connectivity == conn_ptr
true

julia> p4est_.connectivity[].num_trees
1
```

## MWE 2

### MWE 2a
File: [`mwe2a.jl`](mwe2a.jl)
```julia
julia> include("mwe2a.jl")
┌ Warning: Failed to find `sc_extern_c_hack_3` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `sc_extern_c_hack_4` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `P2EST_DATA_UNINITIALIZED` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
┌ Warning: Failed to find `p8est_ghost_tree_contains` in:
│   /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/lib/libp4est
│   or the Julia process
└ @ CBinding ~/.julia/packages/CBinding/aDSSa/src/context.jl:48
961786
```

### MWE 2b
File: [`mwe2b.jl`](mwe2b.jl)
```julia
julia> include("mwe2b.jl")
ERROR: LoadError: LoadError: syntax: "$" expression outside quote around /mnt/ssd/home/mschlott/hackathon/P4est.jl/libp4est-mwe2.jl:10087
Stacktrace:
 [1] top-level scope
   @ /mnt/ssd/home/mschlott/hackathon/P4est.jl/libp4est-mwe2.jl:1
 [2] include(mod::Module, _path::String)
   @ Base ./Base.jl:386
 [3] include(x::String)
   @ Main.LibP4est /mnt/ssd/home/mschlott/hackathon/P4est.jl/mwe2b.jl:1
 [4] top-level scope
   @ /mnt/ssd/home/mschlott/hackathon/P4est.jl/mwe2b.jl:10
 [5] include(fname::String)
   @ Base.MainInclude ./client.jl:444
 [6] top-level scope
   @ REPL[2]:1
in expression starting at /mnt/ssd/home/mschlott/hackathon/P4est.jl/libp4est-mwe2.jl:1
in expression starting at /mnt/ssd/home/mschlott/hackathon/P4est.jl/mwe2b.jl:1
```

## MWE3
This MWE is based on directly using [Clang.jl](https://github.com/JuliaInterop/Clang.jl).
Note that you need the latest version from `master`, i.e., first install
`Clang.jl` by running
```bash
julia -e 'import Pkg; Pkg.develop("Clang"); Pkg.add("CEnum")'
```
This will also install [`CEnum.jl`](https://github.com/JuliaInterop/CEnum.jl) to
support C-style enums with duplicated values.

Then generate the bindings by starting Julia with `julia --project` and
executing
```julia
julia> include("mwe3.jl")
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_connectivity.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc_io.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc_config.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc_mpi.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc_containers.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_base.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_config.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_mesh.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_ghost.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_iterate.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_lnodes.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_connectivity.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_mesh.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_ghost.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_iterate.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_lnodes.h
[ Info: Found dependent header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/sc_uint128.h
[ Info: Parsing headers...
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est.h
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p4est_extended.h
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p6est.h
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p6est_extended.h
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est.h
[ Info: Processing header: /home/mschlott/.julia/artifacts/93e47e83c32f82f4f1f2c6b99a38aaee8db33090/include/p8est_extended.h
[ Info: Building the DAG...
[ Info: Emit Julia expressions...
┌ Warning: No Prototype for CLCursor (Clang.CLFunctionDecl) p4est_log_indent_push() - assuming no arguments
└ @ Clang.Generators ~/.julia/dev/Clang/src/generator/codegen.jl:116
┌ Warning: No Prototype for CLCursor (Clang.CLFunctionDecl) p4est_log_indent_pop() - assuming no arguments
└ @ Clang.Generators ~/.julia/dev/Clang/src/generator/codegen.jl:116
┌ Warning: No Prototype for CLCursor (Clang.CLFunctionDecl) p4est_connectivity_new_icosahedron() - assuming no arguments
└ @ Clang.Generators ~/.julia/dev/Clang/src/generator/codegen.jl:116
[ Info: [ProloguePrinter]: print to libp4est-mwe3.jl
[ Info: [GeneralPrinter]: print to libp4est-mwe3.jl
[ Info: [EpiloguePrinter]: print to libp4est-mwe3.jl
[ Info: Done!
Context(...)
```
This generates [`libp4est-mwe3.jl`](libp4est-mwe3.jl). Unfortunately, there are some issues with the
generated file when trying to load it. I resolved them by modyfing the options
file [`mwe3.toml`](mwe3.toml) accordingly.

You can then load and use the bindings as follows:
```julia
julia> include("libp4est-mwe3.jl")
Main.LibP4est

julia> using .LibP4est

julia> conn_ptr = p4est_connectivity_new_periodic()
Ptr{p4est_connectivity} @0x0000000002394030

julia> p4est_connectivity_is_valid(conn_ptr)
1

julia> p4est_ptr = p4est_new_ext(sc_MPI_Comm(0), conn_ptr, 0, 2, 0, 0, C_NULL, C_NULL)
Into p4est_new with min quadrants 0 level 2 uniform 0
New p4est with 1 trees on 1 processors
Initial level 2 potential global quadrants 16 per tree 16
Done p4est_new with 10 total quadrants
Ptr{Main.LibP4est.p4est} @0x00000000023f4720

julia> p4est_ = unsafe_load(p4est_ptr)
Main.LibP4est.p4est(0, 1, 0, 0, 0x0000000000000000, Ptr{Nothing} @0x0000000000000000, 0, 0, 0, 10, 10, Ptr{Int64} @0x00000000026fc9d0, Ptr{p4est_quadrant} @0x0000000002533410, Ptr{p4est_connectivity} @0x0000000002394030, Ptr{sc_array} @0x00000000023fc4a0, Ptr{sc_mempool} @0x0000000000000000, Ptr{sc_mempool} @0x00000000023f4680, Ptr{p4est_inspect} @0x0000000000000000)

julia> p4est_.connectivity == conn_ptr
true

julia> unsafe_load(p4est_.connectivity).num_trees
1
```
