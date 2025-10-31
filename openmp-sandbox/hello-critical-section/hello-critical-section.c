#include <stdio.h>
#include <omp.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>

#define N 10000

void combine(uint64_t* accum, uint64_t x)
{
  *accum += x;
}

double big_comp(uint64_t x)
{
  return x * x;
}

int main()
{
  int thread_id;
  int thread_count;
  uint64_t i;
  uint64_t answer = 0;
  uint64_t res;

  #pragma omp parallel for private(res, thread_id, thread_count)
  for (i = 1; i <= N; ++i) {
    thread_id = omp_get_thread_num();
    thread_count = omp_get_num_threads();


    res = big_comp(i);

    printf("Hello from iteration %ld, thread %d out of %d: %ld\n", i, thread_id, thread_count, res);

    #pragma omp critical
    {
      combine(&answer, res);
    }
  }

  printf("%ld\n", answer);
  printf("%ld\n", (uint64_t)N * (N + 1) * (2 * N + 1) / 6);
}
