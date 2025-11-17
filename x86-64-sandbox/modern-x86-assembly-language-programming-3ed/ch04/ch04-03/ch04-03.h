#pragma once
#include <cstddef>
#include <cstdint>

// ch04-03-fasm.s
extern "C" void CalcMat2dSquares_a(
  int32_t* y,
  const int32_t* x,
  size_t m,
  size_t n);

// ch04-03-fcpp.cpp
extern void CalcMat2dSquares_cpp(
  int32_t* y,
  const int32_t* x,
  size_t m,
  size_t n);

// ch04-03-misc.cpp
extern void DisplayResults(
  const int32_t* y1,
  const int32_t* y2,
  const int32_t* x,
  size_t m,
  size_t n);
