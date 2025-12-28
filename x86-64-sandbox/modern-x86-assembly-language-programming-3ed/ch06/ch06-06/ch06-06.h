#pragma once
#include <cstdint>

// ch06-06-fasm.s
extern "C" int64_t AddIntegers_a(
   int8_t a,
  int16_t b,
  int32_t c,
  int64_t d,
   int8_t e,
  int16_t f,
  int32_t g,
  int64_t h);

extern int64_t AddIntegers_cpp(
   int8_t a,
  int16_t b,
  int32_t c,
  int64_t d,
   int8_t e,
  int16_t f,
  int32_t g,
  int64_t h);
