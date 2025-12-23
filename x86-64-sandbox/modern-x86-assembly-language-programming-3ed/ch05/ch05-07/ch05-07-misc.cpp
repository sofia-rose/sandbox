#include <iostream>
#include <iomanip>
#include <random>
#include <cstring>
#include "ch05-07.h"

void InitArray(double* x, size_t n)
{
  std::mt19937 rng {c_RngSeed};
  std::uniform_real_distribution<double> dist {c_RngMin, c_RngMax};

  for (size_t i = 0; i < n; ++i) {
    x[i] = dist(rng);
  }
}
