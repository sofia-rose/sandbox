#pragma once

extern "C" unsigned int BitOpsU32_a(
  unsigned int a,
  unsigned int b,
  unsigned int c,
  unsigned int d);

extern unsigned int BitOpsU32_cpp(
  unsigned int a,
  unsigned int b,
  unsigned int c,
  unsigned int d);

extern void DisplayResults(
  unsigned int a,
  unsigned int b,
  unsigned int c,
  unsigned int d,
  unsigned int r1,
  unsigned int r2);
