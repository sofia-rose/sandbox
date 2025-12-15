#pragma once
#include <cstddef>
#include <cstdint>

union Uval
{
  int32_t m_I32;
  int64_t m_I64;
  float m_F32;
  double m_F64;
};

enum class CvtOp : unsigned int
{
  I32_F32,
  F32_I32,
  I32_F64,
  F64_I32,
  I64_F32,
  F32_I64,
  I64_F64,
  F64_I64,
  F32_F64,
  F64_F32,
};

// rounding control
enum class RC : unsigned int
{
  Nearest, Down, Up, Zero
};

// ch05-06-fasm.s
extern "C" bool ConvertScalar_avx(Uval* a, Uval *b, CvtOp cvt_op, RC rc);
