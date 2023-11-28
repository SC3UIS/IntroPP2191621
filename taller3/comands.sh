

    #!/bin/bash
    #SBATCH --job-name CudaJob
    #SBATCH --nodes=4       #Numero de nodos para correr el trabajo
    #SBATCH --gres=gpu:2    #Define el número de GPU

    ##Load the CUDA module
    module load devtools/cuda/8.0

    ##
    nvcc -o add add_loop_cpu.cu
    nvcc -o gpu add_loop_gpu.cu
    nvcc -o long add_loop_long.cu

    srun cpu
    srun gpu
    srun long