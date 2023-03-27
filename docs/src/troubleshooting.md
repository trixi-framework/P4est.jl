# Troubleshooting and FAQ

## [`using P4est` gives `UndefVarError: libp4est not defined`](@id undef-var-error)

If you get the error message `UndefVarError: libp4est not defined` when `using P4est` the error is likely to be caused by the fact that P4est.jl uses a system provided MPI library, but no system provided `p4est` version. Therefore, check in your active project that the `LocalPreferences.toml` has a section `[MPIPreferencs]` as well as a section `[P4est]` with valid entry for `libp4est`. If you don't have any `LocalPreferences.toml` in your active project also check your default environment under `~/.julia/environments/vx.y/`, where `vx.y` is the julia version you're using.
