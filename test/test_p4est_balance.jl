# For simplicity this is a simpler refinement function than in the test from `p4est`.
function refine_fn_balance(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if (which_tree == 2 || which_tree == 3) && quadrant_obj.level < 3
    return Cint(1)
  end
  return Cint(0)
end

# This test is inspired by test/test_balance_type2.c from `p4est` for 2D
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
