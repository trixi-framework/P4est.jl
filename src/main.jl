@cstruct qinner_data_t {
  face::Int8
  Element_id::Int32
}


function faceIterate(info_ptr::Ptr{LibP4est.p4est_iter_face_info_t}, user_data_ptr::Ptr{Cvoid})
    # println(3)
    info = LibP4est.ptr2obj(info_ptr)
    p4est = LibP4est.ptr2obj(info.p4est)
    connection = unsafe_wrap(Array, Ptr{Int32}(user_data_ptr), (7, Int(p4est.local_num_quadrants)); own=false)

    sidec01 = unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array)
    sidec12 = unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array + info.sides.elem_size)

    quad0 = unsafe_wrap(LibP4est.p4est_quadrant_t, sidec01.is.full.quad)
    quad1 = unsafe_wrap(LibP4est.p4est_quadrant_t, sidec12.is.full.quad)
    quadId1 = sidec01.is.full.quadid
    quadId2 = sidec12.is.full.quadid
    connection[1, quadId1 + 1] = quad0.level
    connection[1, quadId2 + 1] = quad1.level

    connection[2, quadId1 + 1] = trunc(Int, 16 * quad0.x / 2147483647)
    connection[2, quadId2 + 1] = trunc(Int, 16 * quad1.x / 2147483647)

    connection[3, quadId1 + 1] = trunc(Int, 16 * quad0.y / 2147483647)
    connection[3, quadId2 + 1] = trunc(Int, 16 * quad1.y / 2147483647)

    connection[sidec01.face + 4,quadId1 + 1] = quadId2 + 1
    connection[sidec12.face + 4,quadId2 + 1] = quadId1 + 1

    return nothing
end


function main()
  mpicomm = Int32(0)

  connectivity = LibP4est.p4est_connectivity_new_periodic()
  @assert LibP4est.p4est_connectivity_is_valid(connectivity) == 1

  p4est_ptr = LibP4est.p4est_new_ext(mpicomm, connectivity, 0, 1, 1, sizeof(qinner_data_t),
                                     C_NULL, C_NULL)

  memory_used = LibP4est.p4est_memory_used(p4est_ptr)
  println("Memory used = ", memory_used)

  p4est = LibP4est.ptr2obj(p4est_ptr)

  connection = ones(Int32, 7, p4est.local_num_quadrants)

  CfaceIterate = @cfunction(faceIterate, Cvoid, (Ptr{LibP4est.p4est_iter_face_info_t}, Ptr{Cvoid}))
  LibP4est.p4est_iterate(p4est_ptr, C_NULL, pointer(connection), C_NULL, CfaceIterate, C_NULL)

  clabels = ["ielem ","Level"," x ", " y ", " NbLeft ", "NbRight ", "NbDown "," NbUp "]
  results = [1:p4est.local_num_quadrants transpose(connection)]

  println("=================================================================================")
  pretty_table(results, clabels)
end

