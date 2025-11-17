#include <iostream>
#include <memory>
#include "ch04-05.h"

int main()
{
  constexpr int64_t n = 10000;
  std::unique_ptr<int32_t[]> x_array { new int32_t[n] };
  std::unique_ptr<int32_t[]> y_array { new int32_t[n] };
  int32_t* x = x_array.get();
  int32_t* y = y_array.get();

  InitArrays(x, y, n, 11);

  std::cout << "----- Results for ch04-05 (array size = " << n << ") -----\n\n";

  int64_t result1 = CompareArrays_cpp(x, y, -n);
  int64_t result2 = CompareArrays_a(x, y, -n);
  DisplayResult("Test using invalid array size", -1, result1, result2);

  y[0] += 1;
  result1 = CompareArrays_cpp(x, y, n);
  result2 = CompareArrays_a(x, y, n);
  y[0] -= 1;
  DisplayResult("Test using first element mismatch", 0, result1, result2);

  y[n / 2] -= 2;
  result1 = CompareArrays_cpp(x, y, n);
  result2 = CompareArrays_a(x, y, n);
  y[n / 2] += 2;
  DisplayResult("Test using middle element mismatch", n / 2, result1, result2);

  y[n - 1] *= 3;
  result1 = CompareArrays_cpp(x, y, n);
  result2 = CompareArrays_a(x, y, n);
  y[n - 1] /= 3;
  DisplayResult("Test using last element mismatch", n - 1, result1, result2);

  result1 = CompareArrays_cpp(x, y, n);
  result2 = CompareArrays_a(x, y, n);
  DisplayResult("Test with identical elements in each array", n, result1, result2);

  return 0;
}
