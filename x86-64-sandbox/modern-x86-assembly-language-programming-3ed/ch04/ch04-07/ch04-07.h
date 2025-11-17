#pragma once
#include <cstdint>

// ch04-07-fasm.s
extern "C" int ReverseArrayI32_a(int32_t* y, const int32_t* x, int32_t n);

// ch04-07-misc.cpp
void InitArrays(int32_t* y, int32_t* x, int32_t n);
void DisplayResults(const int32_t* y, const int32_t* x, int32_t n, int rc);
