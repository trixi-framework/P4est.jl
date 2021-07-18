# @reexport baremodule LibP4est
@reexport module LibP4est
  # using CBinding: 𝐣𝐥
  using MPI: MPI_Datatype, MPI_Comm, MPI_File
  
  # Introduce standard integer types
  # const size_t   = 𝐣𝐥.Csize_t
  # const ssize_t  = 𝐣𝐥.Cssize_t
  # const int8_t   = 𝐣𝐥.Int8
  # const int16_t  = 𝐣𝐥.Int16
  # const int32_t  = 𝐣𝐥.Int32
  # const int64_t  = 𝐣𝐥.Int64
  # const uint64_t = 𝐣𝐥.UInt64

  # Forward declare standard library types
  # 𝐣𝐥.@cstruct FILE
  # 𝐣𝐥.@cstruct va_list

  # 𝐣𝐥.Base.include((𝐣𝐥.@__MODULE__), 𝐣𝐥.joinpath(𝐣𝐥.dirname(𝐣𝐥.@__DIR__), "deps", "libp4est.jl"))
  include(joinpath(dirname(@__DIR__), "deps", "libp4est.jl"))
end
