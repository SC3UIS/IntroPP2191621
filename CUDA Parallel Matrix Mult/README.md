# Parallelizing Matrix Multiplication using CUDA

## Ejecución de código en GUANE

Una vez ingresado a GUANE correremos el siguiente comando:

```shell
srun -n 8 --pty /bin/bash
```
En este caso estaremos usando una maquina que tiene 8 nodos con la máxima cantidad de GPUs disponibles, pero en dado caso que vayamos a requerir un numero específico de GPUs usamos el siguiente comando:
```shell
srun -n 8 --gres=gpu:2 --pty /bin/bash
```

Donde en este caso estamos solicitando el uso de 2 GPUs.

Antes de realizar el código se realizaron una modificaciónes para poder ejecutarlo en CUDA 8.0 ya que el código se escribió en CUDA 11.8

Para ejecutar ejecutamos el siguiente comando
```shell
nvcc matrixMult.cu -arch=sm_70 -o matrixMult -run
```

El error "Invalid memory reference" (referencia de memoria no válida) en CUDA generalmente indica que hay un problema con el acceso a la memoria del dispositivo. En el código proporcionado, se utiliza cudaMallocManaged para asignar memoria unificada, lo que significa que la memoria es accesible tanto desde el host como desde el dispositivo. Sin embargo, estos errores pueden ocurrir si hay un problema en el acceso a la memoria.
    
    
