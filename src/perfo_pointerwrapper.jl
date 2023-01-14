# some quick performance tests for the PointerWrappers
using P4est
include("pointerwrappers.jl")
using .PointerWrappers: PointerWrapper
using MPI; MPI.Init()
using BenchmarkTools

# define before the function to make `@benchmark` work
function p4est_test_unsafe_load(p4est)
  p4est_obj = unsafe_load(p4est)
  connectivity_obj = unsafe_load(p4est_obj.connectivity)
  num_trees = connectivity_obj.num_trees
end

function p4est_test_pointerwrapper(p4est)
  pw = PointerWrapper(p4est)
  num_trees = pw.connectivity.num_trees[]
end

# test performance on very simple case
function test_perfo_simple()
  connectivity = p4est_connectivity_new_periodic()
  p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)

  io = IOBuffer()
  b1 = @benchmark p4est_test_unsafe_load(p4est) setup=(p4est = $p4est)
  show(io, "text/plain", b1)
  println("Using unsafe_load:")
  println(String(take!(io)))

  b2 = @benchmark p4est_test_pointerwrapper(p4est) setup=(p4est = $p4est)
  show(io, "text/plain", b2)
  println("Using PointerWrapper:")
  println(String(take!(io)))

  p4est_destroy(p4est)
  p4est_connectivity_destroy(connectivity)
end


include("test_nested_attributes_2d.jl")

# test performance on more advanced test
function test_perfo_advanced()
  io = IOBuffer()
  b1 = @benchmark p4est_iterate(p4est, C_NULL, C_NULL, C_NULL, iter_face_unsafe_load_c, C_NULL) setup=(p4est=$p4est)
  show(io, "text/plain", b1)
  println("Using unsafe_load:")
  println(String(take!(io)))

  b2 = @benchmark p4est_iterate(p4est, C_NULL, C_NULL, C_NULL, iter_face_pointerwrapper_c, C_NULL) setup=(p4est=$p4est)
  show(io, "text/plain", b2)
  println("Using PointerWrapper:")
  println(String(take!(io)))

  p4est_destroy(p4est)
  p4est_connectivity_destroy(connectivity)
end


function p4est_test_pointerwrapper_1step(p4est)
  pw = PointerWrapper(p4est)
  num_trees = pw.connectivity.num_trees[]
end

function p4est_test_pointerwrapper_2steps(p4est)
  pw = PointerWrapper(p4est)
  connectivity = pw.connectivity
  connectivity.num_trees[]
end

# test if dividing nested attribute accesses into two steps has impact on performance
function test_perfo_nested()
  connectivity = p4est_connectivity_new_periodic()
  p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 2, 0, 0, C_NULL, C_NULL)

  io = IOBuffer()
  b1 = @benchmark p4est_test_pointerwrapper_1step(p4est) setup=(p4est=$p4est)
  show(io, "text/plain", b1)
  println("Using 1 step:")
  println(String(take!(io)))

  b2 = @benchmark p4est_test_pointerwrapper_2steps(p4est) setup=(p4est=$p4est)
  show(io, "text/plain", b2)
  println("Using 2 steps:")
  println(String(take!(io)))

  p4est_destroy(p4est)
  p4est_connectivity_destroy(connectivity)
end
