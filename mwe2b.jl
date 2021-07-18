module LibP4est
  import P4est_jll
  using CBinding
  const c"size_t" = Csize_t
  const c"int8_t" = Int8
  const c"int16_t" = Int16
  const c"int32_t" = Int32
  const c"int64_t" = Int64
  const c"uint64_t" = UInt64
  include("libp4est-mwe2.jl")
end
