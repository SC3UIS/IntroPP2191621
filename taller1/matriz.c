#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

int main()
{
    int i, j;
    int R1, C1;
    int R2, C2;

    printf("Ingresar el numero de R1: ");
    scanf("%d", &R1);
    printf("Ingresar el numero de C1: ");
    scanf("%d", &C1);
    printf("Ingresar el numero de R2: ");
    scanf("%d", &R2);
    printf("Ingresar el numero de C2: ");
    scanf("%d", &C2);
    printf("\n");
    int m1[R1][C1];
    int m2[R2][C2];

    // int m2[R2][C2];

    // if coloumn of m1 not equal to rows of m2

    if (C1 != R2)
    {
        printf("El numero de columnas de la matriz 1 debe ser igual al numero de files en la matriz 2");

        exit(EXIT_FAILURE);
    }

    // Fill with random number between 1 to 8 the m1
    for (i = 0; i < R1; i++)
    {
        for (j = 0; j < C1; j++)
        {
            m1[i][j] = (rand() % 8) + 1;
            m1[i][j] = (rand() % 8) + 1;
        }
    }

    // Fill with random number between 1 to 8 the m2
    for (i = 0; i < R2; i++)
    {
        for (j = 0; j < C2; j++)
        {
            m2[i][j] = (rand() % 8) + 1;
            m2[i][j] = (rand() % 8) + 1;
        }
    }

    // Show Matriz 1
    for (i = 0; i < R1; i++)
    {
        for (j = 0; j < C1; j++)
        {
            //printf("%d ", m1[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    // Show Matriz 2
    for (i = 0; i < R2; i++)
    {
        for (j = 0; j < C2; j++)
        {
            //printf("%d ", m2[i][j]);
        }
        printf("\n");
    }
    clock_t end = clock();

    void multiplyMatrix(int m1[][C1], int m2[][C2])
    {
        double time_spent = 0.0;
        clock_t begin = clock();
        int result[R1][C2];
        printf("\n");
        printf("El resultado de la multiplicación es:");
        printf("\n");
        for (int i = 0; i < R1; i++)
        {
            for (int j = 0; j < C2; j++)
            {
                result[i][j] = 0;

                for (int k = 0; k < R2; k++)
                {
                    result[i][j] += m1[i][k] * m2[k][j];
                }

                //printf("%d ", result[i][j]);
            }

            //printf("\n");
        }
        printf("\n");
        clock_t end = clock();
        time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
        printf("El tiempo que se demoro sin usar programación paralela en multiplicar dos matrices es de: %f seconds", time_spent);
        printf("\n");
    }

    void multiplyMatrixP(int m1[][C1], int m2[][C2])
    {
        printf("\n");
        double time_spent = 0.0;
        int result[R1][C2];
        clock_t begin = clock();
	    #pragma omp parallel for collapse(2)
        for (int i = 0; i < R1; i++)
        {
            for (int j = 0; j < C2; j++)
            {
                result[i][j] = 0;

                for (int k = 0; k < R2; k++)
                {
                    result[i][j] += m1[i][k] * m2[k][j];
                }

               // printf("%d ", result[i][j]);
            }

            // printf("\n");
        }
        clock_t end = clock();
        time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
        printf("El tiempo que se demoro usando paralela en multiplicar dos matrices es de: %f seconds", time_spent);
    }
    multiplyMatrix(m1, m2);
    multiplyMatrixP(m1, m2);

    return 0;
}
