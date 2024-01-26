module P4est

using Reexport: @reexport

using MPIPreferences: MPIPreferences
# We need to load the preference setting from here and not from `LibP4est.jl`
# since `@load_preference` looks into the module it is running from. Thus, we
# load all preferences here and access them from the `module LibP4est`.
using Preferences: @load_preference, set_preferences!, delete_preferences!
using UUIDs: UUID
const _PREFERENCE_LIBP4EST = @load_preference("libp4est", "P4est_jll")
const _PREFERENCE_LIBSC = @load_preference("libsc", _PREFERENCE_LIBP4EST)


# Include p4est bindings
include("LibP4est.jl")
@reexport using .LibP4est

# Include pointer wrapper
include("pointerwrappers.jl")
@reexport using .PointerWrappers: PointerWrapper


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

const P4EST_UUID = UUID("7d669430-f675-4ae7-b43e-fab78ec5a902")

"""
    P4est.set_library_p4est!(path; force = true)

Set the `path` to a system-provided `p4est` installation. Restart the Julia session
after executing this function so that the changes take effect. Calling this
function is necessary when you want to use a system-provided `p4est`
installation.
"""
function set_library_p4est!(path = nothing; force = true)
    if isnothing(path)
        delete_preferences!(P4EST_UUID, "libp4est"; force = force)
    else
        isfile(path) || throw(ArgumentError("$path is not a file that exists."))
        set_preferences!(P4EST_UUID, "libp4est" => path, force = force)
    end
    @info "Please restart Julia and reload P4est.jl for the library changes to take effect"
end

"""
    P4est.path_p4est_library()

Return the path of the `p4est` library that is used, when a system-provided library
is configured via the preferences. Otherwise `P4est_jll` is returned, which means
that the default p4est version from P4est_jll.jl is used.
"""
path_p4est_library() = _PREFERENCE_LIBP4EST

"""
    P4est.set_library_sc!(path; force = true)

Set the `path` to a system-provided `sc` installation. Restart the Julia session
after executing this function so that the changes take effect. Calling this
function is necessary, when you want to use a system-provided `p4est`
installation on Windows or when you want to use another `sc`
installation than the one that `libp4est.so` already links to.
"""
function set_library_sc!(path = nothing; force = true)
    if isnothing(path)
        delete_preferences!(P4EST_UUID, "libsc"; force = force)
    else
        isfile(path) || throw(ArgumentError("$path is not a file that exists."))
        set_preferences!(P4EST_UUID, "libsc" => path, force = force)
    end
    @info "Please restart Julia and reload P4est.jl for the library changes to take effect"
end

"""
    P4est.path_sc_library()

Return the path of the `sc` library that is used, when a system-provided library
is configured via the preferences. Otherwise `P4est_jll` is returned, which means
that the default sc version from P4est_jll.jl is used.
"""
path_sc_library() = _PREFERENCE_LIBSC

"""
    P4est.preferences_set_correctly()

Returns `false` if a system-provided MPI installation is set via the MPIPreferences, but
not a system-provided `p4est` installation. In this case, P4est.jl is not usable.
"""
preferences_set_correctly() =
    !(_PREFERENCE_LIBP4EST == "P4est_jll" && MPIPreferences.binary == "system")

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
    # If a system-provided MPI installation with default p4est version is used, we cannot execute `P4est.version()`
    # because the p4est functions are not available
    if preferences_set_correctly()
        version = P4est.version()

        if !(v"2.3" <= version < v"3-")
            @warn "Detected version $(version) of `p4est`. Currently, we only support versions v2.x.y from v2.3.0 on. Not everything may work correctly."
        end
    else
        @warn "System MPI version detected, but not a system p4est version. To make P4est.jl work, you need to set the preferences, see https://trixi-framework.github.io/P4est.jl/stable/#Using-a-custom-version-of-MPI-and/or-p4est."
    end

    return nothing
end


end
