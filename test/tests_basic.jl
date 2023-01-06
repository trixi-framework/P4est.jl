module TestsBasic

using Test
using MPI: MPI
using P4est


# This belongs to the testset "p4est_qcoord_to_vertex" below. However,
# it looks like we need to define the functions outside of `@testset`
# to make `@cfunction` work.
function iter_volume_for_p4est_qcoord_to_vertex(info::Ptr{p4est_iter_volume_info_t}, user_data)
  info = unsafe_load(info)
  p4est = unsafe_load(info.p4est)
  quad = unsafe_load(info.quad)

  vxyz = Array{Float64}(undef, 3)
  p4est_qcoord_to_vertex(p4est.connectivity, info.treeid, quad.x, quad.y, vxyz)

  println(vxyz)
  return nothing
end

# These functions belong to the testsets "p4est_refine and p4est_coarsen" and "p8est_refine and p8est_coarsen" below.
function refine_fn(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if quadrant_obj.level < 2
    return Cint(1)
  else
    return Cint(0)
  end
end

function coarsen_fn(p4est, which_tree, quadrants)
  return Cint(1)
end

# This function belongs to the testset "p4est_balance" and "p8est_balance" below.
# For simplicity this is a simpler refinement function than in the test from `p4est`.
function refine_fn_balance(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if (which_tree == 2 || which_tree == 3) && quadrant_obj.level < 3
    return Cint(1)
  end
  return Cint(0)
end

# This function belongs to the testset "nested attributes" below.
# first, some auxiliary functions
function unsafe_load_sc(::Type{T}, sc_array::Ptr{sc_array}, i=1) where T
  sc_array_obj = unsafe_load(sc_array)
  return unsafe_load_sc(T, sc_array_obj, i)
end

function unsafe_load_sc(::Type{T}, sc_array_obj::sc_array, i=1) where T
  element_size = sc_array_obj.elem_size
  @assert element_size == sizeof(T)

  return unsafe_load(Ptr{T}(sc_array_obj.array), i)
end

function unsafe_load_side(info::Ptr{p4est_iter_face_info_t}, i=1)
  return unsafe_load_sc(p4est_iter_face_side_t, unsafe_load(info).sides, i)
end

function refine_fn_nested_attributes(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if quadrant_obj.x == 0 && quadrant_obj.y == 0 && quadrant_obj.level < 4
    return Cint(1)
  else
    return Cint(0)
  end
end

function iter_face_nested_attributes(info::Ptr{p4est_iter_face_info_t}, user_data)
  @test unsafe_load(info).sides.elem_count isa Integer
  if unsafe_load(info).sides.elem_count == 2
    sides = (unsafe_load_side(info, 1), unsafe_load_side(info, 2))
    @test sides[1].is_hanging isa Integer
    @test sides[2].is_hanging isa Integer
    @test sides[1].is.full.is_ghost isa Integer
    @test sides[2].is.full.is_ghost isa Integer
    if sides[1].is_hanging == false && sides[2].is_hanging == false # no hanging nodes
      if sides[1].is.full.is_ghost == true
        remote_side = 1
        local_side = 2
      elseif sides[2].is.full.is_ghost == true
        remote_side = 2
        local_side = 1
      else
        return nothing
      end
      # test nested attributes
      @test sides[local_side].treeid isa Integer
      @test sides[local_side].is.full.quadid isa Integer
      @test unsafe_wrap(Array,
                        unsafe_load(unsafe_load(info).ghost_layer).proc_offsets,
                        MPI.Comm_size(MPI.COMM_WORLD) + 1) isa Vector{Int32}
      @test sides[remote_side].is.full.quadid isa Integer
      if local_side == 2
        @test unsafe_load(sides[2].is.full.quad.p.piggy3.local_num) isa Integer
      end
    else # hanging node
      if sides[1].is_hanging == true
        hanging_side = 1
        full_side = 2
      else
        hanging_side = 2
        full_side = 1
      end
      @test sides[hanging_side].is_hanging == true && sides[full_side].is_hanging == false
      @test sides[full_side].is.full.is_ghost isa Integer
      @test sides[hanging_side].is.hanging.is_ghost isa Tuple{Int8, Int8}
      if sides[full_side].is.full.is_ghost == false && all(sides[hanging_side].is.hanging.is_ghost .== false)
        return nothing
      end
    end
  end
  return nothing
end

@testset "basic tests" begin
  @test_nowarn MPI.Init()

  @testset "P4est.uses_mpi" begin
    @test P4est.uses_mpi() == true
  end

  @testset "P4est.init" begin
    @test_nowarn P4est.init(C_NULL, SC_LP_DEFAULT)
    # calling p4est_init directly a second time would error
    @test_nowarn P4est.init(C_NULL, SC_LP_ERROR)
    @test_nowarn P4est.init(C_NULL, SC_LP_DEFAULT)
  end
end

@testset "2D tests" begin
  @testset "p4est_connectivity_new_periodic" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    @test p4est_connectivity_new_periodic() isa Ptr{p4est_connectivity}
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p4est_connectivity_is_valid" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    @test p4est_connectivity_is_valid(connectivity) == 1
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "unsafe_load" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    connectivity_obj = unsafe_load(connectivity)
    @test connectivity_obj.num_vertices == 4
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "local_num_quadrants" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    @test_nowarn Int(unsafe_load(p4est).local_num_quadrants)
  end

  @testset "smoke test" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)
    p4est_obj = @test_nowarn unsafe_load(p4est)
    @test connectivity == p4est_obj.connectivity

    @test_nowarn MPI.Barrier(MPI.COMM_WORLD)
    rank = @test_nowarn MPI.Comm_rank(MPI.COMM_WORLD)
    println("rank $rank: local/global num quadrants = ",
      p4est_obj.local_num_quadrants, "/", p4est_obj.global_num_quadrants)
  end

  @testset "p4est_qcoord_to_vertex" begin
    iter_volume_c = @cfunction(iter_volume_for_p4est_qcoord_to_vertex, Cvoid, (Ptr{p4est_iter_volume_info_t}, Ptr{Cvoid}))
    connectivity = @test_nowarn p4est_connectivity_new_brick(2, 2, 0, 0)
    p4est = @test_nowarn p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
    p4est_iterate(p4est, C_NULL, C_NULL, iter_volume_c, C_NULL, C_NULL)
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p4est_refine and p4est_coarsen" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)

    refine_fn_c = @cfunction(refine_fn, Cint, (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    @test_nowarn p4est_refine(p4est, true, refine_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 16
    coarsen_fn_c = @cfunction(coarsen_fn, Cint, (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    @test_nowarn p4est_coarsen(p4est, true, coarsen_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 1
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  # This test is inspired by test/test_balance_type2.c from p4est for 2D
  @testset "p4est_balance" begin
    connectivity = @test_nowarn p4est_connectivity_new_star()
    p4est = @test_nowarn p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, 0, 0, C_NULL, C_NULL)
    refine_fn_balance_c = @cfunction(refine_fn_balance, Cint,
                                     (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    @test_nowarn p4est_refine(p4est, 1, refine_fn_balance_c, C_NULL)
    # face balance
    p4estF = @test_nowarn p4est_copy(p4est, 0)
    @test_nowarn p4est_balance(p4estF, P4EST_CONNECT_FACE, C_NULL)
    crcF = @test_nowarn p4est_checksum(p4estF)
    @test unsafe_load(p4estF).global_num_quadrants == 6
    println("Face balance with ", unsafe_load(p4estF).global_num_quadrants, " quadrants and crc ", crcF)
    # corner balance
    p4estC = @test_nowarn p4est_copy(p4est, 1)
    @test_nowarn p4est_balance(p4estF, P4EST_CONNECT_CORNER, C_NULL)
    @test_nowarn p4est_balance(p4estC, P4EST_CONNECT_CORNER, C_NULL)
    crcC = @test_nowarn p4est_checksum(p4estC)
    @test crcC == p4est_checksum(p4estF)
    @test unsafe_load(p4estC).global_num_quadrants == 6
    println("Corner balance with ", unsafe_load(p4estC).global_num_quadrants, " quadrants and crc ", crcC)

    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_destroy(p4estF)
    @test_nowarn p4est_destroy(p4estC)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p4est_save and p4est_load" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    filename = joinpath(@__DIR__, "temp")
    @test_nowarn p4est_save(filename, p4est, false)
    conn_vec = Vector{Ptr{p4est_connectivity_t}}(undef, 1)
    @test_nowarn p4est_load(filename, MPI.COMM_WORLD, 0, 0, C_NULL, pointer(conn_vec))
    try
      rm(filename, force=true)
    catch e
      # On our CI systems with Windows, this sometimes throws an error
      # IOError: stat("D:\\a\\P4est.jl\\P4est.jl\\test\\temp"): permission denied (EACCES)
      # see, e.g.,
      # https://github.com/trixi-framework/P4est.jl/actions/runs/3765210932/jobs/6400451653
      if get(ENV, "CI", nothing) == "true" && Sys.iswindows()
        @warn "Exception occurred" e
      else
        throw(e)
      end
    end
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p4est_ghost" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    ghost_layer = @test_nowarn p4est_ghost_new(p4est, P4EST_CONNECT_FACE)
    @test p4est_ghost_is_valid(p4est, ghost_layer) == 1
    @test_nowarn p4est_ghost_destroy(ghost_layer)
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p4est_partition" begin
    connectivity = @test_nowarn p4est_connectivity_new_star()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    @test_nowarn p4est_partition(p4est, 0, C_NULL)
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  # This test is based on init_neighbor_rank_connectivity_iter_face_inner from Trixi.jl.
  # See https://github.com/trixi-framework/Trixi.jl/blob/main/src/solvers/dgsem_p4est/dg_parallel.jl
  @testset "nested attributes" begin
    iter_face_nested_attributes_c = @cfunction(iter_face_nested_attributes, Cvoid,
                                               (Ptr{p4est_iter_face_info_t}, Ptr{Cvoid}))
    connectivity = @test_nowarn p4est_connectivity_new_brick(2, 2, 0, 0)
    p4est = @test_nowarn p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
    refine_fn_nested_attributes_c = @cfunction(refine_fn_nested_attributes, Cint,
                                               (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    p4est_refine(p4est, true, refine_fn_nested_attributes_c, C_NULL)
    p4est_iterate(p4est, C_NULL, C_NULL, C_NULL, iter_face_nested_attributes_c, C_NULL)
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end
end


# This belongs to the testset "p8est_qcoord_to_vertex" below.
function iter_volume_for_p8est_qcoord_to_vertex(info::Ptr{p8est_iter_volume_info_t}, user_data)
  info = unsafe_load(info)
  p4est = unsafe_load(info.p4est)
  quad = unsafe_load(info.quad)

  vxyz = Array{Float64}(undef, 3)
  p8est_qcoord_to_vertex(p4est.connectivity, info.treeid, quad.x, quad.y, quad.z, vxyz)

  println(vxyz)
  return nothing
end

# This function belongs to the testset "nested attributes" below.
function unsafe_load_side(info::Ptr{p8est_iter_face_info_t}, i=1)
  return unsafe_load_sc(p8est_iter_face_side_t, unsafe_load(info).sides, i)
end

function iter_face_nested_attributes(info::Ptr{p8est_iter_face_info_t}, user_data)
  @test unsafe_load(info).sides.elem_count isa Integer
  if unsafe_load(info).sides.elem_count == 2
    sides = (unsafe_load_side(info, 1), unsafe_load_side(info, 2))
    @test sides[1].is_hanging isa Integer
    @test sides[2].is_hanging isa Integer
    @test sides[1].is.full.is_ghost isa Integer
    @test sides[2].is.full.is_ghost isa Integer
    if sides[1].is_hanging == false && sides[2].is_hanging == false # no hanging nodes
      if sides[1].is.full.is_ghost == true
        remote_side = 1
        local_side = 2
      elseif sides[2].is.full.is_ghost == true
        remote_side = 2
        local_side = 1
      else
        return nothing
      end
      # test nested attributes
      @test sides[local_side].treeid isa Integer
      @test sides[local_side].is.full.quadid isa Integer
      @test unsafe_wrap(Array,
                        unsafe_load(unsafe_load(info).ghost_layer).proc_offsets,
                        MPI.Comm_size(MPI.COMM_WORLD) + 1) isa Vector{Int32}
      @test sides[remote_side].is.full.quadid isa Integer
      if local_side == 2
        @test unsafe_load(sides[2].is.full.quad.p.piggy3.local_num) isa Integer
      end
    else # hanging node
      if sides[1].is_hanging == true
        hanging_side = 1
        full_side = 2
      else
        hanging_side = 2
        full_side = 1
      end
      @test sides[hanging_side].is_hanging == true && sides[full_side].is_hanging == false
      @test sides[full_side].is.full.is_ghost isa Integer
      @test sides[hanging_side].is.hanging.is_ghost isa NTuple{4, Int8}
      if sides[full_side].is.full.is_ghost == false && all(sides[hanging_side].is.hanging.is_ghost .== false)
        return nothing
      end
    end
  end
  return nothing
end

@testset "3D tests" begin
  @testset "p8est_connectivity_new_periodic" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    @test p8est_connectivity_new_periodic() isa Ptr{p8est_connectivity}
    @test_nowarn p4est_connectivity_destroy(connectivity)
  end

  @testset "p8est_connectivity_is_valid" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    @test p8est_connectivity_is_valid(connectivity) == 1
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "unsafe_load" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    connectivity_obj = unsafe_load(connectivity)
    @test connectivity_obj.num_vertices == 8
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "local_num_quadrants" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    @test_nowarn Int(unsafe_load(p4est).local_num_quadrants)
  end

  @testset "smoke test" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    p8est = @test_nowarn p8est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)
    p8est_obj = @test_nowarn unsafe_load(p8est)
    @test connectivity == p8est_obj.connectivity

    @test_nowarn MPI.Barrier(MPI.COMM_WORLD)
    rank = @test_nowarn MPI.Comm_rank(MPI.COMM_WORLD)
    println("rank $rank: local/global num quadrants = ",
      p8est_obj.local_num_quadrants, "/", p8est_obj.global_num_quadrants)
  end

  @testset "p8est_qcoord_to_vertex" begin
    iter_volume_c = @cfunction(iter_volume_for_p8est_qcoord_to_vertex, Cvoid, (Ptr{p8est_iter_volume_info_t}, Ptr{Cvoid}))
    connectivity = @test_nowarn p8est_connectivity_new_brick(2, 2, 2, 0, 0, 0)
    p4est = @test_nowarn p8est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
    p8est_iterate(p4est, C_NULL, C_NULL, iter_volume_c, C_NULL, C_NULL, C_NULL)
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "p8est_refine and p8est_coarsen" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    p4est = @test_nowarn p8est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)

    refine_fn_c = @cfunction(refine_fn, Cint, (Ptr{p8est_t}, Ptr{p4est_topidx_t}, Ptr{p8est_quadrant_t}))
    @test_nowarn p8est_refine(p4est, true, refine_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 64
    coarsen_fn_c = @cfunction(coarsen_fn, Cint, (Ptr{p8est_t}, Ptr{p4est_topidx_t}, Ptr{p8est_quadrant_t}))
    @test_nowarn p8est_coarsen(p4est, true, coarsen_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 1
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  # This test is inspired by test/test_balance_type2.c from p4est for 3D
  @testset "p8est_balance" begin
    connectivity = @test_nowarn p8est_connectivity_new_rotcubes()
    p4est = @test_nowarn p8est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, 0, 0, C_NULL, C_NULL)
    refine_fn_balance_c = @cfunction(refine_fn_balance, Cint,
                                     (Ptr{p8est_t}, Ptr{p4est_topidx_t}, Ptr{p8est_quadrant_t}))
    @test_nowarn p8est_refine(p4est, 1, refine_fn_balance_c, C_NULL)
    # face balance
    p4estF = @test_nowarn p8est_copy(p4est, 0)
    @test_nowarn p8est_balance(p4estF, P8EST_CONNECT_FACE, C_NULL)
    crcF = @test_nowarn p8est_checksum(p4estF)
    @test unsafe_load(p4estF).global_num_quadrants == 6
    println("Face balance with ", unsafe_load(p4estF).global_num_quadrants, " quadrants and crc ", crcF)
    # edge balance
    p4estE = @test_nowarn p8est_copy(p4est, 1)
    @test_nowarn p8est_balance(p4estF, P8EST_CONNECT_FACE, C_NULL)
    @test_nowarn p8est_balance(p4estE, P8EST_CONNECT_FACE, C_NULL)
    crcE = @test_nowarn p8est_checksum(p4estE)
    @test unsafe_load(p4estE).global_num_quadrants == 6
    println("Edge balance with ", unsafe_load(p4estE).global_num_quadrants, " quadrants and crc ", crcE)
    # corner balance
    p4estC = @test_nowarn p8est_copy(p4est, 1)
    @test_nowarn p8est_balance(p4estF, P8EST_CONNECT_CORNER, C_NULL)
    @test_nowarn p8est_balance(p4estC, P8EST_CONNECT_CORNER, C_NULL)
    crcC = @test_nowarn p8est_checksum(p4estC)
    @test crcC == p8est_checksum(p4estF)
    @test unsafe_load(p4estC).global_num_quadrants == 6
    println("Corner balance with ", unsafe_load(p4estC).global_num_quadrants, " quadrants and crc ", crcC)

    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_destroy(p4estF)
    @test_nowarn p8est_destroy(p4estE)
    @test_nowarn p8est_destroy(p4estC)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "p8est_save and p8est_load" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    p4est = @test_nowarn p8est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    filename = joinpath(@__DIR__, "temp")
    @test_nowarn p8est_save(filename, p4est, false)
    conn_vec = Vector{Ptr{p8est_connectivity_t}}(undef, 1)
    @test_nowarn p8est_load(filename, MPI.COMM_WORLD, 0, 0, C_NULL, pointer(conn_vec))
    try
      rm(filename, force=true)
    catch e
      # On our CI systems with Windows, this sometimes throws an error
      # IOError: stat("D:\\a\\P4est.jl\\P4est.jl\\test\\temp"): permission denied (EACCES)
      # see, e.g.,
      # https://github.com/trixi-framework/P4est.jl/actions/runs/3765210932/jobs/6400451653
      if get(ENV, "CI", nothing) == "true" && Sys.iswindows()
        @warn "Exception occurred" e
      else
        throw(e)
      end
    end
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "p8est_ghost" begin
    connectivity = @test_nowarn p8est_connectivity_new_periodic()
    p4est = @test_nowarn p8est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    ghost_layer = @test_nowarn p8est_ghost_new(p4est, P8EST_CONNECT_FACE)
    @test p8est_ghost_is_valid(p4est, ghost_layer) == 1
    @test_nowarn p8est_ghost_destroy(ghost_layer)
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  @testset "p8est_partition" begin
    connectivity = @test_nowarn p8est_connectivity_new_rotcubes()
    p4est = @test_nowarn p8est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    @test_nowarn p8est_partition(p4est, 0, C_NULL)
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end

  # This test is based on init_neighbor_rank_connectivity_iter_face_inner from Trixi.jl.
  # See https://github.com/trixi-framework/Trixi.jl/blob/main/src/solvers/dgsem_p4est/dg_parallel.jl
  @testset "nested attributes" begin
    iter_face_nested_attributes_c = @cfunction(iter_face_nested_attributes, Cvoid,
                                               (Ptr{p8est_iter_face_info_t}, Ptr{Cvoid}))
    connectivity = @test_nowarn p8est_connectivity_new_brick(2, 2, 2, 0, 0, 0)
    p4est = @test_nowarn p8est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
    refine_fn_nested_attributes_c = @cfunction(refine_fn_nested_attributes, Cint,
                                               (Ptr{p8est_t}, Ptr{p4est_topidx_t}, Ptr{p8est_quadrant_t}))
    p8est_refine(p4est, true, refine_fn_nested_attributes_c, C_NULL)
    p8est_iterate(p4est, C_NULL, C_NULL, C_NULL, iter_face_nested_attributes_c, C_NULL, C_NULL)
    @test_nowarn p8est_destroy(p4est)
    @test_nowarn p8est_connectivity_destroy(connectivity)
  end
end


end # module
