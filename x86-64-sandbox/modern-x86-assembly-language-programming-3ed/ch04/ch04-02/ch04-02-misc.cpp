#include <iostream>
#include <iomanip>
#include <random>
#include "ch04-02.h"

void FillArrays(
  int64_t* c1,
  int64_t* c2,
  int64_t* a,
  int64_t* b,
  size_t n
) {
  constexpr int64_t max_val = 1000;
  constexpr int64_t min_val = -max_val;
  constexpr unsigned int rng_seed = 1001;

  std::mt19937 arng { rng_seed };
  std::uniform_int_distribution<int64_t> adist {min_val, max_val};
  for (size_t i = 0; i < n; ++i) {
    int val;
    while ((val = adist(arng)) == 0) {}
    a[i] = val;
  }

  std::mt19937 brng { rng_seed/7 };
  std::uniform_int_distribution<int64_t> bdist {min_val, max_val};
  for (size_t i = 0; i < n; ++i) {
    int val;
    while ((val = bdist(brng)) == 0) {}
    b[i] = val;
  }

  memset(c1, 0, sizeof(int64_t) * n);
  memset(c2, 0, sizeof(int64_t) * n);
}

void DisplayResults(
  const int64_t* c1,
  const int64_t* c2,
  const int64_t* a,
  const int64_t* b,
  size_t n
) {
  std::cout << "----- Results for ch04-02 -----\n";

  for (size_t i = 0; i < n; ++i) {
    std::cout << "a[" << std::setw(2) << i << "]: " << std::setw(8) << a[i];
    std::cout << " b[" << std::setw(2) << i << "]: " << std::setw(8) << b[i];
    std::cout << " c1[" << std::setw(2) << i << "]: " << std::setw(8) << c1[i];
    std::cout << " c2[" << std::setw(2) << i << "]: " << std::setw(8) << c2[i] << '\n';

    if (c1[i] != c2[i]) {
      std::cout << "array element compare failed\n";
      break;
    }
  }
}
