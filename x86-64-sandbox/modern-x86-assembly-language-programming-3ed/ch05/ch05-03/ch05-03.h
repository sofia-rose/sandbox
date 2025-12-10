#pragma once
#include <cstddef>

// ch05-03-fasm.s
extern "C" void CalcSphereVolSA_avx(double* vol, double* sa, double r);

// ch05-03-fcpp.cpp
extern "C" double g_F64_PI;
extern void CalcSphereVolSA_cpp(double* vol, double* sa, double r);

// ch05-03-misc.cpp
extern void DisplayResults(
  size_t i,
  double r,
  double vol1,
  double sa1,
  double vol2,
  double sa2);
