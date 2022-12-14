using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

# Configure the test setup based on environment variables set in CI.
# We test the following combinations set in `P4EST_TEST`:
# - `P4EST_JLL_MPI_DEFAULT`
# - `P4EST_JLL_MPI_CUSTOM`
# - `P4EST_CUSTOM_MPI_DEFAULT`
# - `P4EST_CUSTOM_MPI_CUSTOM`
# For CI runs testing a custom installation of `p4est`, the path to the
# `p4est` library (`libp4est.so` on Linux) has to be set via the environment
# variable `P4EST_TEST_LIBP4EST`.
#
# First, we get the settings and remove all local preference configurations
# that may still exist.
const P4EST_TEST = get(ENV, "P4EST_TEST", "P4EST_JLL_MPI_DEFAULT")
const P4EST_TEST_LIBP4EST = get(ENV, "P4EST_TEST_LIBP4EST", "")
rm(joinpath(@__DIR__, "LocalPreferences.toml"), force = true)

# Next, we configure MPI.jl appropriately.
@static if P4EST_TEST in ("P4EST_JLL_MPI_CUSTOM", "P4EST_CUSTOM_MPI_CUSTOM")
  import MPIPreferences
  MPIPreferences.use_system_binary()
end

# Finally, we configure P4est.jl as desired.
@static if P4EST_TEST in ("P4EST_CUSTOM_MPI_DEFAULT", "P4EST_CUSTOM_MPI_CUSTOM")
  # Activate the environment of P4est.jl to be able to set the preferences there
  Pkg.activate(dirname(@__DIR__))
  Pkg.instantiate()

  import UUIDs, Preferences
  Preferences.set_preferences!(
    UUIDs.UUID("7d669430-f675-4ae7-b43e-fab78ec5a902"), # UUID of P4est.jl
    "libp4est" => P4EST_TEST_LIBP4EST, force = true)
end

@info "P4est.jl tests configured" P4EST_TEST P4EST_TEST_LIBP4EST
