#!/bin/bash

P4EST_RELEASE="2.2"

if [ "${P4EST_TEST}" = "P4EST_JLL_NON_MPI_PRE_GENERATED_BINDINGS" ]; then
  echo "Found 'P4EST_TEST=${P4EST_TEST}'. Nothing to do here."
fi
if [ "${P4EST_TEST}" = "P4EST_JLL_NON_MPI" ]; then
  echo "Found 'P4EST_TEST=${P4EST_TEST}'. Nothing to do here."
fi
if [ "${P4EST_TEST}" = "P4EST_CUSTOM_NON_MPI" ]; then
  echo "Found 'P4EST_TEST=P4EST_CUSTOM_NON_MPI'. Installing custom p4est *without* MPI support..."
  pushd `pwd`
  export P4EST_TMP=`pwd`/libp4est_tmp_non_mpi
  mkdir -p $P4EST_TMP
  cd $P4EST_TMP/
  wget https://p4est.github.io/release/p4est-${P4EST_RELEASE}.tar.gz
  tar xf p4est-${P4EST_RELEASE}.tar.gz
  mkdir build
  cd build/
  $P4EST_TMP/p4est-${P4EST_RELEASE}/configure --prefix=$P4EST_TMP/prefix
  make -j 2
  make install
  ls -l $P4EST_TMP/prefix/lib/libp4est.so
  mkdir test_tmp
  cd test_tmp
  $P4EST_TMP/prefix/bin/p4est_step1
  popd
fi
if [ "${P4EST_TEST}" = "P4EST_CUSTOM_USES_MPI" ]; then
  echo "Found 'P4EST_TEST=P4EST_CUSTOM_USES_MPI'. Installing custom p4est *with* MPI support..."
  pushd `pwd`
  export P4EST_TMP=`pwd`/libp4est_tmp_uses_mpi
  mkdir -p $P4EST_TMP
  cd $P4EST_TMP/
  wget https://p4est.github.io/release/p4est-${P4EST_RELEASE}.tar.gz
  tar xf p4est-${P4EST_RELEASE}.tar.gz
  mkdir build
  cd build/
  export CC=mpicc
  export CXX=mpicxx
  export FC=mpif90
  export F77=mpif77
  $P4EST_TMP/p4est-${P4EST_RELEASE}/configure --prefix=$P4EST_TMP/prefix --enable-mpi
  make -j 2
  make install
  ls -l $P4EST_TMP/prefix/lib/libp4est.so
  mkdir test_tmp
  cd test_tmp
  $P4EST_TMP/prefix/bin/p4est_step1
  popd
fi
