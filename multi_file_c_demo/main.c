#include <stdio.h>
#include "functions.h"

int main(void)
{
    int a, b;
    printf("Insert two numbers: \n");
    if(scanf("%d %d", &a, &b)!=2)
    {
        fputs("Invalid Input", stderr);
        return 1;
    }
    printf("%d + %d = %d \n", a, b, Sum(*&a,*&b));
}