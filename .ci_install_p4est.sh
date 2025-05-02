#!/bin/bash

if [ -z "$P4EST_RELEASE" ]; then
  P4EST_RELEASE="2.8"
fi

if [ "${JULIA_P4EST_TEST}" = "P4EST_JLL_MPI_DEFAULT" ]; then
  echo "Found 'JULIA_P4EST_TEST=${JULIA_P4EST_TEST}'. Nothing to do here."
fi
if [ "${JULIA_P4EST_TEST}" = "P4EST_CUSTOM_MPI_CUSTOM" ]; then
  echo "Found 'JULIA_P4EST_TEST=${JULIA_P4EST_TEST}'. Installing custom `p4est` with MPI support from the default MPI installation on the system."
  pushd `pwd`
  export P4EST_TMP=`pwd`/libp4est_tmp
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
  $P4EST_TMP/p4est-${P4EST_RELEASE}/configure LIBS=-L/usr/path/lib --prefix=$P4EST_TMP/prefix --enable-mpi --enable-debug
  make -j 2
  make install
  ls -l $P4EST_TMP/prefix/lib/libp4est.so
  mkdir test_tmp
  cd test_tmp
  $P4EST_TMP/prefix/bin/p4est_step1
  popd
fi
