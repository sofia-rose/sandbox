#include <stdio.h>
#include <math.h>
#include <omp.h>

int main()
{
  int thread_id, thread_count;
  int i;
  int num_steps = 1000000;
  double x, pi, step, sum = 0.0;

  step = 1.0 / (double)num_steps;

  #pragma omp parallel for private(x, thread_id, thread_count) reduction(+:sum)
  for (i = 0; i < num_steps; i++) {
    thread_id = omp_get_thread_num();
    thread_count = omp_get_num_threads();

    printf("Hello from iteration %d, thread %d out of %d\n", i, thread_id, thread_count);

    x = (i + 0.5) * step;
    sum += 4.0 / (1.0 + x * x);
  }

  pi = step * sum;
  printf("pi: %lf\n", pi);

  return 0;
}
