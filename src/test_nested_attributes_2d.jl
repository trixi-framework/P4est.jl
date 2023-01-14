# some auxiliary functions
function unsafe_load_sc(::Type{T}, sc_array::Ptr{sc_array}, i=1) where T
  sc_array_obj = unsafe_load(sc_array)
  return unsafe_load_sc(T, sc_array_obj, i)
end

function unsafe_load_sc(::Type{T}, sc_array_obj::sc_array, i=1) where T
  element_size = sc_array_obj.elem_size
  @assert element_size == sizeof(T)

  return unsafe_load(Ptr{T}(sc_array_obj.array), i)
end

function unsafe_load_side(info::Ptr{p4est_iter_face_info_t}, i=1)
  return unsafe_load_sc(p4est_iter_face_side_t, unsafe_load(info).sides, i)
end


function pointerwrapper_sc(::Type{T}, sc_array::Ptr{sc_array}, i=1) where T
  sc_array_pw = Pointerwrapper(sc_array)
  return pointerwrapper_sc(T, sc_array_pw, i)
end

function pointerwrapper_sc(::Type{T}, sc_array_pw::sc_array, i=1) where T
  element_size = sc_array_pw.elem_size
  @assert element_size == sizeof(T)

  return Pointerwrapper(Ptr{T}(sc_array_pw.array), i)
end

function pointerwrapper_side(info::Ptr{p4est_iter_face_info_t}, i=1)
  return pointerwrapper_sc(p4est_iter_face_side_t, Pointerwrapper(info).sides, i)
end

function refine_fn(p4est, which_tree, quadrant)
  quadrant_obj = unsafe_load(quadrant)
  if quadrant_obj.x == 0 && quadrant_obj.y == 0 && quadrant_obj.level < 4
    return Cint(1)
  else
    return Cint(0)
  end
end

function iter_face_unsafe_load(info::Ptr{p4est_iter_face_info_t}, user_data)
  info_obj = unsafe_load(info)
  info_obj.sides.elem_count
  if info_obj.sides.elem_count == 2
    sides = (unsafe_load_side(info, 1), unsafe_load_side(info, 2))
    sides[1].is_hanging
    sides[2].is_hanging
    sides[1].is.full.is_ghost
    sides[2].is.full.is_ghost
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
      sides[local_side].treeid
      sides[local_side].is.full.quadid
      unsafe_wrap(Array,
                  unsafe_load(info_obj.ghost_layer).proc_offsets,
                  MPI.Comm_size(MPI.COMM_WORLD) + 1)
      sides[remote_side].is.full.quadid
      if local_side == 2
        unsafe_load(sides[2].is.full.quad.p.piggy3.local_num)
      end
    else # hanging node
      if sides[1].is_hanging == true
        hanging_side = 1
        full_side = 2
      else
        hanging_side = 2
        full_side = 1
      end
      sides[hanging_side].is_hanging == true && sides[full_side].is_hanging == false
      sides[full_side].is.full.is_ghost isa Integer
      sides[hanging_side].is.hanging.is_ghost isa Tuple{Int8, Int8}
      if sides[full_side].is.full.is_ghost == false && all(sides[hanging_side].is.hanging.is_ghost .== false)
        return nothing
      end
    end
  end
  return nothing
end

function iter_face_pointerwrapper(info::Ptr{p4est_iter_face_info_t}, user_data)
  info_pw = PointerWrapper(info)
  info_pw.sides.elem_count
  if info_pw.sides.elem_count == 2
    sides = (pointerwrapper_side(info, 1), pointerwrapper_side(info, 2))
    sides[1].is_hanging
    sides[2].is_hanging
    sides[1].is.full.is_ghost
    sides[2].is.full.is_ghost
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
      sides[local_side].treeid
      sides[local_side].is.full.quadid
      unsafe_wrap(Array,
                  info_pw.ghost_layer.proc_offsets,
                  MPI.Comm_size(MPI.COMM_WORLD) + 1)
      sides[remote_side].is.full.quadid
      if local_side == 2
        PointerWrapper(sides[2].is.full.quad.p.piggy3.local_num)
      end
    else # hanging node
      if sides[1].is_hanging == true
        hanging_side = 1
        full_side = 2
      else
        hanging_side = 2
        full_side = 1
      end
      sides[hanging_side].is_hanging == true && sides[full_side].is_hanging == false
      sides[full_side].is.full.is_ghost isa Integer
      sides[hanging_side].is.hanging.is_ghost isa Tuple{Int8, Int8}
      if sides[full_side].is.full.is_ghost == false && all(sides[hanging_side].is.hanging.is_ghost .== false)
        return nothing
      end
    end
  end
  return nothing
end

connectivity = p4est_connectivity_new_brick(2, 2, 0, 0)
p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
refine_fn_c = @cfunction(refine_fn, Cint,
                         (Ptr{p4est_t}, Ptr{p4est_topidx_t}, Ptr{p4est_quadrant_t}))
p4est_refine(p4est, true, refine_fn_c, C_NULL)

iter_face_unsafe_load_c = @cfunction(iter_face_unsafe_load, Cvoid,
                                     (Ptr{p4est_iter_face_info_t}, Ptr{Cvoid}))
iter_face_pointerwrapper_c = @cfunction(iter_face_pointerwrapper, Cvoid,
                                        (Ptr{p4est_iter_face_info_t}, Ptr{Cvoid}))
