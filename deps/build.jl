using Libdl
using MPI
import Pkg.TOML
using Pkg.Artifacts
import P4est_jll

# setup configuration using ideas from MPI.jl
const config_toml = joinpath(first(DEPOT_PATH), "prefs", "P4est.toml")
mkpath(dirname(config_toml))

if !isfile(config_toml)
  touch(config_toml)
end

config = TOML.parsefile(config_toml)

# P4est.toml has the following keys:
#  p4est_generate_bindings = "" (default) | if non-empty, re-generate bindings during build stage
#  p4est_path              = "" (default) | path to p4est containing subdirectories lib and include
#  p4est_library           = "" (default) | library name/path
#  p4est_include           = "" (default) | include name/path
#  p4est_uses_mpi          = "" (default) | "yes" indicates that we need the MPI headers
#  mpi_path                = "" (default) | path to MPI containing subdirectories lib and include
#  mpi_include             = "" (default) | include name/path


# Step 1: Check environment variables and update preferences accordingly
if haskey(ENV, "JULIA_P4EST_GENERATE_BINDINGS")
  config["p4est_generate_bindings"] = ENV["JULIA_P4EST_GENERATE_BINDINGS"]
else
  config["p4est_generate_bindings"] = ""
end

if haskey(ENV, "JULIA_P4EST_PATH")
  config["p4est_path"] = ENV["JULIA_P4EST_PATH"]
else
  config["p4est_path"] = ""
end

if haskey(ENV, "JULIA_P4EST_LIBRARY")
  config["p4est_library"] = ENV["JULIA_P4EST_LIBRARY"]
else
  config["p4est_library"] = ""
end

if haskey(ENV, "JULIA_P4EST_INCLUDE")
  config["p4est_include"] = ENV["JULIA_P4EST_INCLUDE"]
else
  config["p4est_include"] = ""
end

if haskey(ENV, "JULIA_P4EST_USES_MPI")
  config["p4est_uses_mpi"] = ENV["JULIA_P4EST_USES_MPI"]
else
  config["p4est_uses_mpi"] = ""
end

if haskey(ENV, "JULIA_P4EST_MPI_PATH")
  config["mpi_path"] = ENV["JULIA_P4EST_MPI_PATH"]
else
  config["mpi_path"] = ""
end

if haskey(ENV, "JULIA_P4EST_MPI_INCLUDE")
  config["mpi_include"] = ENV["JULIA_P4EST_MPI_INCLUDE"]
else
  config["mpi_include"] = ""
end


open(config_toml, "w") do io
  TOML.print(io, config)
end


if isempty(config["p4est_generate_bindings"])
  println("Use pre-generated bindings for p4est")
  const bindings_filename = joinpath(@__DIR__, "libp4est.jl")
  const pre_generated_bindings_filename = joinpath(artifact"libp4est", "libp4est.jl")
  cp(pre_generated_bindings_filename, bindings_filename, force=true)
else
  # Install CBindingGen locally and undo the modifications of Project.toml afterwards.
  # This allows us to work around limitations of CBindingGen.jl on Julia v1.7
  # while still being able to use the pre-generated bindings (but only them).
  using Pkg
  project_file   = joinpath(@__DIR__, "Project.toml")
  project_backup = joinpath(@__DIR__, "Project.toml.backup")
  cp(project_file, project_backup)
  Pkg.add(PackageSpec("CBindingGen", Base.UUID("308a6e0c-0495-45e1-b1ab-67fb455a0d77"), v"0.4.5"))
  using CBindingGen
  mv(project_backup, project_file, force=true)

  # Step 2: Choose p4est library according to the settings
  p4est_library = ""
  if !isempty(config["p4est_library"])
    p4est_library = config["p4est_library"]
    println("Use custom p4est library $p4est_library")
  elseif !isempty(config["p4est_path"])
    p4est_library = joinpath(config["p4est_path"], "lib", "libp4est." * Libdl.dlext)
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


  # Step 3a: Choose the p4est include path according to the settings
  include_directories = String[]
  p4est_include = ""
  if !isempty(config["p4est_include"])
    p4est_include = config["p4est_include"]
    println("Use custom p4est include path $p4est_include")
  elseif !isempty(config["p4est_path"])
    p4est_include = joinpath(config["p4est_path"], "include")
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


  # Step 3b: Choose the MPI include path according to the settings
  if config["p4est_uses_mpi"] == "yes"
    mpi_include = ""
    if !isempty(config["mpi_include"])
      mpi_include = config["mpi_include"]
      println("Use custom MPI include path $mpi_include")
    elseif !isempty(config["mpi_path"])
      mpi_include = joinpath(config["mpi_path"], "include")
      if isdir(mpi_include)
        println("Use custom MPI include path $mpi_include")
      else
        mpi_include = ""
      end
    end

    if isempty(mpi_include)
      mpi_include = joinpath(dirname(dirname(normpath(dlpath(MPI.libmpi)))), "include")
      println("Use MPI include path based on path to `MPI.jl`'s `libmpi`")
    end

    if !isfile(joinpath(mpi_include, "mpi.h"))
      error("could not find `mpi.h` in ", mpi_include)
    end

    push!(include_directories, mpi_include)
  end


  # Step 4: Generate binding using the include path according to the settings

  # Manually set header files to consider
  hdrs = ["p4est.h", "p4est_extended.h",
          "p6est.h", "p6est_extended.h",
          "p8est.h", "p8est_extended.h"]

  # Build list of arguments for Clang
  include_args = String[]
  @show include_directories
  for dir in include_directories
    append!(include_args, ("-I", dir))
  end

  # Workaround for MacOS: The some headers required by p4est (such as `math.h`) are only available via
  # Xcode
  if Sys.isapple()
    # These two paths *should* - on any reasonably current MacOS system - contain the relevant headers
    const xcode_include_path_cli = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/"
    const xcode_include_path_gui = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
    if !isdir(xcode_include_path_cli) && !isdir(xcode_include_path_gui)
      error("MacOS SDK include paths ('$xcode_include_path_cli' or '$xcode_include_path_gui') do not exist. Have you installed Xcode?")
    end
    append!(include_args, ("-idirafter", xcode_include_path_cli, "-idirafter", xcode_include_path_gui))
  end

  # Convert symbols in header
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
end
