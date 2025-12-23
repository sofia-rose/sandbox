#include <cmath>
#include "ch05-07.h"

bool CalcMeanF64_cpp(double* mean, const double* x, size_t n)
{
  if (n < 2) {
    return false;
  }

  double sum = 0.0;

  for (size_t i = 0; i < n; ++i) {
    sum += x[i];
  }

  *mean = sum / n;

  return true;
}


bool CalcStdDevF64_cpp(double* std_dev, const double* x, size_t n, double mean)
{
  if (n < 2) {
    return false;
  }

  double sum_squares = 0.0;

  for (size_t i = 0; i < n; ++i) {
    double temp = x[i] - mean;
    sum_squares += temp * temp;
  }

  *std_dev = sqrt(sum_squares / (n - 1));

  return true;
}
