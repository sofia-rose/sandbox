#include <iostream>
#include <iomanip>
#include <vector>
#include "ch05-07.h"

static void CalcMeanStdDevF64()
{
  constexpr size_t n = c_NumElements;
  std::vector<double> x_v(n);
  double* x = x_v.data();

  InitArray(x, n);

  double mean1, mean2, std_dev1, std_dev2;

  bool rc1 = CalcMeanF64_cpp(&mean1, x, n);
  bool rc2 = CalcMeanF64_avx(&mean2, x, n);
  bool rc3 = CalcStdDevF64_cpp(&std_dev1, x, n, mean1);
  bool rc4 = CalcStdDevF64_avx(&std_dev2, x, n, mean2);

  std::cout << "----- Results for ch05-07 -----\n";
  std::cout << std::fixed << std::setprecision(6);

  if (rc1 && rc2 && rc3 && rc4) {
    constexpr int w = 10;
    constexpr char nl = '\n';

    std::cout << "n:        " << std::setw(w) << n << nl;
    std::cout << "mean1:    " << std::setw(w) << mean1 << " ";
    std::cout << "std_dev1: " << std::setw(w) << std_dev1 << nl;
    std::cout << "mean2:    " << std::setw(w) << mean2 << " ";
    std::cout << "std_dev2: " << std::setw(w) << std_dev2 << nl;
  } else {
    std::cout << "Invalid return code\n";
  }
}

int main()
{
  CalcMeanStdDevF64();
  return 0;
}
