#include <stdio.h>
__global__ void VecAdd(float* A, float* B, float* C, int N)
{
  int i = blockDim.x * blockIdx.x + threadIdx.x;
  if (i < N)
    C[i] = A[i] + B[i];
}

__global__ void MatAdd(float* A, float* B, float* C, int N)
{
  int row = blockIdx.y * blockDim.y + threadIdx.y;
  int col = blockIdx.x + blockDim.x + threadIdx.x;
    C[row*N+col] = A[row*N+col] + B[row*N+col];
}

__global__ void convert2Dto1D(float* X, float* Y, int m, int n){
  for(int i = 0; i < n; i = i + 1){
    for(int j = 0; j < m; j = j + 1){
      Y[j*n + i] = 1;
    }
  }

}

void hostVecAdd(float* A, float* B, float* C, int N){
      for(int i = 0; i < N; i = i + 1) {
          C[i] = A[i] + B[i];
      }
  }

int main()
{
  int N = 10000000000;
  size_t size = N * sizeof(float);

  //initialize host vectors
  float* host_A = (float*)malloc(size);
  float* host_B = (float*)malloc(size);
  float* host_C = (float*)malloc(size);

  //define host vectors
  for(int i = 0; i < N; i = i + 1) {
    if (i % 2)
    {
      host_A[i] = 1;
      host_B[i] = 0;
    }
    else{
      host_A[i] = 0;
      host_B[i] = 1;
    }
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
  int threadsPerBlock = 1024;
  int blocksPerGrid = (N + threadsPerBlock -1) / threadsPerBlock;
  //device vector adder
  MatAdd<<<blocksPerGrid, threadsPerBlock>>>(device_A, device_B, device_C, N);
  //host vector adder for comparison
  //hostVecAdd(host_A, host_B, host_C, N);

  //copy results from device to host
  cudaMemcpy(host_C, device_C, size, cudaMemcpyDeviceToHost);
    for(int i = 0; i < N; i = i + 1) {
     //printf("C[%d] = %f \n", i,host_C[i]);
  }

  //free device memory
  cudaFree(device_A);
  cudaFree(device_B);
  cudaFree(device_C);
}