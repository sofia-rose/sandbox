#include <stdio.h>

__global__ void vecAddKernel(float* A, float* B, float* C, int n) {
  int i = threadIdx.x + blockDim.x * blockIdx.x;
  if (i < n) {
    C[i] = A[i] + B[i];
  }
}

void vecAdd(float* A_h, float* B_h, float* C_h, int n) {
  int size = n * sizeof(float);
  float *A_d, *B_d, *C_d;
  cudaError_t err;

  err = cudaMalloc((void **) &A_d, size);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }

  err = cudaMalloc((void **) &B_d, size);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }

  err = cudaMalloc((void **) &C_d, size);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }

  err = cudaMemcpy(A_d, A_h, size, cudaMemcpyHostToDevice);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }

  err = cudaMemcpy(B_d, B_h, size, cudaMemcpyHostToDevice);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }


  // Launch ceil(n/256) blocks of 256 threads each
  vecAddKernel<<<ceil(n/256.0), 256>>>(A_d, B_d, C_d, n);


  err = cudaMemcpy(C_h, C_d, size, cudaMemcpyDeviceToHost);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }

  err = cudaFree(A_d);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }
  err = cudaFree(B_d);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }
  err = cudaFree(C_d);
  if (cudaSuccess != err) {
    printf("%s in %s at line %d\n", cudaGetErrorString(err), __FILE__, __LINE__);
    exit(EXIT_FAILURE);
  }
}

int main() {
  float *A, *B, *C;
  int n = 1024*1024;
  size_t size = n * sizeof(float);

  A = (float*)malloc(size);
  if (NULL == A) {
    printf("Cannot allocate memory for vector A\n");
    exit(EXIT_FAILURE);
  }

  B = (float*)malloc(size);
  if (NULL == B) {
    printf("Cannot allocate memory for vector B\n");
    exit(EXIT_FAILURE);
  }

  C = (float*)malloc(size);
  if (NULL == B) {
    printf("Cannot allocate memory for vector C\n");
    exit(EXIT_FAILURE);
  }

  for (int i = 0; i < n; ++i) {
    A[i] = i;
    B[i] = i;
  }

  vecAdd(A, B, C, n);

  for (int i = 0; i < n; ++i) {
    printf("A[%d] + B[%d] = C[%d]: %f + %f = %f\n", i, i, i, A[i], B[i], C[i]);
  }

  return 0;
}
