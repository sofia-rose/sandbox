/*
  This code is based on page 276 of the book:
  Patterns For Parallel Programming (2005)
*/

#include <stdlib.h>
#include <stdio.h>
#include <mpi.h>

int main(int argc, char* argv[])
{
  int proc_count;
  int proc_id;
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int processor_name_len;

  if (MPI_Init(&argc, &argv) != MPI_SUCCESS) {
    printf("Could not initialize MPI!\n");
    exit(-1);
  }

  MPI_Comm_size(MPI_COMM_WORLD, &proc_count);
  MPI_Comm_rank(MPI_COMM_WORLD, &proc_id);

  MPI_Get_processor_name(processor_name, &processor_name_len);

  printf("Hello from processor %s, rank %d out of %d!\n",
    processor_name,
    proc_id,
    proc_count
  );

  MPI_Finalize();

  return 0;
}
