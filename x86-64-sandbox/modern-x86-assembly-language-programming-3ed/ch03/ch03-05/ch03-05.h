#pragma once
#include <cstdint>

// ch03-05-fasm.s
extern "C" bool CalcSumCubes_a(int64_t* sum, int64_t n);

// ch03-05-fcpp.cpp
extern bool CalcSumCubes_cpp(int64_t* sum, int64_t n);

// ch03-05-misc.cpp
extern void DisplayResults(
  int id, int64_t n,
  int64_t sum1, bool rc1,
  int64_t sum2, bool rc2
);

// ch03-05.cpp
extern "C" int64_t g_ValMax;
