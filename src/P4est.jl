module P4est
	using Reexport: @reexport
	
	
	@reexport module libp4est
		using CBinding
		import P4est_jll
		
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
		
		const c"int8_t" = Int8
		const c"int16_t" = Int16
		const c"int32_t" = Int32
		const c"int64_t" = Int64
		const c"uint8_t" = UInt8
		const c"uint16_t" = UInt16
		const c"uint32_t" = UInt32
		const c"uint64_t" = UInt64
		const c"size_t" = Csize_t
		const c"ssize_t" = Cssize_t
		
		# define them as Cvoid since they are usually used as opaque
		const c"FILE"    = Cvoid
		const c"va_list" = Cvoid
		
		c"""
			#include <p4est.h>
			#include <p4est_extended.h>
			#include <p6est.h>
			#include <p6est_extended.h>
			#include <p8est.h>
			#include <p8est_extended.h>
		"""ji

    # Commit type piracy to add support array-to-pointer conversion for AbstractArray
    # Source: Keith Rutkowski, https://github.com/trixi-framework/Trixi.jl/pull/835#issuecomment-910256496
    Base.unsafe_convert(::Type{Cptr{T}}, x::AbstractArray) where {T} = Core.Intrinsics.bitcast(Cptr{T}, Base.unsafe_convert(Ptr{eltype(x)}, x))
	end
end
