#include <stdio.h>
#include <omp.h>

void do_something_else(int id)
{
  printf("thread %d doing something else!\n", id);
}

void go_for_it(int id)
{
  printf("thread %d is going for it!\n", id);
}

int main()
{
  omp_lock_t lock1, lock2;
  int id;

  omp_init_lock(&lock1);
  omp_init_lock(&lock2);

  #pragma omp parallel shared(lock1, lock2) private(id)
  {
    id = omp_get_thread_num();

    omp_set_lock(&lock1);
    printf("thread %d has the lock\n", id);

    printf("thread %d ready to release the lock\n", id);

    omp_unset_lock(&lock1);

    while (!omp_test_lock(&lock2)) {
      do_something_else(id);
    }

    go_for_it(id);

    omp_unset_lock(&lock2);
  }

  omp_destroy_lock(&lock1);
  omp_destroy_lock(&lock2);

  return 0;
}
