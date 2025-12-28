#pragma once
#include <cstdint>

// ch06-05-fasm.s
extern "C" int64_t MulIntegers_a(
  int8_t a,
  int16_t b,
  int32_t c,
  int64_t d,
  int8_t e,
  int16_t f,
  int32_t g,
  int64_t h);

// ch06-05-fcpp.cpp
extern int64_t MulIntegers_cpp(
  int8_t a,
  int16_t b,
  int32_t c,
  int64_t d,
  int8_t e,
  int16_t f,
  int32_t g,
  int64_t h);
