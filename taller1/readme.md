## Como inicializar el código
1.  Descargar el repositorio usando: 
``` git clone  https://github.com/Harvey1419/IntroPP2191621.git```
3.	 Dirigirse a la carpeta de taller1: 
``` cd taller1```
4. Compilar código C:
``` gcc -fopenmp matriz.c -o matriz```
br
Nota: Si estás en macOS con Apple Silicon M1 y arquitectura ARM_64 debes utilizar el siguiente comando:
```gcc-13 -fopenmp matriz.c -o matriz```
6. Para abrir el archivo compilado debes abrirlo de la siguiente manera: 
```./matriz```

#### Al inicializar el código, podrás escribir las filas y columnas de ambas matrices, con el fin de poder realizar pruebas con matrices cuadradas y no cuadradas, también del tamaño deseado.

<img width="1512" alt="image" src="https://github.com/Harvey1419/IntroPP2191621/assets/67378380/ed6cde96-7d57-4268-a788-479c8ecdb055">
<img width="1078" alt="image" src="https://github.com/Harvey1419/IntroPP2191621/assets/67378380/e3fc2692-fa01-4cf2-b566-57c43b3f1ca0">


##Pseudo Código algoritmo
```ruby
Para i desde 0 hasta R1 exclusivo, incrementando en 1:
    Para j desde 0 hasta C2 exclusivo, incrementando en 1:
        result[i][j] = 0
        
        Para k desde 0 hasta R2 exclusivo, incrementando en 1:
            result[i][j] += m1[i][k] * m2[k][j]
        
        Imprimir result[i][j] seguido de un espacio en blanco
        
    Imprimir una nueva línea
    
Fin del bucle exterior
```
## Análisis de algoritmo
Multiplicación dos matrices `m1` y `m2` y almacena el resultado en la matriz `result`:

1.  **Bucles Anidados**: El algoritmo utiliza tres bucles anidados. El bucle más externo itera sobre las filas de la matriz `result` (índice `i`), el segundo bucle itera sobre las columnas de la matriz `result` (índice `j`), y el tercer bucle itera sobre las columnas de `m1` y las filas de `m2` (índice `k`).
    
2.  **Inicialización de Resultados**: Antes de realizar las multiplicaciones y sumas, el algoritmo inicializa cada elemento de la matriz `result` en 0. Esto asegura que no haya valores previos en la matriz `result` que puedan afectar los cálculos.
    
3.  **Producto de Matrices**: El bucle más interno realiza la multiplicación de elementos de las matrices `m1` y `m2` y acumula el resultado en `result[i][j]`. Esto se hace para cada combinación de `i`, `j` y `k`, lo que resulta en la multiplicación de matrices completa.
    
4.  **Impresión de Resultados**: Después de calcular cada elemento de `result`, se imprime el valor seguido de un espacio en blanco. Esto se hace para cada elemento de la matriz `result`, y luego se imprime una nueva línea para separar las filas en la salida.
    
5.  **Complejidad Temporal**: La complejidad temporal de este algoritmo es O(R1 * C2 * R2), donde R1 es el número de filas de `m1`, C2 es el número de columnas de `m2`, y R2 es el número de filas de `m2`. Esto significa que el tiempo de ejecución aumenta significativamente con el tamaño de las matrices de entrada.
    

En resumen, este algoritmo es una implementación básica de la multiplicación de matrices utilizando tres bucles anidados. Es eficiente en términos de tiempo si las matrices no son demasiado grandes, pero su tiempo de ejecución puede crecer rápidamente para matrices grandes debido a su complejidad temporal.

## Comparación de tiempos de ejecución
En esta primera tanta de comparaciones podemos observar que nuestro algoritmo se ejecuta de manera más rápida en ejecución normal que una ejecución en paralelo.
![image](https://github.com/Harvey1419/IntroPP2191621/assets/67378380/b7d416d1-36ea-4bce-95c3-ab46a1b3466c)
A medida que crece el número de iteraciones, el tiempo de ejecución se va acercando.
![image](https://github.com/Harvey1419/IntroPP2191621/assets/67378380/9bb568b9-d27d-471a-b049-9f0b72847bab)

Aunque si seguimos aumentando la cantidad, volveremos a un punto igual a nuestras primeras pruebas, y entre más grande, más optimo será nuestro algoritmo sin paralelismo.
![image](https://github.com/Harvey1419/IntroPP2191621/assets/67378380/a9639644-9789-4fc8-bc88-c8a9df13479e)
