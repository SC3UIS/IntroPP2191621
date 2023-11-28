#include <stdio.h>
#include <time.h>
#include "./book.h"

#define N   10
#define NUM_RUNS 100000

void add( int *a, int *b, int *c ) {
    int tid = 0;    // this is CPU zero, so we start at zero
    while (tid < N) {
        c[tid] = a[tid] + b[tid];
        tid += 1;   // we have one CPU, so we increment by one
    }
}

int main( void ) {
    int a[N], b[N], c[N];

    // fill the arrays 'a' and 'b' on the CPU
    for (int i=0; i<N; i++) {
        a[i] = -i;
        b[i] = i * i;
    }

    double total_time = 0.0;

    //For con el fin de iterar la función add y obtener un promedio de tiempos de ejecución
    for (int run = 0; run < NUM_RUNS; run++) {
        clock_t start_time = clock(); // Get the start time

        add( a, b, c );

        clock_t end_time = clock(); // Get the end time

        // Calculate and accumulate the elapsed time
        double elapsed_time = ((double)(end_time - start_time)) / (CLOCKS_PER_SEC/1000);
        total_time += elapsed_time;
    }

    // display the results
    for (int i=0; i<N; i++) {
        printf( "%d + %d = %d\n", a[i], b[i], c[i] );
    }

    // Calculate and print the average elapsed time
    double average_time = total_time / NUM_RUNS;
    printf("Tiempo de ejecución promedio: %fms\n", average_time);

    return 0;
}