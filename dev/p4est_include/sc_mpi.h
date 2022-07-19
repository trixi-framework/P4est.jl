/*
  This file is part of the SC Library.
  The SC Library provides support for parallel scientific applications.

  Copyright (C) 2010 The University of Texas System
  Additional copyright (C) 2011 individual authors

  The SC Library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  The SC Library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with the SC Library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  02110-1301, USA.
*/

/** \file
 *
 * This file emulates collective MPI routines for non-MPI code.
 *
 * The goal is to make code compile and execute cleanly when `--enable-mpi` is
 * not given on the configure line.  To this end, several MPI routines that are
 * meaningful to call on one processor are provided with the prefix `sc_MPI_`,
 * as well as necessary types and defines.  If `--enable-mpi` is given, this
 * file provides macros that map the sc_-prefixed form to the standard form of
 * the symbols.
 *
 * When including this file in your code, everything inside `#ifdef
 * SC_ENABLE_MPI` can use the standard MPI API.  Outside of this define, you
 * may use the sc_MPI_* routines specified here to seamlessly use MPI calls.
 *
 * Some send and receive routines are wrapped.  They can thus be used
 * in code outside of `#ifdef SC_ENABLE_MPI` even though they will abort.  If
 * no messages are sent to the same processor when mpisize == 1, such aborts
 * will not occur.  The `MPI_Wait*` routines are safe to call as long as no or
 * only MPI_REQUEST_NULL requests are passed in.
 */

#ifndef SC_MPI_H
#define SC_MPI_H

#include <sc.h>

SC_EXTERN_C_BEGIN;

typedef enum
{
  SC_TAG_FIRST = 's' + 'c',     /* anything really */
  SC_TAG_AG_ALLTOALL = SC_TAG_FIRST,
  SC_TAG_AG_RECURSIVE_A,
  SC_TAG_AG_RECURSIVE_B,
  SC_TAG_AG_RECURSIVE_C,
  SC_TAG_NOTIFY_CENSUS,
  SC_TAG_NOTIFY_CENSUSV,
  SC_TAG_NOTIFY_NBX,
  SC_TAG_NOTIFY_NBXV,
  SC_TAG_NOTIFY_WRAPPER,
  SC_TAG_NOTIFY_WRAPPERV,
  SC_TAG_NOTIFY_RANGES,
  SC_TAG_NOTIFY_PAYLOAD,
  SC_TAG_NOTIFY_SUPER_TRUE,
  SC_TAG_NOTIFY_SUPER_EXTRA,
  SC_TAG_NOTIFY_RECURSIVE,
  SC_TAG_NOTIFY_NARY = SC_TAG_NOTIFY_RECURSIVE + 32,
  SC_TAG_REDUCE = SC_TAG_NOTIFY_NARY + 32,
  SC_TAG_PSORT_LO,
  SC_TAG_PSORT_HI,
  SC_TAG_LAST
}
sc_tag_t;

#ifdef SC_ENABLE_MPI

/* constants */

#define sc_MPI_SUCCESS             MPI_SUCCESS
#define sc_MPI_ERR_OTHER           MPI_ERR_OTHER

#define sc_MPI_COMM_NULL           MPI_COMM_NULL
#define sc_MPI_COMM_WORLD          MPI_COMM_WORLD
#define sc_MPI_COMM_SELF           MPI_COMM_SELF
#define sc_MPI_COMM_TYPE_SHARED    MPI_COMM_TYPE_SHARED

#define sc_MPI_GROUP_NULL          MPI_GROUP_NULL
#define sc_MPI_GROUP_EMPTY         MPI_GROUP_EMPTY

#define sc_MPI_IDENT               MPI_IDENT
#define sc_MPI_CONGRUENT           MPI_CONGRUENT
#define sc_MPI_SIMILAR             MPI_SIMILAR
#define sc_MPI_UNEQUAL             MPI_UNEQUAL

#define sc_MPI_ANY_SOURCE          MPI_ANY_SOURCE
#define sc_MPI_ANY_TAG             MPI_ANY_TAG
#define sc_MPI_STATUS_IGNORE       MPI_STATUS_IGNORE
#define sc_MPI_STATUSES_IGNORE     MPI_STATUSES_IGNORE

#define sc_MPI_REQUEST_NULL        MPI_REQUEST_NULL
#define sc_MPI_INFO_NULL           MPI_INFO_NULL

#define sc_MPI_DATATYPE_NULL       MPI_DATATYPE_NULL
#define sc_MPI_CHAR                MPI_CHAR
#define sc_MPI_SIGNED_CHAR         MPI_SIGNED_CHAR
#define sc_MPI_UNSIGNED_CHAR       MPI_UNSIGNED_CHAR
#define sc_MPI_BYTE                MPI_BYTE
#define sc_MPI_SHORT               MPI_SHORT
#define sc_MPI_UNSIGNED_SHORT      MPI_UNSIGNED_SHORT
#define sc_MPI_INT                 MPI_INT
#define sc_MPI_2INT                MPI_2INT
#define sc_MPI_UNSIGNED            MPI_UNSIGNED
#define sc_MPI_LONG                MPI_LONG
#define sc_MPI_UNSIGNED_LONG       MPI_UNSIGNED_LONG
#define sc_MPI_LONG_LONG_INT       MPI_LONG_LONG_INT
#define sc_MPI_UNSIGNED_LONG_LONG  MPI_UNSIGNED_LONG_LONG
#define sc_MPI_FLOAT               MPI_FLOAT
#define sc_MPI_DOUBLE              MPI_DOUBLE
#define sc_MPI_LONG_DOUBLE         MPI_LONG_DOUBLE

#define sc_MPI_OP_NULL             MPI_OP_NULL
#define sc_MPI_MAX                 MPI_MAX
#define sc_MPI_MIN                 MPI_MIN
#define sc_MPI_LAND                MPI_LAND
#define sc_MPI_BAND                MPI_BAND
#define sc_MPI_LOR                 MPI_LOR
#define sc_MPI_BOR                 MPI_BOR
#define sc_MPI_LXOR                MPI_LXOR
#define sc_MPI_BXOR                MPI_BXOR
#define sc_MPI_MINLOC              MPI_MINLOC
#define sc_MPI_MAXLOC              MPI_MAXLOC
#define sc_MPI_REPLACE             MPI_REPLACE
#define sc_MPI_SUM                 MPI_SUM
#define sc_MPI_PROD                MPI_PROD

#define sc_MPI_UNDEFINED           MPI_UNDEFINED

#define sc_MPI_KEYVAL_INVALID      MPI_KEYVAL_INVALID

/* types */

#define sc_MPI_Comm                MPI_Comm
#define sc_MPI_Group               MPI_Group
#define sc_MPI_Datatype            MPI_Datatype
#define sc_MPI_Op                  MPI_Op
#define sc_MPI_Request             MPI_Request
#define sc_MPI_Status              MPI_Status

/* functions */

#define sc_MPI_Init                MPI_Init
/*      sc_MPI_Init_thread is handled below */
#define sc_MPI_Finalize            MPI_Finalize
#define sc_MPI_Abort               MPI_Abort
#define sc_MPI_Alloc_mem           MPI_Alloc_mem
#define sc_MPI_Free_mem            MPI_Free_mem
#define sc_MPI_Comm_set_attr       MPI_Comm_set_attr
#define sc_MPI_Comm_get_attr       MPI_Comm_get_attr
#define sc_MPI_Comm_delete_attr    MPI_Comm_delete_attr
#define sc_MPI_Comm_create_keyval  MPI_Comm_create_keyval
#define sc_MPI_Comm_dup            MPI_Comm_dup
#define sc_MPI_Comm_create         MPI_Comm_create
#define sc_MPI_Comm_split          MPI_Comm_split
#define sc_MPI_Comm_split_type     MPI_Comm_split_type
#define sc_MPI_Comm_free           MPI_Comm_free
#define sc_MPI_Comm_size           MPI_Comm_size
#define sc_MPI_Comm_rank           MPI_Comm_rank
#define sc_MPI_Comm_compare        MPI_Comm_compare
#define sc_MPI_Comm_group          MPI_Comm_group
#define sc_MPI_Group_free          MPI_Group_free
#define sc_MPI_Group_size          MPI_Group_size
#define sc_MPI_Group_rank          MPI_Group_rank
#define sc_MPI_Group_translate_ranks MPI_Group_translate_ranks
#define sc_MPI_Group_compare       MPI_Group_compare
#define sc_MPI_Group_union         MPI_Group_union
#define sc_MPI_Group_intersection  MPI_Group_intersection
#define sc_MPI_Group_difference    MPI_Group_difference
#define sc_MPI_Group_incl          MPI_Group_incl
#define sc_MPI_Group_excl          MPI_Group_excl
#define sc_MPI_Group_range_incl    MPI_Group_range_incl
#define sc_MPI_Group_range_excl    MPI_Group_range_excl
#define sc_MPI_Barrier             MPI_Barrier
#define sc_MPI_Bcast               MPI_Bcast
#define sc_MPI_Gather              MPI_Gather
#define sc_MPI_Gatherv             MPI_Gatherv
#define sc_MPI_Allgather           MPI_Allgather
#define sc_MPI_Allgatherv          MPI_Allgatherv
#define sc_MPI_Alltoall            MPI_Alltoall
#define sc_MPI_Reduce              MPI_Reduce
#define sc_MPI_Reduce_scatter_block MPI_Reduce_scatter_block
#define sc_MPI_Allreduce           MPI_Allreduce
#define sc_MPI_Scan                MPI_Scan
#define sc_MPI_Exscan              MPI_Exscan
#define sc_MPI_Recv                MPI_Recv
#define sc_MPI_Irecv               MPI_Irecv
#define sc_MPI_Send                MPI_Send
#define sc_MPI_Isend               MPI_Isend
#define sc_MPI_Probe               MPI_Probe
#define sc_MPI_Iprobe              MPI_Iprobe
#define sc_MPI_Get_count           MPI_Get_count
#define sc_MPI_Wtime               MPI_Wtime
#define sc_MPI_Wait                MPI_Wait
#define sc_MPI_Waitsome            MPI_Waitsome
#define sc_MPI_Waitall             MPI_Waitall

#else /* !SC_ENABLE_MPI */
#include <sc3_mpi_types.h>

/* constants */

#define sc_MPI_SUCCESS             SC3_MPI_SUCCESS
#define sc_MPI_ERR_OTHER           SC3_MPI_ERR_OTHER

#define sc_MPI_COMM_NULL           SC3_MPI_COMM_NULL
#define sc_MPI_COMM_WORLD          SC3_MPI_COMM_WORLD
#define sc_MPI_COMM_SELF           SC3_MPI_COMM_SELF

#define sc_MPI_GROUP_NULL          ((sc_MPI_Group) 0x54000000)  /* TODO change val */
#define sc_MPI_GROUP_EMPTY         ((sc_MPI_Group) 0x54000001)  /* TODO change val */

#define sc_MPI_IDENT               (1)  /* TODO change val */
#define sc_MPI_CONGRUENT           (2)  /* TODO change val */
#define sc_MPI_SIMILAR             (3)  /* TODO change val */
#define sc_MPI_UNEQUAL             (-1) /* TODO change val */

#define sc_MPI_ANY_SOURCE          (-2)
#define sc_MPI_ANY_TAG             (-1)
#define sc_MPI_STATUS_IGNORE       (sc_MPI_Status *) 1
#define sc_MPI_STATUSES_IGNORE     (sc_MPI_Status *) 1

#define sc_MPI_REQUEST_NULL        ((sc_MPI_Request) 0x2c000000)

#define sc_MPI_DATATYPE_NULL       SC3_MPI_DATATYPE_NULL
#define sc_MPI_CHAR                ((sc_MPI_Datatype) 0x4c000101)
#define sc_MPI_SIGNED_CHAR         ((sc_MPI_Datatype) 0x4c000118)
#define sc_MPI_UNSIGNED_CHAR       ((sc_MPI_Datatype) 0x4c000102)
#define sc_MPI_BYTE                SC3_MPI_BYTE
#define sc_MPI_SHORT               ((sc_MPI_Datatype) 0x4c000203)
#define sc_MPI_UNSIGNED_SHORT      ((sc_MPI_Datatype) 0x4c000204)
#define sc_MPI_INT                 SC3_MPI_INT
#define sc_MPI_2INT                SC3_MPI_2INT
#define sc_MPI_UNSIGNED            SC3_MPI_UNSIGNED
#define sc_MPI_LONG                SC3_MPI_LONG
#define sc_MPI_UNSIGNED_LONG       ((sc_MPI_Datatype) 0x4c000408)
#define sc_MPI_LONG_LONG_INT       SC3_MPI_LONG_LONG
#define sc_MPI_UNSIGNED_LONG_LONG  ((sc_MPI_Datatype) 0x4c000409)
#define sc_MPI_FLOAT               SC3_MPI_FLOAT
#define sc_MPI_DOUBLE              SC3_MPI_DOUBLE
#define sc_MPI_DOUBLE_INT          SC3_MPI_DOUBLE_INT
#define sc_MPI_LONG_DOUBLE         ((sc_MPI_Datatype) 0x4c000c0c)

#define sc_MPI_OP_NULL             SC3_MPI_OP_NULL
#define sc_MPI_MIN                 SC3_MPI_MIN
#define sc_MPI_MAX                 SC3_MPI_MAX
#define sc_MPI_MINLOC              SC3_MPI_MINLOC
#define sc_MPI_MAXLOC              SC3_MPI_MAXLOC
#define sc_MPI_LOR                 SC3_MPI_LOR
#define sc_MPI_LAND                SC3_MPI_LAND
#define sc_MPI_LXOR                SC3_MPI_LXOR
#define sc_MPI_BOR                 SC3_MPI_BOR
#define sc_MPI_BAND                SC3_MPI_BAND
#define sc_MPI_BXOR                SC3_MPI_BXOR
#define sc_MPI_REPLACE             SC3_MPI_REPLACE
#define sc_MPI_PROD                SC3_MPI_PROD
#define sc_MPI_SUM                 SC3_MPI_SUM

#define sc_MPI_UNDEFINED           SC3_MPI_UNDEFINED

/* types */

typedef sc3_MPI_Comm_t sc_MPI_Comm;
typedef int         sc_MPI_Group;
typedef sc3_MPI_Datatype_t sc_MPI_Datatype;
typedef sc3_MPI_Op_t sc_MPI_Op;
typedef int         sc_MPI_Request;
typedef struct sc_MPI_Status
{
  int                 count;
  int                 cancelled;
  int                 MPI_SOURCE;
  int                 MPI_TAG;
  int                 MPI_ERROR;
}
sc_MPI_Status;

/* These functions are valid and functional for a single process. */

int                 sc_MPI_Init (int *, char ***);
/*                  sc_MPI_Init_thread is handled below */

int                 sc_MPI_Finalize (void);
int                 sc_MPI_Abort (sc_MPI_Comm, int)
  __attribute__ ((noreturn));

int                 sc_MPI_Comm_dup (sc_MPI_Comm, sc_MPI_Comm *);
int                 sc_MPI_Comm_free (sc_MPI_Comm *);

/* Always sets size to 1. */
int                 sc_MPI_Comm_size (sc_MPI_Comm, int *);

/* Always sets rank to 0. */
int                 sc_MPI_Comm_rank (sc_MPI_Comm, int *);

/* Always sets size to 1. */
int                 sc_MPI_Group_size (sc_MPI_Group, int *);

/* Always sets rank to 0. */
int                 sc_MPI_Group_rank (sc_MPI_Group, int *);

int                 sc_MPI_Barrier (sc_MPI_Comm);
int                 sc_MPI_Bcast (void *, int, sc_MPI_Datatype, int,
                                  sc_MPI_Comm);
int                 sc_MPI_Gather (void *, int, sc_MPI_Datatype, void *, int,
                                   sc_MPI_Datatype, int, sc_MPI_Comm);
int                 sc_MPI_Gatherv (void *, int, sc_MPI_Datatype, void *,
                                    int *, int *, sc_MPI_Datatype, int,
                                    sc_MPI_Comm);
int                 sc_MPI_Allgather (void *, int, sc_MPI_Datatype, void *,
                                      int, sc_MPI_Datatype, sc_MPI_Comm);
int                 sc_MPI_Allgatherv (void *, int, sc_MPI_Datatype, void *,
                                       int *, int *, sc_MPI_Datatype,
                                       sc_MPI_Comm);
int                 sc_MPI_Alltoall (void *, int, sc_MPI_Datatype, void *,
                                     int, sc_MPI_Datatype, sc_MPI_Comm);
int                 sc_MPI_Reduce (void *, void *, int, sc_MPI_Datatype,
                                   sc_MPI_Op, int, sc_MPI_Comm);
int                 sc_MPI_Reduce_scatter_block (void *, void *,
                                                 int, sc_MPI_Datatype,
                                                 sc_MPI_Op, sc_MPI_Comm);
int                 sc_MPI_Allreduce (void *, void *, int, sc_MPI_Datatype,
                                      sc_MPI_Op, sc_MPI_Comm);
int                 sc_MPI_Scan (void *, void *, int, sc_MPI_Datatype,
                                 sc_MPI_Op, sc_MPI_Comm);
int                 sc_MPI_Exscan (void *, void *, int, sc_MPI_Datatype,
                                   sc_MPI_Op, sc_MPI_Comm);

double              sc_MPI_Wtime (void);

/* These functions will run but their results/actions are not defined. */

int                 sc_MPI_Comm_create (sc_MPI_Comm, sc_MPI_Group,
                                        sc_MPI_Comm *);
int                 sc_MPI_Comm_split (sc_MPI_Comm, int, int, sc_MPI_Comm *);
int                 sc_MPI_Comm_compare (sc_MPI_Comm, sc_MPI_Comm, int *);
int                 sc_MPI_Comm_group (sc_MPI_Comm, sc_MPI_Group *);

int                 sc_MPI_Group_free (sc_MPI_Group *);
int                 sc_MPI_Group_translate_ranks (sc_MPI_Group, int, int *,
                                                  sc_MPI_Group, int *);
int                 sc_MPI_Group_compare (sc_MPI_Group, sc_MPI_Group, int *);
int                 sc_MPI_Group_union (sc_MPI_Group, sc_MPI_Group,
                                        sc_MPI_Group *);
int                 sc_MPI_Group_intersection (sc_MPI_Group, sc_MPI_Group,
                                               sc_MPI_Group *);
int                 sc_MPI_Group_difference (sc_MPI_Group, sc_MPI_Group,
                                             sc_MPI_Group *);
int                 sc_MPI_Group_incl (sc_MPI_Group, int, int *,
                                       sc_MPI_Group *);
int                 sc_MPI_Group_excl (sc_MPI_Group, int, int *,
                                       sc_MPI_Group *);
int                 sc_MPI_Group_range_incl (sc_MPI_Group, int,
                                             int ranges[][3], sc_MPI_Group *);
int                 sc_MPI_Group_range_excl (sc_MPI_Group, int,
                                             int ranges[][3], sc_MPI_Group *);

/* These functions will abort. */

int                 sc_MPI_Recv (void *, int, sc_MPI_Datatype, int, int,
                                 sc_MPI_Comm, sc_MPI_Status *);
int                 sc_MPI_Irecv (void *, int, sc_MPI_Datatype, int, int,
                                  sc_MPI_Comm, sc_MPI_Request *);
int                 sc_MPI_Send (void *, int, sc_MPI_Datatype, int, int,
                                 sc_MPI_Comm);
int                 sc_MPI_Isend (void *, int, sc_MPI_Datatype, int, int,
                                  sc_MPI_Comm, sc_MPI_Request *);
int                 sc_MPI_Probe (int, int, sc_MPI_Comm, sc_MPI_Status *);
int                 sc_MPI_Iprobe (int, int, sc_MPI_Comm, int *,
                                   sc_MPI_Status *);
int                 sc_MPI_Get_count (sc_MPI_Status *, sc_MPI_Datatype,
                                      int *);

/* These functions are only allowed to be called with NULL requests. */

int                 sc_MPI_Wait (sc_MPI_Request *, sc_MPI_Status *);
int                 sc_MPI_Waitsome (int, sc_MPI_Request *,
                                     int *, int *, sc_MPI_Status *);
int                 sc_MPI_Waitall (int, sc_MPI_Request *, sc_MPI_Status *);

#endif /* !SC_ENABLE_MPI */

#if defined SC_ENABLE_MPI && defined SC_ENABLE_MPITHREAD

#define sc_MPI_THREAD_SINGLE       MPI_THREAD_SINGLE
#define sc_MPI_THREAD_FUNNELED     MPI_THREAD_FUNNELED
#define sc_MPI_THREAD_SERIALIZED   MPI_THREAD_SERIALIZED
#define sc_MPI_THREAD_MULTIPLE     MPI_THREAD_MULTIPLE

#define sc_MPI_Init_thread         MPI_Init_thread

#else

#define sc_MPI_THREAD_SINGLE       0
#define sc_MPI_THREAD_FUNNELED     1
#define sc_MPI_THREAD_SERIALIZED   2
#define sc_MPI_THREAD_MULTIPLE     3

int                 sc_MPI_Init_thread (int *argc, char ***argv,
                                        int required, int *provided);

#endif /* !(SC_ENABLE_MPI && SC_ENABLE_MPITHREAD) */

/** Return the size of MPI data types.
 * \param [in] t    MPI data type.
 * \return          Returns the size in bytes.
 */
size_t              sc_mpi_sizeof (sc_MPI_Datatype t);

/** Compute ``sc_intranode_comm'' and ``sc_internode_comm''
 * communicators and attach them to the current communicator.  This split
 * takes \a processes_per_node passed by the user at face value: there is no
 * hardware checking to see if this is the true affinity.
 *
 * This function does nothing if MPI_Comm_split_type is not found.
 *
 * \param [in/out] comm                 MPI communicator
 * \param [in]     processes_per_node   the size of the intranode
 *                                      communicators. if < 1,
 *                                      sc will try to determine the correct
 *                                      shared memory communicators.
 */
void                sc_mpi_comm_attach_node_comms (sc_MPI_Comm comm,
                                                   int processes_per_node);

/** Destroy ``sc_intranode_comm'' and ``sc_internode_comm''
 * communicators that are stored as attributes to communicator ``comm''.
 * This routine enforces a call to the destroy callback for these attributes.
 *
 * This function does nothing if MPI_Comm_split_type is not found.
 *
 * \param [in/out] comm                 MPI communicator
 */
void                sc_mpi_comm_detach_node_comms (sc_MPI_Comm comm);

/** Get the communicators computed in sc_mpi_comm_attach_node_comms() if they
 * exist; return sc_MPI_COMM_NULL otherwise.
 *
 * \param[in] comm            Super communicator
 * \param[out] intranode      intranode communicator
 * \param[out] internode      internode communicator
 */
void                sc_mpi_comm_get_node_comms (sc_MPI_Comm comm,
                                                sc_MPI_Comm * intranode,
                                                sc_MPI_Comm * internode);

/** Convenience function to get a node comm and attach it as an attribute.
 * \param [in,out] comm       As in \ref sc_mpu_comm_attach_node_comms.
 * \return                    If the intranode communicator cannot be
 *                            obtained, return 0.
 *                            Otherwise return size of intranode communicator.
 */
int                 sc_mpi_comm_get_and_attach (sc_MPI_Comm comm);

SC_EXTERN_C_END;

#endif /* !SC_MPI_H */
