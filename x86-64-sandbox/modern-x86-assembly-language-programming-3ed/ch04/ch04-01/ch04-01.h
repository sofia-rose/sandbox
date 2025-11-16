#pragma once
#include <cstddef>
#include <cstdint>

// ch04-01-fasm.s
extern "C" int64_t SumElementsI32_a(const int32_t* x, size_t n);

// ch04-01-fcpp.cpp
extern int64_t SumElementsI32_cpp(const int32_t* x, size_t n);

// ch04-01-misc.cpp
extern void FillArray(int32_t* x, size_t n);
extern void DisplayResults(const int32_t* x, size_t n, int64_t sum1, int64_t sum2);
