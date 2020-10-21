#!/bin/bash

if [ "${P4EST_TEST}" = "P4EST_JLL_NON_MPI" ]; then
  echo "Nothing to do for P4EST_TEST=P4EST_JLL_NON_MPI"
fi
if [ "${P4EST_TEST}" = "P4EST_CUSTOM_NON_MPI" ]; then
  pushd `pwd`
  export P4EST_TMP=`pwd`/libp4est_tmp_non_mpi
  mkdir -p $P4EST_TMP
  cd $P4EST_TMP/
  wget https://p4est.github.io/release/p4est-2.2.tar.gz
  tar xf p4est-2.2.tar.gz
  mkdir build
  cd build/
  $P4EST_TMP/p4est-2.2/configure --prefix=$P4EST_TMP/prefix
  make -j 2
  make install
  ls -l $P4EST_TMP/prefix/lib/libp4est.so
  mkdir test_tmp
  cd test_tmp
  $P4EST_TMP/prefix/bin/p4est_step1
  popd
fi
if [ "${P4EST_TEST}" = "P4EST_CUSTOM_USES_MPI" ]; then
  pushd `pwd`
  export P4EST_TMP=`pwd`/libp4est_tmp_uses_mpi
  mkdir -p $P4EST_TMP
  cd $P4EST_TMP/
  wget https://p4est.github.io/release/p4est-2.2.tar.gz
  tar xf p4est-2.2.tar.gz
  mkdir build
  cd build/
  export CC=mpicc
  export CXX=mpicxx
  export FC=mpif90
  export F77=mpif77
  $P4EST_TMP/p4est-2.2/configure --prefix=$P4EST_TMP/prefix --enable-mpi
  make -j 2
  make install
  ls -l $P4EST_TMP/prefix/lib/libp4est.so
  mkdir test_tmp
  cd test_tmp
  $P4EST_TMP/prefix/bin/p4est_step1
  popd
fi
