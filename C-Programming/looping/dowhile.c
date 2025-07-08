#include <stdio.h>

#define MAX_COUNT 5

int main()
{
    int count = MAX_COUNT;

    do
    {
        if (count == MAX_COUNT)
        {
            printf("Inside do-while\n");
        }
        
        printf("count : %d\n", count);
        count--;
    } while (count != 2);

    printf("Outside do-while\n");
    printf("count : %d\n", count);
}