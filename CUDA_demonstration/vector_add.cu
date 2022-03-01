#include <stdio.h>
__global__ void VecAdd(float* A, float* B, float* C, int N)
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if (i < N)
    C[i] = A[i] + B[i];
}

void hostVecAdd(float* A, float* B, float* C, int N){
      for(int i = 0; i < N; i = i + 1) {
          C[i] = A[i] + B[i];
      }
  }

int main()
{
  int N = 10000;
  size_t size = N * sizeof(float);

  //initialize host vectors
  float* host_A = (float*)malloc(size);
  float* host_B = (float*)malloc(size);
  float* host_C = (float*)malloc(size);

  //define host vectors
  for(int i = 0; i < N; i = i + 1) {
    host_A[i] = i;
    host_B[i] = i;
    //printf("A[%d] = %f, ", i,host_A[i]);
    //printf("B[%d] = %f \n", i,host_B[i]);
  
  }

  //initialize device vectors
  float* device_A;
  cudaMalloc(&device_A,size);
  float* device_B;
  cudaMalloc(&device_B,size);
  float* device_C;
  cudaMalloc(&device_C,size);

  //copy host vector to device vector
  cudaMemcpy(device_A, host_A, size, cudaMemcpyHostToDevice);
  cudaMemcpy(device_B, host_B, size, cudaMemcpyHostToDevice);

  //run device kernel
  int threadsPerBlock = 256;
  int blocksPerGrid = (N + threadsPerBlock -1) / threadsPerBlock;\
  //device vector adder
  //VecAdd<<<blocksPerGrid, threadsPerBlock>>>(device_A, device_B, device_C, N);
  //host vector adder for comparison
  //hostVecAdd(host_A, host_B, host_C, N);

  //copy results from device to host
  cudaMemcpy(host_C, device_C, size, cudaMemcpyDeviceToHost);

    for(int i = 0; i < N; i = i + 1) {
     // printf("C[%d] = %f \n", i,host_C[i]);
  }

  //free device memory
  cudaFree(device_A);
  cudaFree(device_B);
  cudaFree(device_C);
}