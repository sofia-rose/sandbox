#pragma once

// ch06-07-fasm.s
extern "C" bool CalcBSA_avx(
  const double* ht,
  const double* wt,
  int n,
  double* bsa1,
  double* bsa2,
  double* bsa3,
  double* bsa_mean);

extern bool CalcBSA_cpp(
  const double* ht,
  const double* wt,
  int n,
  double* bsa1,
  double* bsa2,
  double* bsa3,
  double* bsa_mean);
