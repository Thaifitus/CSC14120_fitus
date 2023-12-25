#ifndef USE_CUDA

#include "filter.h"

#define CHECK(call)                                          \
  {                                                          \
    const cudaError_t error = call;                          \
    if (error != cudaSuccess)                                \
    {                                                        \
      fprintf(stderr, "Error: %s:%d, ", __FILE__, __LINE__); \
      fprintf(stderr, "code: %d, reason: %s\n", error,       \
              cudaGetErrorString(error));                    \
      exit(EXIT_FAILURE);                                    \
    }                                                        \
  }

__global__ void filter1(float *d_in, int channel_in, int height_in, int width_in,
                        float *d_out,
                        float *filter, int filterWidth, int n)
{
  // Check images input
  // int d_i = 0;
  // for (int col = 0; col < n; ++col)
  // {
  //   for (int row = 0; row < channel_in * height_in * width_in; ++row)
  //   {
  //     printf("%f ", d_in[d_i++]);
  //   }
  //   printf("\n");
  // }


  return;
}

int invoke_kernel(const float *h_in, int channel_in, int height_in, int width_in,
                  float *&h_out, int height_out, int width_out, int channel_out,
                  int n_sample, int filter_type,
                  float *filter, int filterWidth, int stride, int pad_w, int pad_h)
{
  // TODO: Allocate device memories
  float *d_in, *d_out, *d_filter;
  size_t nBytes_d_in = height_in * width_in * channel_in * n_sample * sizeof(float);
  size_t nBytes_d_out = height_out * width_out * channel_out * n_sample * sizeof(float);
  size_t nBytes_d_filter = channel_in * filterWidth * filterWidth * channel_out * sizeof(float);

  CHECK(cudaMalloc((void **)&d_in, nBytes_d_in));
  CHECK(cudaMalloc((void **)&d_out, nBytes_d_out));
  CHECK(cudaMalloc((void **)&d_filter, nBytes_d_filter));

  // TODO: Copy data to device memories
  CHECK(cudaMemcpy(d_in, h_in, nBytes_d_in, cudaMemcpyHostToDevice));
  CHECK(cudaMemcpy(d_filter, filter, nBytes_d_filter, cudaMemcpyHostToDevice));

  // TODO: Set grid size and call kernel
  dim3 gridSize(1);
  dim3 blockSize(32);
  if (filter_type == 1)
  {
    filter1<<<gridSize, blockSize>>>(d_in, channel_in, height_in, width_in,
                                     d_out,
                                     d_filter, filterWidth, n_sample);
    // Checks for synchronous errors
    cudaError_t errSync = cudaGetLastError();
    if (errSync != cudaSuccess)
      printf("Sync kernel error: %s\n", cudaGetErrorString(errSync));
  }

  // TODO: Copy result from device memory
  // CHECK(cudaMemcpy(h_out, d_out, nBytes_d_out, cudaMemcpyDeviceToHost));

  // TODO: Free device memories
  CHECK(cudaFree(d_in));
  CHECK(cudaFree(d_out));
  CHECK(cudaFree(d_filter));

  // cudaDeviceReset(); // Force to print

  // return filter type
  return 0;
}

#endif