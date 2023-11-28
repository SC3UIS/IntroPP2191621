# Explicación código

##Archivo add_loop_cpu.cu
Este código en C realiza la suma de dos arreglos a y b y almacena el resultado en un tercer arreglo c.\n
```c
void add( int *a, int *b, int *c ) {
    int tid = 0;
    while (tid < N) {
        c[tid] = a[tid] + b[tid];
        tid += 1;
    }
}
```
Se define una función llamada add que toma tres punteros a enteros (a, b, y c). Esta función realiza la suma de los elementos correspondientes de los arreglos a y b y almacena el resultado en el arreglo c. La variable tid se utiliza como un identificador de hilo (thread identifier) y se incrementa en cada iteración del bucle while.
```c
int main( void ) {
    // Declaración de arreglos
    int a[N], b[N], c[N];

    // Llenado de los arreglos 'a' y 'b' en la CPU
    for (int i=0; i<N; i++) {
        a[i] = -i;
        b[i] = i * i;
    }
```
Se declaran tres arreglos de enteros (a, b, y c) con tamaño N y se llenan los arreglos a y b con valores específicos.
```c
add( a, b, c );
```
Se ejecuta la función add para realizar la correspondiente suma de vectores y se procede a imprimir el resultado.
```c
    for (int i=0; i<N; i++) {
        printf( "%d + %d = %d\n", a[i], b[i], c[i] );
    }
```

## Explicación código add_long_gpu.cu
El código en Cuda C realiza la suma de dos arreglos a y b en paralelo en una GPU utilizando CUDA.
```c
__global__ void add( int *a, int *b, int *c ) {
    int tid = blockIdx.x;    // este hilo maneja los datos en su id de hilo
    if (tid < N)
        c[tid] = a[tid] + b[tid];
}
```
Se define una función kernel llamada add, que se ejecutará en paralelo en la GPU. Cada hilo (thread) de la GPU se encarga de un elemento del arreglo, y la variable blockIdx.x proporciona el índice del bloque que ejecuta el kernel.
```c
    // Se hace la declaración de los arreglos
    int a[N], b[N], c[N];
    // Declaración de punteros para los arreglos en (GPU)
    int *dev_a, *dev_b, *dev_c;
```
Se asigna espacio en memoria para la GPU
```c
    // Asignación de memoria en la GPU
    HANDLE_ERROR( cudaMalloc( (void**)&dev_a, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_b, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_c, N * sizeof(int) ) );
```
A continuación se realiza el respectivo llenado de los arreglos en la cpu, seguido de esto se realizará la copia de los arreglos presentes en la CPU a la memoria de la GPU
```c
    // Llenado de los arreglos 'a' y 'b' en (CPU)
    for (int i=0; i<N; i++) {
        a[i] = -i;
        b[i] = i * i;
    }

    // Copia de los arreglos 'a' y 'b' desde el host a la GPU
    HANDLE_ERROR( cudaMemcpy( dev_a, a, N * sizeof(int),
                              cudaMemcpyHostToDevice ) );
    HANDLE_ERROR( cudaMemcpy( dev_b, b, N * sizeof(int),
                              cudaMemcpyHostToDevice ) );
```
```c
  // Llamada al kernel 'add' con N bloques y 1 hilo por bloque
    add<<<N,1>>>( dev_a, dev_b, dev_c );
```
Se llama al kernel 'add' utilizando la sintaxis <<<N,1>>>, indicando que se deben utilizar N bloques y 1 hilo por bloque.
```c
    // Copia del arreglo 'c' desde la GPU al host
    HANDLE_ERROR( cudaMemcpy( c, dev_c, N * sizeof(int),
                              cudaMemcpyDeviceToHost ) );
```
El resultado de la ejecución de la paralelización se copia de la GPU a la CPU y se imprime en pantalla:
```c
    // Mostrar los resultados
    for (int i=0; i<N; i++) {
        printf( "%d + %d = %d\n", a[i], b[i], c[i] );
    }
```

## Explicación archivo add_loop_long.cu
