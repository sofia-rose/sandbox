/*
  This code is based on page 278 of the book:
  Patterns For Parallel Programming (2005)
*/

#include <stdlib.h>
#include <stdio.h>

#include <mpi.h>

int main(int argc, char* argv[])
{
  if (MPI_Init(&argc, &argv) != MPI_SUCCESS) {
    printf("Could not initialize MPI!\n");
    exit(-1);
  }

  int proc_count;
  MPI_Comm_size(MPI_COMM_WORLD, &proc_count);

  int proc_id;
  MPI_Comm_rank(MPI_COMM_WORLD, &proc_id);

  if (proc_count != 2) {
    printf("%d: Ping pong requires exactly 2 processes!\n", proc_id);
    MPI_Abort(MPI_COMM_WORLD, 1);
  }

  int buffer_count = 100;
  long* buffer = (long*)malloc(buffer_count * sizeof(long));

  if (buffer == NULL) {
    printf("%d: Could not allocate buffer!\n", proc_id);
    MPI_Abort(MPI_COMM_WORLD, 1);
  }

  for (int i = 0; i < buffer_count; ++i) {
    buffer[i] = (long)i;
  }

  int tag1 = 1;
  int tag2 = 2;
  MPI_Status stat;

  if (proc_id == 0) {
    MPI_Send(buffer, buffer_count, MPI_LONG, 1, tag1, MPI_COMM_WORLD);
    MPI_Recv(buffer, buffer_count, MPI_LONG, 1, tag2, MPI_COMM_WORLD, &stat);
  } else {
    MPI_Recv(buffer, buffer_count, MPI_LONG, 0, tag1, MPI_COMM_WORLD, &stat);
    MPI_Send(buffer, buffer_count, MPI_LONG, 0, tag2, MPI_COMM_WORLD);
  }

  MPI_Finalize();

  return 0;
}
