#include <iostream>
#include <iomanip>
#include <random>
#include <cstring>
#include "ch04-07.h"

void InitArrays(int32_t* y, int32_t* x, int32_t n)
{
  constexpr int32_t max_val = 1000;
  constexpr int32_t min_val = -max_val;
  constexpr unsigned int rng_seed = 17;

  std::mt19937 rng {rng_seed};
  std::uniform_int_distribution<int32_t> dist {min_val, max_val};

  for (int32_t i = 0; i < n; ++i) {
    int val;
    while ((val = dist(rng)) == 0) {}
    x[i] = val;
  }

  memset(y, 0, sizeof(int32_t) * n);
}

void DisplayResults(const int32_t* y, const int32_t* x, int32_t n, int rc)
{
  if (rc == 0) {
    std::cout << "ReverseArrayI32_a() failed\n";
    return;
  }

  std::cout << "\n----- Results for ch04-07 -----\n";

  constexpr int w = 5;

  for (int32_t i = 0; i < n; ++i) {
    std::cout << " i: " << std::setw(w) << i;
    std::cout << " y: " << std::setw(w) << y[i];
    std::cout << " x: " << std::setw(w) << x[i] << '\n';

    if (x[i] != y[n - 1 - i]) {
      std::cout << "ReverseArrayI32_a() element compare error\n";
      break;
    }
  }
}
