# MWEs

Run all minimum working examples (MWEs) by starting Julia with `julia --project.`
If not already installed, get all required packages by executing
```julia
julia> import Pkg

julia> Pkg.instantiate()
```
before the first example.

## MWE 1
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
