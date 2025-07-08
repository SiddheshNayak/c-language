#include <stdio.h>

char str[] = "Hello";

int main()
{
    int i = 0;
    while (str[i] != '\0')
    {
        printf("str[%d] : %c\n", i, str[i]);
        i++;
    }

    printf("Outside do-while\n");
    printf("str[%d] : %c\n", i, str[i]);
}