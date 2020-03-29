/* bitrotate.h - Rotate bits in integers
   Copyright (C) 2008-2020 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* Written by Simon Josefsson <simon@josefsson.org>, 2008. */
/* Updated for 128-bit types by Jeffrey Walton <noloader@gmail.com>, 2020 */

#ifndef _GL_BITROTATE_H
#define _GL_BITROTATE_H

#include <limits.h>
#include <stdint.h>
#include <sys/types.h>

#ifndef _GL_INLINE_HEADER_BEGIN
 #error "Please include config.h first."
#endif
_GL_INLINE_HEADER_BEGIN
#ifndef BITROTATE_INLINE
# define BITROTATE_INLINE _GL_INLINE
#endif

#ifdef UINT64_MAX
/* Given an unsigned 64-bit argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 0 and
   63 inclusive. */
BITROTATE_INLINE uint64_t
rotl64 (uint64_t x, int n)
{
  return ((x << n) | (x >> (-n&63)));
}

/* Given an unsigned 64-bit argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 0 to
   63 inclusive.*/
BITROTATE_INLINE uint64_t
rotr64 (uint64_t x, int n)
{
  return ((x >> n) | (x << (-n&63)));
}
#endif

/* Given an unsigned 32-bit argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 0 and
   31 inclusive. */
BITROTATE_INLINE uint32_t
rotl32 (uint32_t x, int n)
{
  return ((x << n) | (x >> (-n&31)));
}

/* Given an unsigned 32-bit argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 0 to
   31 inclusive.*/
BITROTATE_INLINE uint32_t
rotr32 (uint32_t x, int n)
{
  return ((x >> n) | (x << (-n&31)));
}

/* Given a size_t argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 1 and
   (CHAR_BIT * sizeof (size_t) - 1) inclusive.  */
BITROTATE_INLINE size_t
rotl_sz (size_t x, int n)
{
  enum {mask = (CHAR_BIT * sizeof x) -1};
  return ((x << n) | (x >> (-n&mask)));
}

/* Given a size_t argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 1 to
   (CHAR_BIT * sizeof (size_t) - 1) inclusive.  */
BITROTATE_INLINE size_t
rotr_sz (size_t x, int n)
{
  enum {mask = (CHAR_BIT * sizeof x) -1};
  return ((x >> n) | (x << (-n&mask)));
}

/* Given an unsigned 16-bit argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 0 to
   15 inclusive. */
BITROTATE_INLINE uint16_t
rotl16 (uint16_t x, int n)
{
  return ((x << n) | (x >> (-n&15)));
}

/* Given an unsigned 16-bit argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 0 to
   to 15 inclusive. */
BITROTATE_INLINE uint16_t
rotr16 (uint16_t x, int n)
{
  return ((x >> n) | (x << (-n&15)));
}

/* Given an unsigned 8-bit argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 0 to 7
   inclusive. */
BITROTATE_INLINE uint8_t
rotl8 (uint8_t x, int n)
{
  return ((x << n) | (x >> (-n&7)));
}

/* Given an unsigned 8-bit argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 0 to 7
   inclusive. */
BITROTATE_INLINE uint8_t
rotr8 (uint8_t x, int n)
{
  return ((x >> n) | (x << (-n&7)));
}

/* Some GCC, Clang, ICC and XLC support 128-bit integers.       */
/* https://gcc.gnu.org/legacy-ml/gcc-help/2015-08/msg00185.html */

#if __SIZEOF_INT128__ >= 16
/* Given an unsigned 128-bit argument X, return the value corresponding
   to rotating the bits N steps to the left.  N must be between 0 to 127
   inclusive. */
BITROTATE_INLINE __uint128_t
rotl128 (__uint128_t x, int n)
{
  return ((x << n) | (x >> (-n&127)));
}

/* Given an unsigned 128-bit argument X, return the value corresponding
   to rotating the bits N steps to the right.  N must be between 0 to 127
   inclusive. */
BITROTATE_INLINE __uint128_t
rotr128 (__uint128_t x, int n)
{
  return ((x >> n) | (x << (-n&127)));
}
#endif

_GL_INLINE_HEADER_END

#endif /* _GL_BITROTATE_H */
