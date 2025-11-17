#include <iostream>
#include <random>
#include <cstring>
#include "ch04-05.h"

void InitArrays(
  int32_t* x,
  int32_t* y,
  int64_t n,
  unsigned int rng_seed
) {
  constexpr int min_val = 1;
  constexpr int max_val = 10000;

  std::mt19937 rng {rng_seed};
  std::uniform_int_distribution<int32_t> dist {min_val, max_val};

  for (int64_t i = 0; i < n; ++i) {
    int val;
    while ((val = dist(rng)) == 0) {}
    x[i] = val;
    y[i] = val;
  }
}

void DisplayResult(
  const char* msg,
  int64_t expected,
  int64_t result1,
  int64_t result2
) {
  std::cout << msg << " (index = " << expected << ")\n";
  std::cout << "  result1 = " << result1;
  std::cout << "  result2 = " << result2 << '\n';

  if (expected != result1 || expected != result2) {
    std::cout << "  compare test failed\n";
  }

  std::cout << '\n';
}
