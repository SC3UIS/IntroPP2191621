#include "./book.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define N   (32 * 1024)

__global__ void add( int *a, int *b, int *c ) {
    int tid = blockIdx.x;
    while (tid < N) {
        c[tid] = a[tid] + b[tid];
        tid += gridDim.x;
    }
}

int main( void ) {
    int *a, *b, *c;
    int *dev_a, *dev_b, *dev_c;
    
    clock_t start, end; // sirve para medir el tiempo de ejecución total (GPU y CPU)
    cudaEvent_t start_c, end_c; // sirve para medir el tiempo de ejecución paralela (GPU)
    start = clock();
    // allocate the memory on the CPU
    a = (int*)malloc( N * sizeof(int) );
    b = (int*)malloc( N * sizeof(int) );
    c = (int*)malloc( N * sizeof(int) );

    // allocate the memory on the GPU
    HANDLE_ERROR( cudaMalloc( (void**)&dev_a, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_b, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_c, N * sizeof(int) ) );

    // fill the arrays 'a' and 'b' on the CPU
    for (int i=0; i<N; i++) {
        a[i] = i;
        b[i] = 2 * i;
    }

    // copy the arrays 'a' and 'b' to the GPU
    HANDLE_ERROR( cudaMemcpy( dev_a, a, N * sizeof(int),
                              cudaMemcpyHostToDevice ) );
    HANDLE_ERROR( cudaMemcpy( dev_b, b, N * sizeof(int),
                              cudaMemcpyHostToDevice ) );

    add<<<128,1>>>( dev_a, dev_b, dev_c );

    // copy the array 'c' back from the GPU to the CPU
    HANDLE_ERROR( cudaMemcpy( c, dev_c, N * sizeof(int),
                              cudaMemcpyDeviceToHost ) );

    // Sirve para medir tiempo de ejecución paralelo
    cudaEventCreate(&start_c);
    cudaEventCreate(&end_c);
    cudaEventRecord(start_c, 0);                           

    // verify that the GPU did the work we requested
    bool success = true;
    for (int i=0; i<N; i++) {
        if ((a[i] + b[i]) != c[i]) {
            printf( "Error:  %d + %d != %d\n", a[i], b[i], c[i] );
            success = false;
        }
    }
    if (success)    printf( "We did it!\n" );

    // Detiene el tiempo de ejecución de la GPU
    cudaEventRecord(end_c, 0);
    cudaEventSynchronize(end_c);

    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start_c, end_c);

    end = clock();
    double cpu_time_used = ((double) (end-start)) / CLOCKS_PER_SEC;
    printf("Total CPU time used: %f seconds \n", cpu_time_used);
    printf("Total GPU time used: %f ms \n", elapsedTime);

    // free the memory we allocated on the GPU
    HANDLE_ERROR( cudaFree( dev_a ) );
    HANDLE_ERROR( cudaFree( dev_b ) );
    HANDLE_ERROR( cudaFree( dev_c ) );

    // free the memory we allocated on the CPU
    free( a );
    free( b );
    free( c );

    return 0;
}

