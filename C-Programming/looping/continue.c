#include <stdio.h>

int main()
{
    int i = 10;
    while (i >= 0)
    {
        if (i == 5)
        {
            i--;
            printf("met condition\n");
            continue;
        }
        printf("i = %d\n", i);
        i--;
        
    }
}