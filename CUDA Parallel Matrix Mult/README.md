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
nvcc matrixMult.cu -arch=sm_30 -o matrixMult -run
```
Al realizar la ejecución del comando obtenemos lo siguiente:
<img width="593" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/3e431832-7d4b-43f1-88c8-7f832e7ca866">
