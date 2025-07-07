#pragma once

extern "C" long long AddSubI64a_a(
  long long a,
  long long b,
  long long c,
  long long d);

extern "C" long long AddSubI64b_a(
  long long a,
  long long b,
  long long c,
  long long d);

extern void DisplayResults(
  const char* msg,
  long long a,
  long long b,
  long long c,
  long long d,
  long long r1,
  long long r2);
