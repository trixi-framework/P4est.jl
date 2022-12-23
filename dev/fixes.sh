#!/bin/bash

# This script should be executed after generating a new `LibP4est.jl` bindings file using Clang.jl
# via `generator.jl`. It corrects a number of issues that are not (easily) fixable through Clang.jl alone.
# Note for macOS users: This script needs to be run on a Linux machine, since `sed` cannot be
#                       used in a portable manner with `-i` on Linux and macOS systems. Sorry!

set -euxo pipefail

# Remove Fortran macros
sed -i "/INTEGER(KIND/d" LibP4est.jl

# Remove other probably unused macros
sed -i "/P4EST_NOTICE/d" LibP4est.jl
sed -i "/P4EST_GLOBAL_NOTICE/d" LibP4est.jl

# Fix MPI types that have been wrongly converted to Julia types
sed -i "s/mpicomm::Cint/mpicomm::MPI_Comm/g" LibP4est.jl
sed -i "s/\bcomm::Cint/comm::MPI_Comm/g" LibP4est.jl
sed -i "s/\bintranode::Ptr{Cint}/intranode::Ptr{MPI_Comm}/g" LibP4est.jl
sed -i "s/\binternode::Ptr{Cint}/internode::Ptr{MPI_Comm}/g" LibP4est.jl
sed -i "s/mpifile::Cint/mpifile::MPI_File/g" LibP4est.jl
sed -i "s/mpidatatype::Cint/mpidatatype::MPI_Datatype/g" LibP4est.jl
sed -i "s/\bt::Cint/t::MPI_Datatype/g" LibP4est.jl

# Fix type of `sc_array` field `array`
sed -i "s/array::Cstring/array::Ptr{Int8}/g" LibP4est.jl
