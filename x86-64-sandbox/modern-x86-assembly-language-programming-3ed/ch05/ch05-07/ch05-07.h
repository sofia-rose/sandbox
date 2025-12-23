#pragma once
#include <cstddef>

// ch05-07-fasm.s
extern "C" bool CalcMeanF64_avx(double* mean, const double* x, size_t n);
extern "C" bool CalcStdDevF64_avx(double* std_dev, const double* x, size_t n, double mean);

// ch05-07-fcpp.cpp
extern bool CalcMeanF64_cpp(double* mean, const double* x, size_t n);
extern bool CalcStdDevF64_cpp(double* std_dev, const double* x, size_t n, double mean);

// ch05-07-misc.cpp
extern void InitArray(double* x, size_t n);

// miscellaneous constants
constexpr size_t c_NumElements = 91;
constexpr double c_RngMin = 1.0;
constexpr double c_RngMax = 100.0;
constexpr unsigned int c_RngSeed = 13;
