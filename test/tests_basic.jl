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

# These functions belong to the testset "p4est_refine_coarsen" below
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

# This function belongs to the testset "p4est_balance" below
# For simplicity this is a simpler refinement function than in the test from p4est
function refine_fn_balance(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if (which_tree == 2 || which_tree == 3) && quadrant_obj.level < 3
    return Cint(1)
  end
  return Cint(0)
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

  @testset "p8est_connectivity_new_unitcube" begin
    connectivity = @test_nowarn p8est_connectivity_new_unitcube()
    @test_nowarn p8est_connectivity_destroy(connectivity)
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

  @testset "local_num_quadrants" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)
    @test_nowarn Int(unsafe_load(p4est).local_num_quadrants)
  end

  # This test is inspired by test/test_balance_type2.c from p4est (only for 2D)
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
    p4est_save(filename, p4est, false)
    conn_vec = Vector{Ptr{p4est_connectivity_t}}(undef, 1)
    @test_nowarn p4est_load(filename, MPI.COMM_WORLD, 0, 0, C_NULL, pointer(conn_vec))
    rm(filename, force=true)
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
end


end # module
