using P4est_jll: P4est_jll
export P4est_jll

using ..P4est: _PREFERENCE_LIBP4EST, _PREFERENCE_LIBSC
using MPIPreferences: MPIPreferences

@static if _PREFERENCE_LIBP4EST == "P4est_jll" && MPIPreferences.binary == "system"
    @warn "System MPI version detected, but not a system p4est version. To make P4est.jl work, you need to set the preferences."
elseif _PREFERENCE_LIBP4EST == "P4est_jll"
    const libp4est = P4est_jll.libp4est
else
    const libp4est = _PREFERENCE_LIBP4EST
end

@static if _PREFERENCE_LIBSC == "P4est_jll" && MPIPreferences.binary == "system"
    @warn "System MPI version detected, but not a system p4est version. To make P4est.jl work, you need to set the preferences."
elseif _PREFERENCE_LIBSC == "P4est_jll"
    const libsc = P4est_jll.libsc
else
    const libsc = _PREFERENCE_LIBSC
end


# Define missing types
const ptrdiff_t = Cptrdiff_t

# Definitions used from MPI.jl
using MPI: MPI, MPI_Datatype, MPI_Comm, MPI_Group, MPI_File

const MPI_COMM_WORLD = MPI.COMM_WORLD
const MPI_COMM_SELF = MPI.COMM_SELF
const MPI_CHAR = MPI.CHAR
const MPI_SIGNED_CHAR = MPI.SIGNED_CHAR
const MPI_UNSIGNED_CHAR = MPI.UNSIGNED_CHAR
const MPI_BYTE = MPI.BYTE
const MPI_SHORT = MPI.SHORT
const MPI_UNSIGNED_SHORT = MPI.UNSIGNED_SHORT
const MPI_INT = MPI.INT
const MPI_UNSIGNED = MPI.UNSIGNED
const MPI_LONG = MPI.LONG
const MPI_UNSIGNED_LONG = MPI.UNSIGNED_LONG
const MPI_LONG_LONG_INT = MPI.LONG_LONG_INT
const MPI_UNSIGNED_LONG_LONG = MPI.UNSIGNED_LONG_LONG
const MPI_FLOAT = MPI.FLOAT
const MPI_DOUBLE = MPI.DOUBLE

# Other definitions
const INT32_MIN = typemin(Cint)
const INT32_MAX = typemax(Cint)
const INT64_MIN = typemin(Clonglong)
const INT64_MAX = typemax(Clonglong)
