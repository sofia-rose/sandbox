#pragma once
#include <cstddef>
#include <cstdint>

// ch04-02-fasm.s
extern "C" void CalcArrayVals_a(
  int64_t* c,
  const int64_t* a,
  const int64_t* b,
  size_t n);

// ch04-02-fcpp.cpp
extern void CalcArrayVals_cpp(
  int64_t* c,
  const int64_t* a,
  const int64_t* b,
  size_t n);

// ch04-02-misc.cpp
extern void FillArrays(
  int64_t* c1,
  int64_t* c2,
  int64_t* a,
  int64_t* b,
  size_t n);

extern void DisplayResults(
  const int64_t* c1,
  const int64_t* c2,
  const int64_t* a,
  const int64_t* b,
  size_t n);
