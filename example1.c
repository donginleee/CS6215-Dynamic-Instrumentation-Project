#include <stdio.h>

void gemv(int* arr, int* vec, int* result)
{
    for(int i = 0; i < 4; i++)
    {
        result[0] += arr[4 * 0 + i] * vec[i]
    }

    for(int j = 0; j < 4; j++)
    {
        result[1] = arr[4 * 1 + j] * vec[j];
    }

    for(int k = 0; k < 4; k++)
    {
        result[2] = arr[4 * 2 + k] * vec[k];
    }

    for(int p = 0; p < 4; p++)
    {
        result[3] = arr[4 * 3 + p] * vec[p];
    }
}

int main(void)
{
    int mat1[16];
    int v1[4] = {1};
    int result[4] = {0}; 

    for(int i = 0; i < 4; i++)
        for(int j = 0; j < 4; j++)
        {
            mat1[4 * i + j] = 10 * i + j;
        }

   
    gemv(mat1, v1, result);

    for(int i = 0; i < 4; i++)
        printf("Result[%d] = %d", i, result[i]);

    

    return 0;
}