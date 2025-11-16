#include <iostream>
#include <iomanip>
#include <random>
#include "ch04-01.h"

void FillArray(int32_t* x, size_t n)
{
  constexpr int32_t max_val = 1000;
  constexpr int32_t min_val = -max_val;
  constexpr unsigned int rng_seed = 1337;

  std::mt19937 rng { rng_seed };
  std::uniform_int_distribution<int32_t> dist {min_val, max_val};

  for (size_t i = 0; i < n; ++i) {
    int val;
    while ((val = dist(rng)) == 0) {}
    x[i] = val;
  }
}

void DisplayResults(const int32_t* x, size_t n, int64_t sum1, int64_t sum2)
{
  constexpr char nl = '\n';

  std::cout << "----- Results for ch04-01 -----\n";

  for (size_t i = 0; i < n; ++i) {
    std::cout << "x[" << i << "] = " << x[i] << nl;
  }
  std::cout << nl;

  std::cout << "sum1 = " << sum1 << nl;
  std::cout << "sum2 = " << sum2 << nl;
}
