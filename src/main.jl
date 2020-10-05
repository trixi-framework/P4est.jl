@cstruct qinner_data_t {
  face::Int8
  Element_id::Int32
}


function faceIterate(info_ptr::Ptr{LibP4est.p4est_iter_face_info_t}, user_data_ptr::Ptr{Cvoid})
    info = LibP4est.ptr2obj(info_ptr)
    p4est = LibP4est.ptr2obj(info.p4est)
    connection = unsafe_wrap(Array, Ptr{Int32}(user_data_ptr), (7, Int(p4est.local_num_quadrants)); own=false)

    sidec01 = unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array)
    sidec12 = unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array + info.sides.elem_size)

    quad0 = LibP4est.ptr2obj(sidec01.is.full.quad)
    quad1 = LibP4est.ptr2obj(sidec12.is.full.quad)
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


function faceIterate2(info_ptr::Ptr{LibP4est.p4est_iter_face_info_t}, user_data_ptr::Ptr{Cvoid})
    info = LibP4est.ptr2obj(info_ptr)
    p4est = LibP4est.ptr2obj(info.p4est)
    connection = unsafe_wrap(Array, Ptr{Int32}(user_data_ptr), (11, Int(p4est.local_num_quadrants)); own=false)

    sides = [unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array),
        unsafe_wrap(LibP4est.p4est_iter_face_side_t, info.sides.array + info.sides.elem_size)]
    if (sides[1].is_hanging == 0 && sides[2].is_hanging == 0)

        quads = [unsafe_wrap(LibP4est.p4est_quadrant_t, sides[1].is.full.quad),
            unsafe_wrap(LibP4est.p4est_quadrant_t, sides[2].is.full.quad)]
        quadIds = [sides[1].is.full.quadid, sides[2].is.full.quadid]
        connection[1, quadIds[1] + 1] = quads[1].level
        connection[1, quadIds[2] + 1] = quads[2].level

        connection[2, quadIds[1] + 1] = trunc(Int, 16 * quads[1].x / 2147483647)
        connection[2, quadIds[2] + 1] = trunc(Int, 16 * quads[2].x / 2147483647)

        connection[3, quadIds[1] + 1] = trunc(Int, 16 * quads[1].y / 2147483647)
        connection[3, quadIds[2] + 1] = trunc(Int, 16 * quads[2].y / 2147483647)

        connection[sides[1].face * 2 + 4,quadIds[1] + 1] = quadIds[2] + 1
        connection[sides[2].face * 2 + 4,quadIds[2] + 1] = quadIds[1] + 1
    else
        BigSide = 2
        HangSide = 1
        if sides[2].is_hanging == 1
            BigSide = 1
            HangSide = 2
        end
        quadBig = unsafe_wrap(LibP4est.p4est_quadrant_t, sides[BigSide].is.full.quad)
        quadBigId = sides[BigSide].is.full.quadid
        quadsHanging = [unsafe_wrap(LibP4est.p4est_quadrant_t, sides[HangSide].is.hanging.quad[1]),
                        unsafe_wrap(LibP4est.p4est_quadrant_t, sides[HangSide].is.hanging.quad[2])]
        quadHangIds = [sides[HangSide].is.hanging.quadid[1], sides[HangSide].is.hanging.quadid[2]]

        connection[1, quadBigId + 1] = quadBig.level
        connection[1, quadHangIds[1] + 1] = quadsHanging[1].level
        connection[1, quadHangIds[2] + 1] = quadsHanging[2].level

        connection[2, quadBigId + 1] = trunc(Int, 16 * quadBig.x / 2147483647)
        connection[2, quadHangIds[1] + 1] = trunc(Int, 16 * quadsHanging[1].x / 2147483647)
        connection[2, quadHangIds[2] + 1] = trunc(Int, 16 * quadsHanging[2].x / 2147483647)

        connection[3, quadBigId + 1] = trunc(Int, 16 * quadBig.y / 2147483647)
        connection[3, quadHangIds[1] + 1] = trunc(Int, 16 * quadsHanging[1].y / 2147483647)
        connection[3, quadHangIds[2] + 1] = trunc(Int, 16 * quadsHanging[2].y / 2147483647)

        connection[sides[BigSide].face * 2 + 4,quadBigId + 1] = quadHangIds[1] + 1
        connection[sides[BigSide].face * 2 + 5,quadBigId + 1] = quadHangIds[2] + 1

        connection[sides[HangSide].face * 2 + 4,quadHangIds[1] + 1] = quadBigId + 1
        connection[sides[HangSide].face * 2 + 5,quadHangIds[1] + 1] = quadBigId + 1

        connection[sides[HangSide].face * 2 + 4,quadHangIds[2] + 1] = quadBigId + 1
        connection[sides[HangSide].face * 2 + 5,quadHangIds[2] + 1] = quadBigId + 1

    end

    return nothing
end


function main()
  mpicomm = Int32(0)

  connectivity = LibP4est.p4est_connectivity_new_periodic()
  @assert LibP4est.p4est_connectivity_is_valid(connectivity) == 1

  # p4est_ptr = LibP4est.p4est_new_ext(mpicomm, connectivity, 0, 1, 1, sizeof(qinner_data_t),
  #                                    C_NULL, C_NULL)
  p4est_ptr = LibP4est.p4est_new_ext(mpicomm, connectivity, 0, 2, 0, sizeof(qinner_data_t),
                                     C_NULL, C_NULL)

  memory_used = LibP4est.p4est_memory_used(p4est_ptr)
  println("Memory used = ", memory_used)

  p4est = LibP4est.ptr2obj(p4est_ptr)

  # connection = ones(Int32, 7, p4est.local_num_quadrants)

  # CfaceIterate = @cfunction(faceIterate, Cvoid, (Ptr{LibP4est.p4est_iter_face_info_t}, Ptr{Cvoid}))
  # LibP4est.p4est_iterate(p4est_ptr, C_NULL, pointer(connection), C_NULL, CfaceIterate, C_NULL)

  # clabels = ["ielem ","Level"," x ", " y ", " NbLeft ", "NbRight ", "NbDown "," NbUp "]
  # results = [1:p4est.local_num_quadrants transpose(connection)]
  connection = ones(Int32, 11, p4est.local_num_quadrants)

  CfaceIterate2 = @cfunction(faceIterate2, Cvoid, (Ptr{LibP4est.p4est_iter_face_info_t}, Ptr{Cvoid}))
  LibP4est.p4est_iterate(p4est_ptr, C_NULL, pointer(connection), C_NULL, CfaceIterate2, C_NULL)

clabels = ["ielem ","Level"," x ", " y ", " NbLeft 1 ", " NbLeft 2 ", "NbRight 1" , "NbRight 2",
                "NbDown 1","NbDown 2"," NbUp 1", " NbUp 2"]
  results = [1:p4est.local_num_quadrants transpose(connection)]

  println("=================================================================================")
  pretty_table(results, clabels)
end

