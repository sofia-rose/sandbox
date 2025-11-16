#include "ch04-01.h"

int64_t SumElementsI32_cpp(const int32_t* x, size_t n)
{
  int64_t sum = 0;

  for (size_t i = 0; i < n; ++i) {
    sum += x[i];
  }

  return sum;
}
