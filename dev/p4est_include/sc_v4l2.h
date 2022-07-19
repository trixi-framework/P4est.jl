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

/** \file sc_v4l2.h
 *
 * Support for video for linux version 2.
 */

#ifndef SC_V4L2_H
#define SC_V4L2_H

#include <sc.h>

SC_EXTERN_C_BEGIN;

typedef struct sc_v4l2_device sc_v4l2_device_t;

/** Open a video device by special file name.
 * The device is queried but its state is not modified.
 * \param [in] devname      Special file name such as `/dev/video8`.
 * \return                  Valid pointer on success, NULL on error.
 */
sc_v4l2_device_t   *sc_v4l2_device_open (const char *devname);

/** Close a video device.
 * \param [in,out] vd   Close this device and deallocate associated resources.
 * \return              0 on success, -1 otherwise.
 */
int                 sc_v4l2_device_close (sc_v4l2_device_t * vd);

/** Return string that details some driver and device properties.
 * \param [in] vd   Opened \ref sc_v4l2_device_t.  Not modified.
 * \return          NUL-terminated string only valid while the device \a vd is.
 */
const char         *sc_v4l2_device_devstring (const sc_v4l2_device_t * vd);

/** Return string that details some device capabilities.
 * \param [in] vd   Opened \ref sc_v4l2_device_t.  Not modified.
 * \return          NUL-terminated string only valid while the device \a vd is.
 */
const char         *sc_v4l2_device_capstring (const sc_v4l2_device_t * vd);

/** Return string that details some output properties.
 * \param [in] vd   Opened \ref sc_v4l2_device_t.  Not modified.
 * \return          If output is supported as desired, return NUL-terminated
 *                  string only valid while the \a vd object is alive.
 *                  Otherwise return NULL.
 */
const char         *sc_v4l2_device_outstring (const sc_v4l2_device_t * vd);

/** Query whether a device supports read/write I/O.
 * \param [in] vd   Any pointer.
 * \return          True iff \a vd is valid and read/write is supported.
 */
int                 sc_v4l2_device_is_readwrite (const sc_v4l2_device_t * vd);

/** Query whether a device supports streaming I/O.
 * \param [in] vd   Any pointer.
 * \return          True iff \a vd is valid and streaming is supported.
 */
int                 sc_v4l2_device_is_streaming (const sc_v4l2_device_t * vd);

/** Call select (2) to wait for write availability of device.
 * \param [in] vd   Opened \ref sc_v4l2_device_t capable of output.
 * \param [in] usec Number of microseconds to wait for device.
 *                  We return sooner if interrupted by a signal.
 * \return          -1 on error, 0 on timeout, 1 when ready for writing.
 */
int                 sc_v4l2_device_select (sc_v4l2_device_t * vd,
                                           unsigned usec);

/** Call write (2) to copy an image buffer to device.
 * \param [in] vd   Opened \ref sc_v4l2_device_t capable of output.
 * \param [in] wbuf Buffer holding at least \a sizeimage many bytes.
 * \return          0 on success, -1 otherwise and setting errno.
 */
int                 sc_v4l2_device_write (sc_v4l2_device_t * vd,
                                          const char *wbuf);

/** Set output configuration of device.
 * We demand sRGB color space with RGB 565 pixel format (2 bytes).
 * The image size values on output define the buffer size to allocate.
 * \param [in,out] vd   Device must support the desired output format.
 * \param [in,out] width    Desired width on input, actual width on output.
 * \param [in,out] height   Desired height on input, actual height on output.
 * \param [out] bytesperline    Bytes per line on output, including padding.
 * \param [out] sizeimage       Bytes per image, including padding.
 * \return          0 on success, -1 otherwise and setting errno.
 */
int                 sc_v4l2_device_format (sc_v4l2_device_t * vd,
                                           unsigned int *width,
                                           unsigned int *height,
                                           unsigned int *bytesperline,
                                           unsigned int *sizeimage);

SC_EXTERN_C_END;

#endif /* SC_V4L2_H */
