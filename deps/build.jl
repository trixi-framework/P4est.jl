using CBindingGen
import P4est_jll

# Get include directory from jll package
incdir = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include")

# Manually set header files to consider
hdrs = ["p4est.h", "p8est.h"]

cvts = convert_headers(hdrs, args = ["-I", incdir]) do cursor
	header = CodeLocation(cursor).file
	name   = string(cursor)
	
	# only wrap the libp4est headers
	startswith(header, "$(incdir)/") || return false
	
	return true
end

open(joinpath(@__DIRNAME__, "libp4est.jl"), "w+") do io
	generate(io, P4est_jll.libp4est_path => cvts)
end

