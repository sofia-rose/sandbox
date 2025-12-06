#pragma once
#include <cstddef>

// ch05-02-fasm.s
extern "C" void CalcConeVolSA_avx(float* vol, float* sa, float r, float h);

// ch05-02-fcpp.cpp
extern "C" float g_F32_PI;
extern "C" void CalcConeVolSA_cpp(float* vol, float* sa, float r, float h);

// ch05-02-misc.cpp
extern void DisplayResults(
  size_t i,
  float r,
  float h,
  float vol1,
  float sa1,
  float vol2,
  float sa2
);
