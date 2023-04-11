module PointerWrappers

export PointerWrapper

"""
    PointerWrapper(p::Ptr)

Wrap the pointer `p` to conveniently access the data of the underlying `struct`.
Fields of the `struct` (or the `struct` itself) can be dereferenced for reading/writing
using `[]`. As opposed to using `unsafe_load`/`unsafe_store` on the `struct` directly,
the `[]` operator only accesses the memory for the requested field, thereby avoiding
to having to load/store the entire struct when accessing only a single field. This can
be helpful especially when accessing data in nested structures.

### Example
```repl
julia> using P4est, MPI

julia> MPI.Init()
MPI.ThreadLevel(2)

julia> connectivity = p4est_connectivity_new_brick(2, 2, 0, 0)
Ptr{p4est_connectivity} @0x000060000378b010

julia> p4est = p4est_new_ext(MPI.COMM_WORLD, connectivity, 0, 0, true, 0, C_NULL, C_NULL)
Into p4est_new with min quadrants 0 level 0 uniform 1
New p4est with 4 trees on 1 processors
Initial level 0 potential global quadrants 4 per tree 1
Done p4est_new with 4 total quadrants
Ptr{P4est.LibP4est.p4est} @0x0000600002b9d7b0

julia> p4est_pw = PointerWrapper(p4est)
PointerWrapper{P4est.LibP4est.p4est}(Ptr{P4est.LibP4est.p4est} @0x0000600002b9d7b0)

julia> p4est_pw.connectivity.num_trees[]
4
```
"""
struct PointerWrapper{T}
  pointer::Ptr{T}
end

# Non-pointer-type fields get wrapped as a normal PointerWrapper
PointerWrapper(::Type{T}, pointer) where T = PointerWrapper{T}(pointer)

# Pointer-type fields get dereferenced such that PointerWrapper wraps the pointer to the field type
PointerWrapper(::Type{Ptr{T}}, pointer) where T = PointerWrapper{T}(unsafe_load(Ptr{Ptr{T}}(pointer)))

# Cannot use `pw.pointer` since we implement `getproperty` to return the fields of `T` itself
Base.pointer(pw::PointerWrapper{T}) where T = getfield(pw, :pointer)
# Allow passing a `PointerWrapper` to wrapped C functions
Base.unsafe_convert(::Type{Ptr{T}}, pw::PointerWrapper{T}) where {T} = Base.unsafe_convert(Ptr{T}, pointer(pw))

# Syntactic sugar
Base.propertynames(::PointerWrapper{T}) where T = fieldnames(T)

# Syntactic sugar: allows one to use `pw.fieldname` to get a PointerWrapper-wrapped pointer to `fieldname`
function Base.getproperty(pw::PointerWrapper{T}, name::Symbol) where T
  i = findfirst(isequal(name), fieldnames(T))
  if isnothing(i)
    # For some `struct`s, `fieldnames` gives `data` and not the actual field names, but we can use `Base.getproperty` for pointers,
    # see https://github.com/trixi-framework/P4est.jl/issues/72
    return PointerWrapper(Base.getproperty(pointer(pw), name))
  end

  return PointerWrapper(fieldtype(T, i), pointer(pw) + fieldoffset(T, i))
end

# Syntactic sugar: allows one to use `pw.fieldname` to set `fieldname`
function Base.setproperty!(pw::PointerWrapper{T}, name::Symbol, v) where T
  i = findfirst(isequal(name), fieldnames(T))
  if isnothing(i)
    # For some `struct`s, `fieldnames` gives `data` and not the actual field names, but we can use `Base.setproperty!` for pointers,
    # see https://github.com/trixi-framework/P4est.jl/issues/72 and https://github.com/trixi-framework/P4est.jl/issues/79
    return Base.setproperty!(pointer(pw), name, v)
  end
  return unsafe_store!(reinterpret(Ptr{fieldtype(T, i)}, pointer(pw) + fieldoffset(T, i)), v)
end

# `[]` allows one to access the actual underlying data and
# `[i]` allows one to access the actual underlying data of an array
Base.getindex(pw::PointerWrapper, i::Integer=1) = unsafe_load(pw, i)
Base.setindex!(pw::PointerWrapper, value, i::Integer=1) = unsafe_store!(pw, value, i)

# When `unsafe_load`ing a PointerWrapper object, we really want to load the underlying object
Base.unsafe_load(pw::PointerWrapper, i::Integer=1) = unsafe_load(pointer(pw), i)

# When `unsafe_wrap`ping a PointerWrapper object, we really want to wrap the underlying array
Base.unsafe_wrap(AType::Union{Type{Array},Type{Array{T}},Type{Array{T,N}}},
                 pw::PointerWrapper, dims::NTuple{N,Int}; own::Bool = false) where {T,N} = unsafe_wrap(AType, pointer(pw), dims; own)

# If value is of the wrong type, try to convert it
Base.unsafe_store!(pw::PointerWrapper{T}, value, i::Integer=1) where T = unsafe_store!(pw, convert(T, value), i)

# Store value to wrapped location
Base.unsafe_store!(pw::PointerWrapper{T}, value::T, i::Integer=1) where T = unsafe_store!(pointer(pw), value, i)

end
