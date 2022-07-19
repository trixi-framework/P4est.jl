#!/bin/bash

set -euxo pipefail

# Remove Fortran macros
sed -i "/INTEGER(KIND/d" LibP4est.jl

# Remove other probably unused macros
sed -i "/P4EST_NOTICE/d" LibP4est.jl
sed -i "/P4EST_GLOBAL_NOTICE/d" LibP4est.jl

# Fix MPI types that have been wrongly converted to Julia types
sed -i "s/mpicomm::Cint/mpicomm::MPI_Comm/g" LibP4est.jl
sed -i "s/mpifile::Cint/mpifile::MPI_File/g" LibP4est.jl
sed -i "s/mpidatatype::Cint/mpidatatype::MPI_Datatype/g" LibP4est.jl
