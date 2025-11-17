#pragma once
#include <cstddef>
#include <cstdint>

// ch04-06-fasm.s
extern "C" void CopyArrayI32_a(int32_t* b, const int32_t* a, size_t n);
extern "C" void FillArrayI64_a(const int64_t* a, int64_t fill_val, size_t n);
