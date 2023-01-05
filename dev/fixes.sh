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

# Remove cross references that are not found
sed -i "s/\[\`p4est\`](@ref)/\`p4est\`/g" LibP4est.jl
sed -i "s/\[\`p6est\`](@ref)/\`p6est\`/g" LibP4est.jl
sed -i "s/\[\`p8est\`](@ref)/\`p8est\`/g" LibP4est.jl
sed -i "s/\[\`P4EST_QMAXLEVEL\`](@ref)/\`P4EST_QMAXLEVEL\`/g" LibP4est.jl
sed -i "s/\[\`P8EST_QMAXLEVEL\`](@ref)/\`p8est\`/g" LibP4est.jl
sed -i "s/\[\`P4EST_CONN_DISK_PERIODIC\`](@ref)/\`P4EST_CONN_DISK_PERIODIC\`/g" LibP4est.jl
sed -i "s/\[\`p8est_iter_corner_side_t\`](@ref)/\`p8est_iter_corner_side_t\`/g" LibP4est.jl
sed -i "s/\[\`p8est_iter_edge_side_t\`](@ref)/\`p8est_iter_edge_side_t\`/g" LibP4est.jl
sed -i "s/\[\`p4est_corner_info_t\`](@ref)/\`p4est_corner_info_t\`/g" LibP4est.jl
sed -i "s/\[\`p8est_corner_info_t\`](@ref)/\`p8est_corner_info_t\`/g" LibP4est.jl
sed -i "s/\[\`p8est_edge_info_t\`](@ref)/\`p8est_edge_info_t\`/g" LibP4est.jl
sed -i "s/\[\`sc_MPI_Barrier\`](@ref)/\`sc_MPI_Barrier\`/g" LibP4est.jl
sed -i "s/\[\`sc_MPI_COMM_NULL\`](@ref)/\`sc_MPI_COMM_NULL\`/g" LibP4est.jl
sed -i "s/\[\`SC_CHECK_ABORT\`](@ref)/\`SC_CHECK_ABORT\`/g" LibP4est.jl
sed -i "s/\[\`SC_LP_DEFAULT\`](@ref)/\`SC_LP_DEFAULT\`/g" LibP4est.jl
sed -i "s/\[\`SC_LC_NORMAL\`](@ref)/\`SC_LC_NORMAL\`/g" LibP4est.jl
sed -i "s/\[\`SC_LC_GLOBAL\`](@ref)/\`SC_LC_GLOBAL\`/g" LibP4est.jl
sed -i "s/\[\`SC_LP_ALWAYS\`](@ref)/\`SC_LP_ALWAYS\`/g" LibP4est.jl
sed -i "s/\[\`SC_LP_SILENT\`](@ref)/\`SC_LP_SILENT\`/g" LibP4est.jl
sed -i "s/\[\`SC_LP_THRESHOLD\`](@ref)/\`SC_LP_THRESHOLD\`/g" LibP4est.jl
sed -i "s/\[\`sc_logf\`](@ref)/\`sc_logf\`/g" LibP4est.jl
