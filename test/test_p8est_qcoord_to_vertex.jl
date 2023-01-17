function iter_volume_for_p8est_qcoord_to_vertex(info::Ptr{p8est_iter_volume_info_t}, user_data)
  info_obj = unsafe_load(info)
  p4est_obj = unsafe_load(info_obj.p4est)
  quad_obj = unsafe_load(info_obj.quad)

  vxyz = Array{Float64}(undef, 3)
  p8est_qcoord_to_vertex(p4est_obj.connectivity, info_obj.treeid, quad_obj.x, quad_obj.y, quad_obj.z, vxyz)

  println(vxyz)
  return nothing
end

@testset "p8est_qcoord_to_vertex" begin
  iter_volume_c = @cfunction(iter_volume_for_p8est_qcoord_to_vertex, Cvoid, (Ptr{p8est_iter_volume_info_t}, Ptr{Cvoid}))
  connectivity = @test_nowarn p8est_connectivity_new_brick(2, 2, 2, 0, 0, 0)
  p4est = @test_nowarn p8est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
  p8est_iterate(p4est, C_NULL, C_NULL, iter_volume_c, C_NULL, C_NULL, C_NULL)
  @test_nowarn p8est_destroy(p4est)
  @test_nowarn p8est_connectivity_destroy(connectivity)
end
