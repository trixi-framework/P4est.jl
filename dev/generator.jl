using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

using Artifacts
cp(joinpath(artifact"P4est", "include"), "p4est_include"; force = true)
# This loads the artifact described in `P4est/dev/Artifacts.toml`.
# When a new release of P4est_jll.jl is created and you would like to update
# the headers, you can copy one of the entries of
# https://github.com/JuliaBinaryWrappers/P4est_jll.jl/blob/main/Artifacts.toml
# to this file. Here, we chose the version
# linux - x86_64 - glibc - mpich
# The exact choice should not matter since we use only the header files which
# are the same on each system. However, they may matter in the presence of
# MPI headers since we apply some custom `fixes.sh` afterwards.

using Clang.Generators
# using Clang.LibClang.Clang_jll  # replace this with your jll package

cd(@__DIR__)

include_dir = joinpath(@__DIR__, "p4est_include")

options = load_options(joinpath(@__DIR__, "generator.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()  # Note you must call this function firstly and then append your own flags
push!(args, "-I$include_dir")
# push!(args, "-I$include_dir", "-I/usr/lib/x86_64-linux-gnu/openmpi/include")

headers_rel = ["p4est.h", "p4est_extended.h", "p4est_search.h",
               "p6est.h", "p6est_extended.h",
               "p8est.h", "p8est_extended.h", "p8est_search.h"]
headers = [joinpath(include_dir, header) for header in headers_rel]
# headers = [joinpath(clang_dir, header) for header in readdir(clang_dir) if endswith(header, ".h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
