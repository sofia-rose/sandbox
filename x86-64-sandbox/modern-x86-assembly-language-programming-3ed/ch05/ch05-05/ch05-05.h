#pragma once
#include <cstddef>
#include <cstdint>

// ch05-04-fasm.s
extern "C" void CompareF32_avx(uint8_t* cmp_results, float a, float b);

// ch05-04-misc.cpp
extern void DisplayResults(const uint8_t* cmp_results, float a, float b);

// miscellaneous constants
constexpr size_t c_NumCmpOps = 8;
