## Evaluación 2

Como primer intento de optimización de código, se intentó modificar las banderas -Ox, donde x varió entre 0 y 3, esto con el fin de encontrar la bandera más optima para ejecutar el código de manera más rápida.

(Todas las pruebas se realizaran con 4 hilos, ya que al ejecutar el código con una mayor o menor cantidad de hilos, estos presentaban tiempos de ejecución mas elevados)

Obteniendo los siguietes resultados:

### -O0
<img width="496" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/185e0052-3b33-4102-901d-18e4db95f933">

### -O1
<img width="503" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/d0abc286-820b-4816-9848-fb135fdc081d">

### -O2
<img width="497" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/24ff99f3-31db-4191-93c5-f2c7d9f07b31">

### -O3
<img width="505" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/b208f0fc-f1c4-470c-b8c9-3ecce100fed3">

A su vez se probó la siguiente bandera -Ofast la cual realiza una optimización agresiva para máximo rendimiento.

<img width="512" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/aedcc416-01b0-45ab-a59f-8e7ee8cf3e7c">

Observando los resultado nos damos cuenta que el optimizar el código con la badera -Ofast ayuda en gran parte a reducir el tiempo de ejecución.

Resultado usando el campo inicial que se encuentra en el archivo con : ```mpirun -np X ./heat_mpi botella.dat```
<img width="509" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/390b1940-8d08-4c93-b968-cdf0158fbb6b">

Dando el número de pasos de tiempo: ```mpirun -np 4 ./heat_mpi botella.dat z```
<img width="534" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/233c52b5-1208-4fe5-8c75-2236a5aae295">

Con el siguiente parametro, podemos observar que entre menos sea el número de pasos de tiempo menor será el tiempo de ejecución.

Patrón predeterminado con dimensiones y pasos de tiempo dados: ```mpirun -np 4 ./heat_mpi x y z```
<img width="520" alt="image" src="https://github.com/SC3UIS/IntroPP2191621/assets/67378380/124c8dec-55ff-43f2-bf7c-658c33c25ea3">


Se intentó optimizar el código core.c y main.c utilizando openmp ```#pragma omp parallel for``` 
![image](https://github.com/SC3UIS/IntroPP2191621/assets/67378380/9b44b3b1-67d0-4447-be14-9420518fa256)
pero a la hora de ejecutar presentaba los siguientes errores: 
![image](https://github.com/SC3UIS/IntroPP2191621/assets/67378380/a80d212e-c3ab-45a6-a818-b68524ce0a7c)






