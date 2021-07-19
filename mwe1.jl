module LibP4est
import P4est_jll
using CBinding

p4est_library = P4est_jll.libp4est_path
p4est_include = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include")
p4est_library_dir = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "lib")
c`-I$p4est_include -L$p4est_library_dir -lp4est`

const c"size_t" = Csize_t
const c"int8_t" = Int8
const c"int16_t" = Int16
const c"int32_t" = Int32
const c"int64_t" = Int64
const c"uint64_t" = UInt64

# Convert to string and remove line numbers
stringify(expr) = string(Base.remove_linenums!(expr))

c"""
  #include <stdio.h>
  #include <stdarg.h>

  #include "p4est.h"
  #include "p4est_extended.h"
  #include "p6est.h"
  #include "p6est_extended.h"
  #include "p8est.h"
  #include "p8est_extended.h"
"""jiu
end
