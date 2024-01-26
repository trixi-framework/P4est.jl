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

@testset "p4est_refine and p4est_coarsen" begin
    connectivity = @test_nowarn p4est_connectivity_new_periodic()
    p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity, 0, C_NULL, C_NULL)

    refine_fn_c = @cfunction(refine_fn,
                             Cint,
                             (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    @test_nowarn p4est_refine(p4est, true, refine_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 16

    coarsen_fn_c = @cfunction(coarsen_fn,
                              Cint,
                              (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    @test_nowarn p4est_coarsen(p4est, true, coarsen_fn_c, C_NULL)
    @test unsafe_load(p4est).global_num_quadrants == 1
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
end
