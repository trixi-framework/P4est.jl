using Clang.Generators
using P4est_jll

cd(@__DIR__)

include_dir = joinpath(P4est_jll.artifact_dir, "include") |> normpath

options = load_options(joinpath(@__DIR__, "mwe3.toml"))

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()
push!(args, "-I$include_dir")

hdrs = ["p4est.h", "p4est_extended.h",
        "p6est.h", "p6est_extended.h",
        "p8est.h", "p8est_extended.h"]
headers = [joinpath(include_dir, header) for header in hdrs]
# headers = [joinpath(clang_dir, header) for header in readdir(clang_dir) if endswith(header, ".h")]
# there is also an experimental `detect_headers` function for auto-detecting top-level headers in the directory
# headers = detect_headers(clang_dir, args)

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
