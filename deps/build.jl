using CBindingGen
import P4est_jll

# Get include directory from jll package
const incdir = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include")

# Manually set header files to consider
const hdrs = ["p4est.h", "p8est.h", "p4est_extended.h", "p8est_extended.h"]

# Convert symbols in header
cvts = convert_headers(hdrs, args = ["-I", incdir]) do cursor
	header = CodeLocation(cursor).file
	name   = string(cursor)
	
	# only wrap the libp4est headers
	startswith(header, "$(incdir)/") || return false

  # Ignore macro hacks
  startswith(name, "sc_extern_c_hack_") && return false
	
	return true
end

# Write generated C bindings to file
const bindings_filename = joinpath(@__DIR__, "libp4est.jl")
open(bindings_filename, "w+") do io
	generate(io, P4est_jll.libp4est_path => cvts)
end
