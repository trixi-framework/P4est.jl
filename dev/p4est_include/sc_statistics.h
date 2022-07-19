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

#ifndef SC_STATISTICS_H
#define SC_STATISTICS_H

#include <sc.h>
#include <sc_keyvalue.h>

SC_EXTERN_C_BEGIN;

/** This special group number (negative) will refer to any group. */
extern const int    sc_stats_group_all;

/** This special group number (negative) will refer to any priority. */
extern const int    sc_stats_prio_all;

/* sc_statinfo_t stores information for one random variable */
typedef struct sc_statinfo
{
  int                 dirty;    /* only update stats if this is true */
  long                count;    /* inout, global count is 52bit accurate */
  double              sum_values, sum_squares, min, max;        /* inout */
  int                 min_at_rank, max_at_rank; /* out */
  double              average, variance, standev;       /* out */
  double              variance_mean, standev_mean;      /* out */
  const char         *variable; /* name of the variable for output */
  char               *variable_owned;   /* NULL or deep copy of variable */
  int                 group;
  int                 prio;
}
sc_statinfo_t;

/* sc_statistics_t allows dynamically adding random variables */
typedef struct sc_stats
{
  sc_MPI_Comm         mpicomm;
  sc_keyvalue_t      *kv;
  sc_array_t         *sarray;
}
sc_statistics_t;

/** Populate a sc_statinfo_t structure assuming count=1 and mark it dirty.
 * We set \ref sc_stats_group_all and \ref sc_stats_prio_all internally.
 * \param [out] stats          Will be filled with count=1 and the value.
 * \param [in] value           Value used to fill statistics information.
 * \param [in] variable        String to be reported by \ref sc_stats_print.
 *                             This string is assigned by pointer, not copied.
 *                             Thus, it must stay alive while stats is in use.
 */
void                sc_stats_set1 (sc_statinfo_t * stats,
                                   double value, const char *variable);

/** Populate a sc_statinfo_t structure assuming count=1 and mark it dirty.
 * \param [out] stats          Will be filled with count=1 and the value.
 * \param [in] value           Value used to fill statistics information.
 * \param [in] variable        String to be reported by \ref sc_stats_print.
 * \param [in] copy_variable   If true, make internal copy of variable.
 *                             Otherwise just assign the pointer.
 * \param [in] stats_group     Non-negative number or \ref sc_stats_group_all.
 * \param [in] stats_prio      Non-negative number or \ref sc_stats_prio_all.
 */
void                sc_stats_set1_ext (sc_statinfo_t * stats,
                                       double value, const char *variable,
                                       int copy_variable,
                                       int stats_group, int stats_prio);

/** Initialize a sc_statinfo_t structure assuming count=0 and mark it dirty.
 * This is useful if \a stats will be used to \ref sc_stats_accumulate
 * instances locally before global statistics are computed.
 * We set \ref sc_stats_group_all and \ref sc_stats_prio_all internally.
 * \param [out] stats          Will be filled with count 0 and values of 0.
 * \param [in] variable        String to be reported by \ref sc_stats_print.
 *                             This string is assigned by pointer, not copied.
 *                             Thus, it must stay alive while stats is in use.
 */
void                sc_stats_init (sc_statinfo_t * stats,
                                   const char *variable);

/** Initialize a sc_statinfo_t structure assuming count=0 and mark it dirty.
 * This is useful if \a stats will be used to \ref sc_stats_accumulate
 * instances locally before global statistics are computed.
 * \param [out] stats          Will be filled with count 0 and values of 0.
 * \param [in] variable        String to be reported by \ref sc_stats_print.
 * \param [in] copy_variable   If true, make internal copy of variable.
 *                             Otherwise just assign the pointer.
 * \param [in] stats_group     Non-negative number or \ref sc_stats_group_all.
 * \param [in] stats_prio      Non-negative number or \ref sc_stats_prio_all.
 *                             Values increase by importance.
 */
void                sc_stats_init_ext (sc_statinfo_t * stats,
                                       const char *variable,
                                       int copy_variable,
                                       int stats_group, int stats_prio);

/** Reset all values to zero, optionally unassign name, group, and priority.
 * \param [in,out] stats       Variables are zeroed.
 *                             They can be set again by set1 or accumulate.
 * \param [in] reset_vgp       If true, the variable name string is zeroed
 *                             and if we did a copy, the copy is freed.
 *                             If true, group and priority are set to all.
 *                             If false, we don't touch any of the above.
 */
void                sc_stats_reset (sc_statinfo_t * stats, int reset_vgp);

/** Set/update the group and priority information for a stats item.
 * \param [out] stats          Only group and stats entries are updated.
 * \param [in] stats_group     Non-negative number or \ref sc_stats_group_all.
 * \param [in] stats_prio      Non-negative number or \ref sc_stats_prio_all.
 *                             Values increase by importance.
 */
void                sc_stats_set_group_prio (sc_statinfo_t * stats,
                                             int stats_group, int stats_prio);

/** Add an instance of the random variable.
 * The counter of the variable is increased by one.
 * The value is added into the present values of the variable.
 * \param [out] stats          Must be dirty.  We bump count and values.
 * \param [in] value           Value used to update statistics information.
 */
void                sc_stats_accumulate (sc_statinfo_t * stats, double value);

/**
 * Compute global average and standard deviation.
 * Only updates dirty variables. Then removes the dirty flag.
 * \param [in]     mpicomm   MPI communicator to use.
 * \param [in]     nvars     Number of variables to be examined.
 * \param [in,out] stats     Set of statisics items for each variable.
 * On input, set the following fields for each variable separately.
 *    count         Number of values for each process.
 *    sum_values    Sum of values for each process.
 *    sum_squares   Sum of squares for each process.
 *    min, max      Minimum and maximum of values for each process.
 *    variable      String describing the variable, or NULL.
 * On output, the fields have the following meaning.
 *    count                        Global number of values.
 *    sum_values                   Global sum of values.
 *    sum_squares                  Global sum of squares.
 *    min, max                     Global minimum and maximum values.
 *    min_at_rank, max_at_rank     The ranks that attain min and max.
 *    average, variance, standev   Global statistical measures.
 *    variance_mean, standev_mean  Statistical measures of the mean.
 */
void                sc_stats_compute (sc_MPI_Comm mpicomm, int nvars,
                                      sc_statinfo_t * stats);

/**
 * Version of sc_statistics_statistics that assumes count=1.
 * On input, the field sum_values needs to be set to the value
 * and the field variable must contain a valid string or NULL.
 * Only updates dirty variables. Then removes the dirty flag.
 */
void                sc_stats_compute1 (sc_MPI_Comm mpicomm, int nvars,
                                       sc_statinfo_t * stats);

/** Print measured statistics.
 * This function uses the SC_LC_GLOBAL log category.
 * That means the default action is to print only on rank 0.
 * Applications can change that by providing a user-defined log handler.
 * All groups and priorities are printed.
 * \param [in] package_id       Registered package id or -1.
 * \param [in] log_priority     Log priority for output according to sc.h.
 * \param [in] nvars            Number of stats items in input array.
 * \param [in] stats            Input array of stats variable items.
 * \param [in] full             Print full information for every variable.
 * \param [in] summary          Print summary information all on 1 line.
 */
void                sc_stats_print (int package_id, int log_priority,
                                    int nvars, sc_statinfo_t * stats,
                                    int full, int summary);

/** Print measured statistics, filter by group and/or priority.
 * This function uses the SC_LC_GLOBAL log category.
 * That means the default action is to print only on rank 0.
 * Applications can change that by providing a user-defined log handler.
 * \param [in] package_id       Registered package id or -1.
 * \param [in] log_priority     Log priority for output according to sc.h.
 * \param [in] nvars            Number of stats items in input array.
 * \param [in] stats            Input array of stats variable items.
 * \param [in] stats_group      Print only this group.
 *                              Non-negative or \ref sc_stats_group_all.
 *                              We skip printing a variable if neither
 *                              this parameter nor the item's group is all
 *                              and if the item's group does not match this.
 * \param [in] stats_prio       Print this and higher priorities.
 *                              Non-negative or \ref sc_stats_prio_all.
 *                              We skip printing a variable if neither
 *                              this parameter nor the item's prio is all
 *                              and if the item's prio is less than this.
 * \param [in] full             Print full information for every variable.
 *                              This produces multiple lines including
 *                              minimum, maximum, and standard deviation.
 *                              If this is false, print one line per variable.
 * \param [in] summary          Print summary information all on 1 line.
 *                              This always contains all variables.
 *                              Not affected by stats_group and stats_prio.
 */
void                sc_stats_print_ext (int package_id, int log_priority,
                                        int nvars, sc_statinfo_t * stats,
                                        int stats_group, int stats_prio,
                                        int full, int summary);

/** Create a new statistics structure that can grow dynamically.
 */
sc_statistics_t    *sc_statistics_new (sc_MPI_Comm mpicomm);
void                sc_statistics_destroy (sc_statistics_t * stats);

/** Register a statistics variable by name and set its value to 0.
 * This variable must not exist already.
 */
void                sc_statistics_add (sc_statistics_t * stats,
                                       const char *name);

/** Register a statistics variable by name and set its count to 0.
 * This variable must not exist already.
 */
void                sc_statistics_add_empty (sc_statistics_t * stats,
                                             const char *name);

/** Returns true if the stats include a variable with the given name */
int                 sc_statistics_has (sc_statistics_t * stats,
                                       const char *name);
/** Set the value of a statistics variable, see sc_stats_set1.
 * The variable must previously be added with sc_statistics_add.
 * This assumes count=1 as in the sc_stats_set1 function above.
 */
void                sc_statistics_set (sc_statistics_t * stats,
                                       const char *name, double value);

/** Add an instance of a statistics variable, see sc_stats_accumulate
 * The variable must previously be added with sc_statistics_add_empty.
 */
void                sc_statistics_accumulate (sc_statistics_t * stats,
                                              const char *name, double value);

/** Compute statistics for all variables, see sc_stats_compute.
 */
void                sc_statistics_compute (sc_statistics_t * stats);

/** Print all statistics variables, see sc_stats_print.
 */
void                sc_statistics_print (sc_statistics_t * stats,
                                         int package_id, int log_priority,
                                         int full, int summary);

SC_EXTERN_C_END;

#endif /* !SC_STATISTICS_H */
