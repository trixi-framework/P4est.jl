module P4est

using Reexport: @reexport


# Include p4est bindings
include("LibP4est_v2.jl")
@reexport using .LibP4est

function __init__()
    version = VersionNumber(
        p4est_version_major(), p4est_version_minor()
    )

    if !(v"2.3" <= version < v"3-")
        @warn "Detected version $(version) of `p4est`. Currently, we only support versions v2.x.y from v2.3.0 on. Not everything may work correctly."
    end
end


"""
    P4est.uses_mpi()

Returns true if the `p4est` library was compiled with MPI enabled.
"""
uses_mpi() = isdefined(@__MODULE__, :P4EST_ENABLE_MPI)

end
