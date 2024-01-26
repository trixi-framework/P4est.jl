# some auxiliary functions
function unsafe_load_sc(::Type{T}, sc_array::Ptr{sc_array}, i = 1) where {T}
    sc_array_obj = unsafe_load(sc_array)
    return unsafe_load_sc(T, sc_array_obj, i)
end

function unsafe_load_sc(::Type{T}, sc_array_obj::sc_array, i = 1) where {T}
    element_size = sc_array_obj.elem_size
    @assert element_size == sizeof(T)

    return unsafe_load(Ptr{T}(sc_array_obj.array), i)
end

function unsafe_load_side(info::Ptr{p4est_iter_face_info_t}, i = 1)
    return unsafe_load_sc(p4est_iter_face_side_t, unsafe_load(info).sides, i)
end

function refine_fn(p4est, which_tree, quadrant)
    quadrant_obj = unsafe_load(quadrant)
    if quadrant_obj.x == 0 && quadrant_obj.y == 0 && quadrant_obj.level < 4
        return Cint(1)
    else
        return Cint(0)
    end
end

function iter_face(info::Ptr{p4est_iter_face_info_t}, user_data)
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
            @test sides[hanging_side].is_hanging == true &&
                  sides[full_side].is_hanging == false
            @test sides[full_side].is.full.is_ghost isa Integer
            @test sides[hanging_side].is.hanging.is_ghost isa Tuple{Int8, Int8}
            if sides[full_side].is.full.is_ghost == false &&
               all(sides[hanging_side].is.hanging.is_ghost .== false)
                return nothing
            end
        end
    end
    return nothing
end

# This test is based on init_neighbor_rank_connectivity_iter_face_inner from Trixi.jl.
# See https://github.com/trixi-framework/Trixi.jl/blob/main/src/solvers/dgsem_p4est/dg_parallel.jl
@testset "nested attributes" begin
    connectivity = @test_nowarn p4est_connectivity_new_brick(2, 2, 0, 0)
    p4est = @test_nowarn p4est_new_ext(MPI.COMM_WORLD,
                                       connectivity,
                                       0,
                                       0,
                                       true,
                                       0,
                                       C_NULL,
                                       C_NULL)
    refine_fn_c = @cfunction(refine_fn,
                             Cint,
                             (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
    p4est_refine(p4est, true, refine_fn_c, C_NULL)
    p4est_balance(p4est, P4EST_CONNECT_FACE, C_NULL)

    iter_face_c = @cfunction(iter_face, Cvoid, (Ptr{p4est_iter_face_info_t}, Ptr{Cvoid}))
    p4est_iterate(p4est, C_NULL, C_NULL, C_NULL, iter_face_c, C_NULL)
    @test_nowarn p4est_destroy(p4est)
    @test_nowarn p4est_connectivity_destroy(connectivity)
end
