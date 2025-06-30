#include <iostream>
#include "ch02-01.h"

void DisplayResults(int a, int b, int c, int d, int r1, int r2)
{
  constexpr char nl = '\n';

  std::cout << "------ Results for Ch02-01 ------\n";
  std::cout << "a = " << a << nl;
  std::cout << "b = " << b << nl;
  std::cout << "c = " << c << nl;
  std::cout << "d = " << d << nl;
  std::cout << "r1 = " << r1 << nl;
  std::cout << "r2 = " << r2 << nl;
  std::cout << nl;
}
