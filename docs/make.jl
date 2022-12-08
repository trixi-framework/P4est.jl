using Documenter
import Pkg

# If we want to build the docs locally, add the parent folder to the
# load path so that we can use the current development version of P4est.jl.
# See also https://github.com/trixi-framework/Trixi.jl/issues/668
if (get(ENV, "CI", nothing) != "true") && (get(ENV, "P4EST_DOC_DEFAULT_ENVIRONMENT", nothing) != "true")
    push!(LOAD_PATH, dirname(@__DIR__))
end

using P4est

# Define module-wide setups such that the respective modules are available in doctests
DocMeta.setdocmeta!(P4est, :DocTestSetup, :(using P4est); recursive=true)

# Make documentation
makedocs(
  # Specify modules for which docstrings should be shown
  modules = [P4est],
  # Set sitename to P4est
  sitename="P4est.jl",
  # Provide additional formatting options
  format = Documenter.HTML(
    # Disable pretty URLs during manual testing
    prettyurls = get(ENV, "CI", nothing) == "true",
    # Explicitly add favicon as asset
    # assets = ["assets/favicon.ico"],
    # Set canonical URL to GitHub pages URL
    canonical = "https://trixi-framework.github.io/P4est.jl/dev"
  ),
  # Explicitly specify documentation structure
  pages = [
    "Home" => "index.md",
    "Reference" => "reference.md",
    "License" => "license.md"
  ],
  strict = true # to make the GitHub action fail when doctests fail, see https://github.com/neuropsychology/Psycho.jl/issues/34
)

deploydocs(
  repo = "github.com/trixi-framework/P4est.jl",
  devbranch = "main",
  push_preview = true
)
