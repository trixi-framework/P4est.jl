using Test
using P4est

@testset "P4est.jl tests" begin
  @testset "p4est_connectivity_new_periodic" begin
    @test p4est_connectivity_new_periodic() isa Ptr{p4est_connectivity}
  end

  connectivity = p4est_connectivity_new_periodic()
  @testset "p4est_connectivity_is_valid" begin
    @test p4est_connectivity_is_valid(connectivity) == 1
  end

  @testset "unsafe_wrap" begin
    obj = unsafe_wrap(connectivity)
    @test obj.num_vertices == 4
  end
end
