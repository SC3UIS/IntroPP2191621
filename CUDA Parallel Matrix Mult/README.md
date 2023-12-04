# Parallelizing Matrix Multiplication using CUDA

## Code execution in GUANE

Once you are in GUANE you will run the next commands: 

```shell
srun -n 8 --pty /bin/bash
```
In this case we are using a machine with 8 nodes and the maximum GPU quantity available, but, in the case that you will need to require an especific number of GPUs we will use the next command: 
```shell
srun -n 8 --gres=gpu:2 --pty /bin/bash
```

In this specific case, we are going to use 2 GPUs

After that, we are going to load the CUDA module using the following command:
```shell
module load devtools/cuda/8.0
```

Before running the code, modifications were made to enable its execution on CUDA 8.0, as the code was originally written in CUDA 11.8.

To run the code, you will use the next command:
```shell
nvcc matrixMult.cu -arch=sm_30 -o matrixMult -run
```
When executing the command, we obtain the following:


<img width="593" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/3e431832-7d4b-43f1-88c8-7f832e7ca866">
