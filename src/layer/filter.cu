#include "filter.h"

__global__ void helloFromGPU()
{
    printf("Hello from GPU, threadId %d!\n", threadIdx.x);
    printf("Goodbye from GPU, threadId %d!\n", threadIdx.x);
}

void invoke_kernel()
{
  helloFromGPU<<<1, 64>>>(); // 1 group of 64 threads do this function in parallel
  cudaDeviceReset(); // Force to print
}