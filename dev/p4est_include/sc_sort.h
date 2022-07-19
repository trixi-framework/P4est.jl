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

#ifndef SC_SORT_H
#define SC_SORT_H

#include <sc.h>

SC_EXTERN_C_BEGIN;

/** Sort a distributed set of fixed-size data items in parallel.
 * This algorithm uses bitonic sort between processors and qsort locally.
 *
 * This function is thread-safe if src/sc_config.h #defines SC_HAVE_QSORT_R.
 * Otherwise, it uses a static read-only variable for the comparison function,
 * and calling \ref sc_psort concurrently is likely to fail.
 *
 * The partition of the data can be arbitrary and is not changed.
 *
 * \param [in] mpicomm          Communicator to use.
 * \param [in] base             Pointer to the process-local data items.
 * \param [in] nmemb            Array of mpisize counts of data items.  For
 *                              each process, the number of its local items.
 *                              This array must be identical on all processes.
 * \param [in] size             Size in bytes of one data item.
 * \param [in] compar           Comparison function to use; see man (3) qsort.
 *                              Shall return < 0 if the first argument is less
 *                              than the second, 0 if both are equal, and > 0
 *                              if the first is greater than the second.
 */
void                sc_psort (sc_MPI_Comm mpicomm, void *base,
                              size_t * nmemb, size_t size,
                              int (*compar) (const void *, const void *));

SC_EXTERN_C_END;

#endif /* SC_SORT_H */
