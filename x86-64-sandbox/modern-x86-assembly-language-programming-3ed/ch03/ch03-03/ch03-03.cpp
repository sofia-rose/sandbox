#include <iostream>
#include "ch03-03.h"

int main()
{
  std::cout << "---- results for ch03-03 ----\n";

  // initialize g_SumPrimes_a (defined in assembly language file)
  g_SumPrimes_a = 0;

  for (int i = -1; i < g_NumPrimes_a + 1; ++i) {
    int32_t v1 = -1, v2 = -1, v3 = -1, v4 = -1;
    int rc = MemAddressing_a(i, &v1, &v2, &v3, &v4);

    DisplayResults(i, rc, v1, v2, v3, v4);
  }

  std::cout << "\ng_sumPrimes_a = " << g_SumPrimes_a << '\n';
  return 0;
}
