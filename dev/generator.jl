using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

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
