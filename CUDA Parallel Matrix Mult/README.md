### Video explaining the solution:

[Video explicando la solución](https://youtu.be/3HMzu_yRq8k?si=3qh-UlRKpG7vXySA)

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


## Run Code In Yaje

We are going to run the code in YAJE and to request resource and get a connection with Yaje we are going to use the next commands:
```shell
srun -p Viz -n 2 --pty /bin/bash
```
Where 2 is the number of nodes that we are using.

and the we are going to load the modules:
```shell
module load devtools/cuda/8.0
```
and then to run the code we will use this:
```shell
nvcc matrixMult.cu -arch=sm_30 -o matrixMult -run
```

When executing the command, we obtain the following:
<img width="1068" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/2d080247-e0e5-433a-8998-a10bf91f7ed7">

