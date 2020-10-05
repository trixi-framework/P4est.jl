@reexport baremodule LibP4est
  using CBinding: 𝐣𝐥
  
  const size_t  = 𝐣𝐥.Csize_t
  const ssize_t = 𝐣𝐥.Cssize_t
  const int8_t  = 𝐣𝐥.Int8
  const int16_t = 𝐣𝐥.Int16
  const int32_t = 𝐣𝐥.Int32
  const int64_t = 𝐣𝐥.Int64
  const FILE = Cvoid # FIXME: Use proper C type
  const va_list = Cvoid # FIXME: Use proper C type
  𝐣𝐥.Base.include((𝐣𝐥.@__MODULE__), 𝐣𝐥.joinpath(𝐣𝐥.dirname(𝐣𝐥.@__DIR__), "deps", "libp4est.jl"))

  """
      ptr2obj(ptr::Ptr{T}) where T

  Convert pointer to object reference by wrapping it in `unsafe_wrap`.
  """
  ptr2obj(ptr::Ptr{T}) where T = 𝐣𝐥.unsafe_wrap(T, ptr)

  export ptr2obj
end
