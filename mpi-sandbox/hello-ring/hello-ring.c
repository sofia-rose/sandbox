/*
  This code is based on pages 281-283 of the book:
  Patterns For Parallel Programming (2005)
*/

#include <stdlib.h>
#include <stdio.h>
#include <float.h>

#include <mpi.h>

void ring(
  double* x,
  double* incoming,
  int buff_count,
  int proc_count,
  int num_shifts,
  int proc_id
) {
  int next = (proc_id + 1) % proc_count;
  int prev = (proc_id == 0) ? (proc_count - 1) : (proc_id - 1);
  MPI_Status status;

  if (proc_id % 2) {
    for(int i = 0; i < num_shifts; ++i) {
      MPI_Send(x, buff_count, MPI_DOUBLE, next, 3, MPI_COMM_WORLD);
      MPI_Recv(incoming, buff_count, MPI_DOUBLE, prev, 3, MPI_COMM_WORLD, &status);
    }
  } else {
    for(int i = 0; i < num_shifts; ++i) {
      MPI_Recv(incoming, buff_count, MPI_DOUBLE, prev, 3, MPI_COMM_WORLD, &status);
      MPI_Send(x, buff_count, MPI_DOUBLE, next, 3, MPI_COMM_WORLD);
    }
  }
}

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

  int buff_count;
  int num_shifts;
  if (proc_id == 0) {
    if (argc != 3) {
      printf("Usage: %s <size of message> <num of shifts>\n", argv[0]);
      fflush(stdout);
      MPI_Abort(MPI_COMM_WORLD, 1);
    }

    buff_count = atoi(argv[1]);
    num_shifts = atoi(argv[2]);

    if (buff_count <= 0) {
      printf("Size of message must be greater than 0\n");
      fflush(stdout);
      MPI_Abort(MPI_COMM_WORLD, 1);
    }

    if (num_shifts <= 0) {
      printf("Number of shifts must be greater than 0\n");
      fflush(stdout);
      MPI_Abort(MPI_COMM_WORLD, 1);
    }
  }

  MPI_Bcast(&buff_count, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(&num_shifts, 1, MPI_INT, 0, MPI_COMM_WORLD);

  printf("%d: shift %d doubles %d times\n", proc_id, buff_count, num_shifts);
  fflush(stdout);

  size_t buff_size_bytes = buff_count * sizeof(double);

  double* x = (double*)malloc(buff_size_bytes);
  double* incoming = (double*)malloc(buff_size_bytes);

  for (int i = 0; i < buff_count; ++i) {
    x[i] = (double) i;
    incoming[i] = -1.0;
  }

  MPI_Barrier(MPI_COMM_WORLD);

  double t0 = MPI_Wtime();

  ring(x, incoming, buff_count, proc_count, num_shifts, proc_id);

  double ring_time = MPI_Wtime() - t0;

  MPI_Barrier(MPI_COMM_WORLD);

  double max_time = -DBL_MAX;
  MPI_Reduce(&ring_time, &max_time, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

  if (proc_id == 0) {
    printf("Ring test took %f seconds\n", max_time);
  }

  MPI_Finalize();

  return 0;
}
