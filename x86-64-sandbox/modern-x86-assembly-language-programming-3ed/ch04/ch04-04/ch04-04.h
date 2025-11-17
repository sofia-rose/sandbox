#pragma once
#include <cstddef>
#include <cstdint>

// ch04-04-fasm.s
extern "C" size_t CountChars_a(const char* s, char c);

// ch04-04-fcpp.cpp
extern size_t CountChars_cpp(const char* s, char c);

// ch04-04-misc.cpp
extern void DisplayResults(char sea_char, size_t n, size_t n2);
