using CBinding
import P4est_jll


# this will eventually be available in CBinding
function generate(exprs::Expr, libs::Pair...)
	exprs = Base.is_expr(exprs, :block) ? exprs : quote $(exprs) end
	
	libs = map(enumerate(libs)) do (ind, (from, to))
		basedir = Symbol(:_basedir_, ind, :_)
		libdir  = Symbol(:_libdir_, ind, :_)
		pushfirst!(exprs.args,
			:(const $(basedir) = "$(dirname(dirname($(to))))"),
			:(const $(libdir)  = "$(dirname($(to)))"),
		)
		return (from, basedir, libdir)
	end
	
	str = string(exprs)
	for (from, basedir, libdir) in libs
		str = replace(str, r"(\W)"*dirname(from)*"/" => SubstitutionString("\\1$(string(:("$($(libdir))"))[2:end-1])/"))
		str = replace(str, r"(\W)"*dirname(dirname(from))*"/" => SubstitutionString("\\1$(string(:("$($(basedir))"))[2:end-1])/"))
	end
	
	lines = []
	for line in split(str, '\n')
		l = strip(line)
		startswith(l, "#=") && endswith(l, "=#") && continue
		
		m = match(r"/(home|usr|[^/.]+\.jl)/", l)
		isnothing(m) || @warn "Unsanitized paths may remain:  $(l)"
		
		push!(lines, line)
	end
	return join(lines, '\n')
end



let
	flags = [
		"-I", joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include"),
		"-L", joinpath(dirname(dirname(P4est_jll.libp4est_path)), "lib"),
		
		# workaround to get these non-existent API items to go away
		"-D", "sc_extern_c_hack_3(...)=",
		"-D", "sc_extern_c_hack_4(...)=",
		"-D", "P2EST_DATA_UNINITIALIZED=",
		"-D", "p8est_ghost_tree_contains(...)=",
	]
	
	# These two paths *should* - on any reasonably current MacOS system - contain the relevant headers
	Sys.isapple() && append!(flags, [
		"-idirafter", "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
		"-idirafter", "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
	])
	
	c`$(flags) -lp4est`
end

libp4est = generate(@macroexpand(c"""
		#include <p4est.h>
		#include <p4est_extended.h>
		#include <p6est.h>
		#include <p6est_extended.h>
		#include <p8est.h>
		#include <p8est_extended.h>
	"""jium),
	P4est_jll.libp4est_path => :(P4est_jll.libp4est_path),
)

open(joinpath(@__DIR__, "libp4est.jl"), "w+") do io
	println(io, libp4est)
end
