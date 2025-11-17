#pragma once
#include <cstdint>

struct TestStruct
{
  int8_t Val8;
  int64_t Val64;
  int16_t Val16;
  int32_t Val32;
};

// ch04-08-fasm.s
extern "C" int64_t SumStructVals_a(const TestStruct* ts);

// ch04-08-misc.cpp
extern void DisplayResults(const TestStruct& ts, int64_t sum1, int64_t sum2);
