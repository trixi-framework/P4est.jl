module P4est

using Reexport: @reexport


# We need to load the preference setting from here and not from `LibP4est_v2.jl`
# since `@load_preference` looks into the module it is running from. Thus, we
# load all preferences here and access them from the `module LibP4est`.
using Preferences: @load_preference
const _PREFERENCE_LIBP4EST = @load_preference("libp4est", "P4est_jll")


# Include p4est bindings
include("LibP4est_v2.jl")
@reexport using .LibP4est


# Higher-level API defined in P4est.jl
"""
    P4est.uses_mpi()

Is intended to return `true`` if the `p4est` library was compiled with MPI
enabled. Since P4est.jl currently only supports `p4est` with MPI enabled,
this may always return `true`.
"""
uses_mpi() = isdefined(@__MODULE__, :P4EST_ENABLE_MPI)

"""
    P4est.version()

Returns the version of the underlying `p4est` library (*not* of P4est.jl).
"""
version() = VersionNumber(p4est_version_major(), p4est_version_minor())

"""
    P4est.package_id()

Returns the value of the global variable `p4est_package_id` which can be used
to check whether `p4est` has been initialized.
"""
package_id() = unsafe_load(cglobal((:p4est_package_id, LibP4est.libp4est), Cint))

"""
    P4est.init(log_handler, log_threshold)

Calls [`p4est_init`](@ref) if it has not already been called, otherwise do
nothing. Thus, `P4est.init` can safely be called multiple times.

To use the default log handler and suppress most output created by default by
`p4est`, call this function as
```julia
P4est.init(C_NULL, SC_LP_ERROR)
```
before calling other functions from `p4est`.
"""
function init(log_handler, log_threshold)
    if package_id() >= 0
        return nothing
    end

    p4est_init(log_handler, log_threshold)

    return nothing
end


function __init__()
    version = P4est.version()

    if !(v"2.3" <= version < v"3-")
        @warn "Detected version $(version) of `p4est`. Currently, we only support versions v2.x.y from v2.3.0 on. Not everything may work correctly."
    end

    return nothing
end


end
