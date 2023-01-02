module PointerWrappers

# Pointer wrapper for conveniently accessing nested structures
struct PointerWrapper{T}
  pointer::Ptr{T}
end

# Non-pointer-type fields get wrapped as a normal PointerWrapper
PointerWrapper(::Type{T}, pointer) where T = PointerWrapper{T}(pointer)

# Pointer-type fields get dereferenced such that PointerWrapper wraps the pointer to the field type
PointerWrapper(::Type{Ptr{T}}, pointer) where T = PointerWrapper{T}(unsafe_load(Ptr{Ptr{T}}(pointer)))

# Cannot use `pw.pointer` since we implement `getproperty` to return the fields of `T` itself
Base.pointer(pw::PointerWrapper{T}) where T = getfield(pw, :pointer)

# Syntactic sugar
Base.propertynames(::PointerWrapper{T}) where T = fieldnames(T)

# Syntactic sugar: allows one to use `pw.fieldname` to get a PointerWrapper-wrapped pointer to `fieldname`
function Base.getproperty(pw::PointerWrapper{T}, name::Symbol) where T
  i = findfirst(isequal(name), fieldnames(T))
  if isnothing(i)
    error("type $(string(T)) has no field $name")
  end

  PointerWrapper(fieldtype(T, i), pointer(pw) + fieldoffset(T, i))
end

# `[]` allows one to access the actual underlying data
Base.getindex(pw::PointerWrapper{T}) where T = unsafe_load(pw)
Base.setindex!(pw::PointerWrapper{T}, value) where T = unsafe_store!(pw, value)

# When `unsafe_load`ing a PointerWrapper object, we really want to load the underlying object
Base.unsafe_load(pw::PointerWrapper{T}) where T = unsafe_load(pointer(pw))

# If value is of the wrong type, try to convert it
Base.unsafe_store!(pw::PointerWrapper{T}, value) where T = unsafe_store!(pw, convert(T, value))

# Store value to wrapped location
Base.unsafe_store!(pw::PointerWrapper{T}, value::T) where T = unsafe_store!(pointer(pw), value)

end
