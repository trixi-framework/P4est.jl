using Test
using P4est

const P4EST_TEST = get(ENV, "P4EST_TEST", "")

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
  
  @testset "uses_mpi" begin
    if P4EST_TEST == "P4EST_JLL_USES_MPI_PRE_GENERATED_BINDINGS"
      @test P4est.uses_mpi() == true
    elseif P4EST_TEST == "P4EST_JLL_USES_MPI"
      @test P4est.uses_mpi() == true
    elseif P4EST_TEST == "P4EST_CUSTOM_NON_MPI"
      @test P4est.uses_mpi() == false
    elseif P4EST_TEST == "P4EST_CUSTOM_USES_MPI"
      @test P4est.uses_mpi() == true
    end
  end
end
