module P4est

using Reexport: @reexport


# Include p4est bindings
include("LibP4est_v2.jl")
@reexport using .LibP4est


# Higher-level API defined in P4est.jl
"""
    P4est.uses_mpi()

Returns true if the `p4est` library was compiled with MPI enabled.
"""
uses_mpi() = isdefined(@__MODULE__, :P4EST_ENABLE_MPI)

"""
    P4est.version()

Returns the version of the unterlying `p4est` library.
"""
version() = VersionNumber(p4est_version_major(), p4est_version_minor())

"""
    P4est.package_id()

Returns the value of the global variable `p4est_package_id` which can be used
to check whether `p4est` has been initialized.
"""
package_id() = unsafe_load(cglobal((:p4est_package_id, LibP4est.libp4est), Cint))


function __init__()
    version = P4est.version()

    if !(v"2.3" <= version < v"3-")
        @warn "Detected version $(version) of `p4est`. Currently, we only support versions v2.x.y from v2.3.0 on. Not everything may work correctly."
    end

    # TODO: Clang; decide whether we want to initialize MPI automatically
    #
    # # MPI.jl handles multiple calls to MPI.Init appropriately. Thus, we don't need
    # # any common checks of the form `if MPI.Initialized() ...`.
    # # threadlevel=MPI.THREAD_FUNNELED: Only main thread makes MPI calls
    # # finalize_atexit=true           : MPI.jl will call MPI.Finalize as `atexit` hook
    # MPI.Init(threadlevel = MPI.THREAD_FUNNELED, finalize_atexit = true)

    return nothing
end


end
