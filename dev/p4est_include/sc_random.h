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

#ifndef SC_RANDOM_H
#define SC_RANDOM_H

/** \file sc_random.h
 * Provide pseudo-random generator and Poisson sampling.
 */

#include <sc.h>

/** The internal state of sc_rand and derived functions.
 * Can be set arbitrarily to obtain reproducible pseudo random numbers.
 */
typedef uint64_t    sc_rand_state_t;

/** Draw a (pseudo-)random variable uniformly distributed in [0, 1).
 * \param [in,out] state        Internal state of random number generator.
 * \return                      Number in [0, 1).
 */
double              sc_rand (sc_rand_state_t * state);

/** Sample the Gauss standard normal distribution.
 * Implements polar form of the Box Muller transform based on \ref sc_rand.
 * \param [in,out] state        Internal state of random number generator.
 * \param [in,out] second_result        We compute two independent samples.
 *                                      The first is the return value.
 *                                      The second is placed in *second_result
 *                                      unless second_result == NULL.
 * \return            Random sample from the standard normal distribution.
 */
double              sc_rand_normal (sc_rand_state_t * state,
                                    double *second_result);

/** Randomly draw either 0 or 1 where the probability for 1 is small.
 * \param [in,out] state        Internal state of random number generator.
 * \param [in] d                Probability of drawing ones.
 * \return                      0 or 1.
 */
int                 sc_rand_small (sc_rand_state_t * state, double d);

/** Draw from a random variable following the Poisson distribution.
 * \param [in,out] state        Internal state of random number generator.
 * \param [in] mean             Mean value of Poisson distribution.
 * \return                      Non-negative integer.
 */
int                 sc_rand_poisson (sc_rand_state_t * state, double mean);

#endif /* !SC_RANDOM_H */
