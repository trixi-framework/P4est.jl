# Troubleshooting and FAQ

## [`using P4est` gives `UndefVarError: libp4est not defined`](@id undef-var-error)

If you get the error message `UndefVarError: libp4est not defined` when `using P4est`
the error is likely to be caused by the fact that P4est.jl uses a system provided MPI
library, but no system provided `p4est` version. Therefore, check in your active project
that the `LocalPreferences.toml` has a section `[MPIPreferencs]` as well as a section
`[P4est]` with valid entry for `libp4est`. If you don't have any `LocalPreferences.toml`
in your active project also check your default environment under `~/.julia/environments/vx.y/`,
where `vx.y` is the julia version you're using.

## [Julia crashes with multiple threads](@id catch-signals)

If you call [`sc_init`](@ref) and run Julia with multiple threads and the garbage collector
may be active, please make sure that you deactivate catching signals in [`sc_init`](@ref).
Internally, the Julia garbage collector uses `SIGSEGV` for threads synchronization, as
described in the
[Julia dev docs](https://docs.julialang.org/en/v1/devdocs/debuggingtips/#Dealing-with-signals-1).
Thus, [`libsc`](https://github.com/cburstedde/libsc) must not catch this signal and abort execution.
