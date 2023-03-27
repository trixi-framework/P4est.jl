
# Copy files and modify them for the docs so that we do not maintain two
# versions manually.
open(joinpath(@__DIR__, "src", "authors.md"), "w") do io
  # Point to source license file
  println(io, """
  ```@meta
  EditURL = "https://github.com/trixi-framework/P4est.jl/blob/main/AUTHORS.md"
  ```
  """)
  # Write the modified contents
  for line in eachline(joinpath(dirname(@__DIR__), "AUTHORS.md"))
    line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
    line = replace(line, "# Authors" => "# [Authors](@id authors_separate_page)")
    println(io, line)
  end
end

open(joinpath(@__DIR__, "src", "license.md"), "w") do io
  # Point to source license file
  println(io, """
  ```@meta
  EditURL = "https://github.com/trixi-framework/P4est.jl/blob/main/LICENSE.md"
  ```
  """)
  # Write the modified contents
  println(io, "# License")
  println(io, "")
  for line in eachline(joinpath(dirname(@__DIR__), "LICENSE.md"))
    line = replace(line, "[AUTHORS.md](AUTHORS.md)" => "[Authors](@ref authors_separate_page)")
    println(io, "> ", line)
  end
end

open(joinpath(@__DIR__, "src", "contributing.md"), "w") do io
  # Point to source license file
  println(io, """
  ```@meta
  EditURL = "https://github.com/trixi-framework/P4est.jl/blob/main/CONTRIBUTING.md"
  ```
  """)
  # Write the modified contents
  for line in eachline(joinpath(dirname(@__DIR__), "CONTRIBUTING.md"))
    line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
    line = replace(line, "[AUTHORS.md](AUTHORS.md)" => "[Authors](@ref authors_separate_page)")
    println(io, line)
  end
end

open(joinpath(@__DIR__, "src", "index.md"), "w") do io
  # Point to source license file
  println(io, """
  ```@meta
  EditURL = "https://github.com/trixi-framework/P4est.jl/blob/main/README.md"
  ```
  """)
  # Write the modified contents
  for line in eachline(joinpath(dirname(@__DIR__), "README.md"))
    line = replace(line, "[LICENSE.md](LICENSE.md)" => "[License](@ref)")
    line = replace(line, "[AUTHORS.md](AUTHORS.md)" => "[Authors](@ref authors_separate_page)")
    line = replace(line, "[Usage](#usage)" => "[Usage](#Usage)")
    println(io, line)
  end
end

# If we want to build the docs locally, add the parent folder to the
# load path so that we can use the current development version of P4est.jl.
# See also https://github.com/trixi-framework/Trixi.jl/issues/668
if (get(ENV, "CI", nothing) != "true") && (get(ENV, "JULIA_P4EST_DOC_DEFAULT_ENVIRONMENT", nothing) != "true")
    push!(LOAD_PATH, dirname(@__DIR__))
end

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

using Documenter
using P4est

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(P4est, :DocTestSetup, :(using P4est); recursive = true)

# Make documentation
makedocs(
  # Specify modules for which docstrings should be shown
  modules = [P4est],
  # Set sitename to P4est
  sitename = "P4est.jl",
  # Provide additional formatting options
  format = Documenter.HTML(
    # Disable pretty URLs during manual testing
    prettyurls = get(ENV, "CI", nothing) == "true",
    # Explicitly add favicon as asset
    # assets = ["assets/favicon.ico"],
    # Set canonical URL to GitHub pages URL
    canonical = "https://trixi-framework.github.io/P4est.jl/stable"
  ),
  # Explicitly specify documentation structure
  pages = [
    "Home" => "index.md",
    "Introduction" => "introduction.md",
    "Troubleshooting and FAQ" => "troubleshooting.md",
    "API reference" => "reference.md",
    "Authors" => "authors.md",
    "Contributing" => "contributing.md",
    "License" => "license.md"
  ],
  strict = true, # `true` lets Documenter CI fail when doctests fail
  checkdocs = :exports, # complain only about non-included docstrings for exported names
)

deploydocs(
  repo = "github.com/trixi-framework/P4est.jl",
  devbranch = "main",
  push_preview = true
)
