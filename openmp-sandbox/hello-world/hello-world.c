#include <stdio.h>
#include <omp.h>

int main()
{
  int thread_id, thread_count;

  omp_set_num_threads(6);

  #pragma omp parallel private(thread_id, thread_count)
  {
    thread_id = omp_get_thread_num();
    thread_count = omp_get_num_threads();

    printf("Hello from thread %d out of %d\n", thread_id, thread_count);
  }
}
