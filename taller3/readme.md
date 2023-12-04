# Explicación código

## Archivo add_loop_cpu.cu

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
De la siguiente ejecución podemos concluir:
El kernel add se ejecuta simultáneamente en múltiples hilos en la GPU para mejorar el rendimiento en comparación con la versión secuencial del primer código. También se incluyen funciones de CUDA para gestionar la memoria en la GPU y para la transferencia de datos entre la CPU y GPU.

## Explicación archivo add_loop_long.cu
En este archivo podemos observa que la definición de la variable N es cosiderablemente mayor a la de los otros dos archivos visto.
```c
#define N (32 * 1024)
```
A su vez, podemos notar que en este código, se le asigna a los arreglos, espacio en memorio de la CPU, como espacio en memoria de la GPU
```c
    // allocate the memory on the CPU
    a = (int*)malloc( N * sizeof(int) );
    b = (int*)malloc( N * sizeof(int) );
    c = (int*)malloc( N * sizeof(int) );

    // allocate the memory on the GPU
    HANDLE_ERROR( cudaMalloc( (void**)&dev_a, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_b, N * sizeof(int) ) );
    HANDLE_ERROR( cudaMalloc( (void**)&dev_c, N * sizeof(int) ) );
```
La ejecución de la función Kernel de CUDA, cambia en valores con respecto a los anteriores siendo de 128 bloques y 1 hilo por bloque.
```c
 add<<<128,1>>>( dev_a, dev_b, dev_c );
```
a continuación se presentara un bucle el cual estará diseñado para validar si la operación que delegamos a la GPU fue realizada correctamente
```c
 // verificar que la GPU hizo el trabajo que solicitamos
    bool success = true;
    for (int i=0; i<N; i++) {
        if ((a[i] + b[i]) != c[i]) {
            printf( "Error:  %d + %d != %d\n", a[i], b[i], c[i] );
            success = false;
        }
    }
    if (success)    printf( "We did it!\n" );
```
El bucle itera sobre los resultados obtenidos en el arreglo c después de la operación en la GPU y los compara con los resultados que se habrían obtenido si la operación se hubiera realizado en la CPU (la suma de los elementos correspondientes de a y b).\n
Una vez terminado el proceso se libera la memoria.

## Como Compilar el código
Para compilar el código de manera pasiva debemos seguir los siguientes comandos:
```git
git clone https://github.com/SC3UIS/IntroPP2191621.git
```
Seguido de este comando debemos ir a la carpeta donde estáran almacenados nuestro archivos.
```shell
cd Taller3
```
Para ejecutar el código de manera pasiva, ejecutaremos el siguiente comando:
```shell
sbatch commands.sh
```
Dicho comando mencionada, creará un job el cual compilará y ejecutará los archivos, al finalizar la ejecución de todos los archivos, las respuestas de estos quedaran almacenadas en un archivo .out el cual podremos visualizar de la siguiente manera:
```shell
vi slurm-idjob.out
```
donde "idjob" es el id del job que se generó al ejecutar el sbatch.\n
La ejecución de ese comando nos da como resultado lo siguiente:
<img width="621" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/a2c0c50e-87ae-45c0-a788-10a1bb790c86">
Gracias a esto podemos observar la gran diferencia que hay cuando se hace uso de la paralelización en GPU y en como esta ayuda a mejorar considerablemente los tiempos de ejecución de archivos en los cuales se tenga que hacer una gran cantidad de iteaciones.

## Ejecutar código de manera activa
Para ejecutar el código de manera activa solo tendremos que realizar lo siguiente:
```git
git clone https://github.com/SC3UIS/IntroPP2191621.git
```
Seguido de este comando debemos ir a la carpeta donde estáran almacenados nuestro archivos.
```shell
cd Taller3
```
Por cada archivo que tengamos en nuestro directorio, ejecutaremos el siguiente comando:
```shell
nvcc tu_archivo.cu -o tu_ejecutale
```
donde "tu_archivo.cu" es el archivo que deseas compilar
Y para ejecutar el archivo solo tendremos que llamar al ejecutable que creamos:
```shell
./tu_ejecutable
```
<img width="1512" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/683b37fe-f477-4afe-b7b5-6d5e4ee5854e">

