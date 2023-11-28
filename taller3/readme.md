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
Se define una función llamada add que toma tres punteros a enteros (a, b, y c). Esta función realiza la suma de los elementos correspondientes de los arreglos a y b y almacena el resultado en el arreglo c.
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
