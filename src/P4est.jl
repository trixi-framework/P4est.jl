module P4est
	using Reexport: @reexport
	
	
	@reexport module libp4est
		using CBinding
		import P4est_jll
		
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
		
		include(joinpath(dirname(@__DIR__), "deps", "libp4est.jl"))
	end
end
