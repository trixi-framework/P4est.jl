module TestsBasic

using Test
using MPI: MPI
using P4est

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

  @testset "sc_ functions" begin
    @test_nowarn sc_version()
    @test_nowarn sc_version_major()
    @test_nowarn sc_version_minor()
    @test unsafe_load(cglobal((:sc_package_id, P4est.LibP4est.libsc), Cint)) == -1
  end
end

@testset "PointerWrapper" begin
  connectivity = @test_nowarn p4est_connectivity_new_periodic()
  connectivity_pw = @test_nowarn PointerWrapper(connectivity)
  @test connectivity_pw.num_trees[] isa Integer
  @test_nowarn propertynames(connectivity_pw)

  # passing a `PointerWrapper` to a wrapped C function
  p4est = @test_nowarn p4est_new(MPI.COMM_WORLD, connectivity_pw, 0, C_NULL, C_NULL)
  p4est_pw = @test_nowarn PointerWrapper(p4est)

  # test if changing the underlying data works properly
  struct MyStruct
    value::Float64
  end
  obj = MyStruct(0.0)
  ptr = Base.unsafe_convert(Ptr{MyStruct}, Ref(obj))
  pw = PointerWrapper(ptr)
  @test pw.value[] == 0.0
  @test_nowarn pw.value[] = 1.0
  @test pw.value[] == 1.0
  @test pw.value[1] == 1.0
  @test_nowarn pw.value[1] = 2.0
  @test pw.value[1] == 2.0
  @test pw.value[] == 2.0
  # using `setproperty!`
  @test_nowarn pw.value = 3.0
  @test pw.value[1] == 3.0
  @test pw.value[] == 3.0
  # using `setproperty!` for special `struct`s
  # see https://github.com/trixi-framework/P4est.jl/issues/72 and https://github.com/trixi-framework/P4est.jl/issues/79
  @test p4est_pw.global_first_position.level[] == 29
  @test_nowarn p4est_pw.global_first_position.level = 30
  @test p4est_pw.global_first_position.level[] == 30
  @test_nowarn p4est_pw.global_first_position.level = 29

  # test if we can set the user_pointer
  p4est_pw.user_pointer = Ptr{Cvoid}(3)
  @test p4est_pw.user_pointer == PointerWrapper(Ptr{Cvoid}(3))
  data = Ref((2,3))
  GC.@preserve data begin
    p4est_pw.user_pointer = pointer_from_objref(data)
    @test unsafe_pointer_to_objref(pointer(p4est_pw.user_pointer))[] == data[]
    p4est_pw.user_pointer = C_NULL
  end

  # test if accessing an underlying array works properly
  @test p4est_pw.global_first_quadrant[1] isa Integer
  @test p4est_pw.global_first_quadrant[2] == unsafe_load(unsafe_load(p4est).global_first_quadrant, 2)

  # test if nested accesses work properly
  @test p4est_pw.connectivity isa PointerWrapper{p4est_connectivity}
  @test p4est_pw.connectivity.num_trees[] isa Integer
  @test p4est_pw.global_first_position.level[] isa Integer
  @test p4est_pw.connectivity.num_trees isa PointerWrapper{Int32}

  @test pointer(p4est_pw) isa Ptr{P4est.LibP4est.p4est}

  # `unsafe_wrap`ping a `PointerWrapper`
  n_vertices::Int = connectivity_pw.num_vertices[]
  # wrapping matrices
  vertices = @test_nowarn unsafe_wrap(Array, connectivity_pw.vertices, (3, n_vertices))
  @test vertices isa Array{Float64, 2}
  @test unsafe_wrap(Array{Float64}, connectivity_pw.vertices, (3, n_vertices)) isa Array{Float64, 2}
  @test unsafe_wrap(Array{Float64, 2}, connectivity_pw.vertices, (3, n_vertices)) isa Array{Float64, 2}

  @test size(vertices) == (3, n_vertices)
  @test vertices[1, 1] == connectivity_pw.vertices[1] == 0.0
  @test_nowarn vertices[1, 1] = 1.0
  @test vertices[1, 1] == connectivity_pw.vertices[1] == 1.0
  @test_nowarn connectivity_pw.vertices[1] = 2.0
  @test vertices[1, 1] == connectivity_pw.vertices[1] == 2.0
  # wrapping vectors
  vertices = @test_nowarn unsafe_wrap(Array, connectivity_pw.vertices, 3 * n_vertices)
  @test vertices isa Array{Float64, 1}
  @test unsafe_wrap(Array{Float64}, connectivity_pw.vertices, 3 * n_vertices) isa Array{Float64, 1}
  @test unsafe_wrap(Array{Float64, 1}, connectivity_pw.vertices, 3 * n_vertices) isa Array{Float64, 1}

  @test_nowarn p4est_destroy(p4est_pw)
  @test_nowarn p4est_connectivity_destroy(connectivity_pw)
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

  # Put the tests containing `@cfunction` in separate files to define the corresponding Julia functions locally.
  include("test_p4est_qcoord_to_vertex.jl")
  include("test_p4est_refine_and_p4est_coarsen.jl")
  include("test_p4est_balance.jl")
  include("test_nested_attributes_2d.jl")
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

  # Put the tests containing `@cfunction` in separate files to define the corresponding Julia functions locally.
  include("test_p8est_qcoord_to_vertex.jl")
  include("test_p8est_refine_and_p8est_coarsen.jl")
  include("test_p8est_balance.jl")
  include("test_nested_attributes_3d.jl")
end


end # module
