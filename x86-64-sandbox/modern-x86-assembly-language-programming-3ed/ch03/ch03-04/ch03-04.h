#pragma once
#include <cstdint>

// ch03-04-fasm.s
extern "C" int32_t SignedMin1_a(int32_t a, int32_t b, int32_t c);
extern "C" int32_t SignedMin2_a(int32_t a, int32_t b, int32_t c);
extern "C" int32_t SignedMax1_a(int32_t a, int32_t b, int32_t c);
extern "C" int32_t SignedMax2_a(int32_t a, int32_t b, int32_t c);

// ch03-04-misc.cpp
void DisplayResults(
  const char* s1,
  int32_t a, int32_t b, int32_t c, int32_t result
);
