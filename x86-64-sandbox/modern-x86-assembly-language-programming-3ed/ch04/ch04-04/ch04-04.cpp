#include <iostream>
#include "ch04-04.h"

int main()
{
  const char* test_string =
  {
    "azure, beige, black, blue, brown\n"
    "cyan, gold, gray, indigo, magenta\n"
    "maroon, orange, pink, purplse, red\n"
    "teal, tan, violet, white, yellow\n"
  };

  const char sea_chars[] {'a', 'e', 'i', 'm', 'o', 'r', 't', 'v', 'w', 'X'};

  constexpr size_t num_sea_chars = sizeof(sea_chars) / sizeof(char);

  std::cout << "----- Results for ch04-04 -----\n\n";

  std::cout << "Test string:\n";
  std::cout << test_string << '\n';

  for (size_t j = 0; j < num_sea_chars; ++j) {
    size_t n1 = CountChars_cpp(test_string, sea_chars[j]);
    size_t n2 = CountChars_a(test_string, sea_chars[j]);

    DisplayResults(sea_chars[j], n1, n2);
  }

  return 0;
}
