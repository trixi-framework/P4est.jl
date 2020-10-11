using CBindingGen
using Libdl
import Pkg.TOML
import P4est_jll


# setup configuration using ideas from MPI.jl
config_toml = joinpath(first(DEPOT_PATH), "prefs", "P4est.toml")
mkpath(dirname(config_toml))

if !isfile(config_toml)
  touch(config_toml)
end

config = TOML.parsefile(config_toml)

# P4est.toml has 3 keys
#  path     = "" (default) | path to p4est containing subdirectories lib and include
#  library  = "" (default) | library name/path
#  include  = "" (default) | include name/path


# Step 1: Check environment variables and update preferences accordingly
if haskey(ENV, "JULIA_P4EST_PATH")
	config["path"] = ENV["JULIA_P4EST_PATH"]
else
	config["path"] = ""
end

if haskey(ENV, "JULIA_P4EST_LIBRARY")
	config["library"] = ENV["JULIA_P4EST_LIBRARY"]
else
	config["library"] = ""
end

if haskey(ENV, "JULIA_P4EST_INCLUDE")
	config["include"] = ENV["JULIA_P4EST_INCLUDE"]
else
	config["include"] = ""
end


open(config_toml, "w") do io
	TOML.print(io, config)
end



# Step 2: Choose the library according to the settings
p4est_library = ""
if !isempty(config["library"])
	p4est_library = config["library"]
	println("Use custom p4est library $p4est_library")
elseif !isempty(config["path"])
	# TODO: Linux only
	p4est_library = joinpath(config["path"], "lib", "libp4est.so")
	if isfile(p4est_library)
		println("Use custom p4est library $p4est_library")
	else
		p4est_library = ""
	end
end

if isempty(p4est_library)
	p4est_library = P4est_jll.libp4est_path
	println("Use p4est library provided by P4est_jll")
end



# Step 3: Choose the include path according to the settings
include_directories = String[]
p4est_include = ""
if !isempty(config["include"])
	p4est_include = config["include"]
	println("Use custom p4est include path $p4est_include")
elseif !isempty(config["path"])
	p4est_include = joinpath(config["path"], "include")
	if isdir(p4est_include)
		println("Use custom p4est include path $p4est_include")
	else
		p4est_include = ""
	end
end

if isempty(p4est_include)
	p4est_include = joinpath(dirname(dirname(P4est_jll.libp4est_path)), "include")
	println("Use p4est include path provided by P4est_jll")
end

push!(include_directories, p4est_include)



# Step 4: Generate binding using the include path according to the settings

# Manually set header files to consider
hdrs = ["p4est.h", "p4est_extended.h", "p8est.h", "p8est_extended.h"]

# Convert symbols in header
include_args = String[]
@show include_directories
for dir in include_directories
	append!(include_args, ("-I", dir))
end
cvts = convert_headers(hdrs, args=include_args) do cursor
	header = CodeLocation(cursor).file
	name   = string(cursor)

	# only wrap the libp4est and libsc headers
	dirname, filename = splitdir(header)
	if !(filename in hdrs ||
		   startswith(filename, "p4est_") ||
		   startswith(filename, "p6est_") ||
		   startswith(filename, "p8est_") ||
			 startswith(filename, "sc_") ||
			 filename == "sc.h" )
		return false
	end

  # Ignore macro hacks
  startswith(name, "sc_extern_c_hack_") && return false

	return true
end

# Write generated C bindings to file
const bindings_filename = joinpath(@__DIR__, "libp4est.jl")
open(bindings_filename, "w+") do io
	generate(io, p4est_library => cvts)
end
