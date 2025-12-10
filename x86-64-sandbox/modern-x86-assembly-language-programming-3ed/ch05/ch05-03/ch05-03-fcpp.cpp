#include <numbers>
#include "ch05-03.h"

double g_F64_PI = std::numbers::pi_v<double>;

void CalcSphereVolSA_cpp(double* vol, double* sa, double r)
{
  double sa_temp = 4.0 * std::numbers::pi_v<double> * r * r;
  double vol_temp = sa_temp * r / 3.0;

  *sa = sa_temp;
  *vol = vol_temp;
}
