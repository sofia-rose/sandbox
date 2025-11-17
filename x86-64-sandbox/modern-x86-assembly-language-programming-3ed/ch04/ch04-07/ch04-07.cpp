#include "ch04-07.h"

int main()
{
  constexpr int32_t n = 25;
  int32_t y[n], x[n];

  InitArrays(y, x, n);

  int rc = ReverseArrayI32_a(y, x, n);

  DisplayResults(y, x, n, rc);

  return 0;
}
