#pragma once

extern "C" int ShiftU32_a(
  unsigned int* a_shl,
  unsigned int* a_shr,
  unsigned int a,
  unsigned int count);

extern void DisplayResults(
  const char* s,
  int rc,
  unsigned int a,
  unsigned int count,
  unsigned int a_shl,
  unsigned int a_shr);
