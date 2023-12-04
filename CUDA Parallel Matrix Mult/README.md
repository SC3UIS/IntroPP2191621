# Parallelizing Matrix Multiplication using CUDA

El error "Invalid memory reference" (referencia de memoria no válida) en CUDA generalmente indica que hay un problema con el acceso a la memoria del dispositivo. En el código proporcionado, se utiliza cudaMallocManaged para asignar memoria unificada, lo que significa que la memoria es accesible tanto desde el host como desde el dispositivo. Sin embargo, estos errores pueden ocurrir si hay un problema en el acceso a la memoria.
    
    
