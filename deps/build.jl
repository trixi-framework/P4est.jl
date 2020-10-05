using CBindingGen
import P4est_jll

# Get include directory from jll package
const incdir = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include")

# Manually set header files to consider
const hdrs = ["p4est.h", "p8est.h", "p4est_extended.h", "p8est_extended.h"]

# list of names to ignore
const ignored_names =
[
 "sc_extern_c_hack_3",
 "sc_extern_c_hack_4",
]

# Convert symbols in header
cvts = convert_headers(hdrs, args = ["-I", incdir]) do cursor
	header = CodeLocation(cursor).file
	name   = string(cursor)
	
	# only wrap the libp4est headers
	startswith(header, "$(incdir)/") || return false

  # if name is on ignore list, do not add bindings
  name in ignored_names && return false
	
	return true
end

# Write generated C bindings to file
const bindings_filename = joinpath(@__DIR__, "libp4est.jl")
open(bindings_filename, "w+") do io
	generate(io, P4est_jll.libp4est_path => cvts, comments=false)
end

# The following lines are only necessary if `comments=true` (default if omitted) in the call to
# `generate` above:
# # Replace '$' by '`'
# const content = open(bindings_filename, "r") do f
#   read(f, String)
# end
# open(bindings_filename, "w+") do f
#   write(f, replace(content, '$' => '`'))
# end
