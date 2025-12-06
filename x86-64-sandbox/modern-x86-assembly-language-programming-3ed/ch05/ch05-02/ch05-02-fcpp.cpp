#include <cmath>
#include <numbers>
#include "ch05-02.h"

float g_F32_PI = std::numbers::pi_v<float>;

void CalcConeVolSA_cpp(float *vol, float *sa, float r, float h)
{
  constexpr float pi = std::numbers::pi_v<float>;

  *vol = pi * r * r * h / 3.0f;
  *sa = pi * r * (r + sqrt(r * r + h * h));
}
