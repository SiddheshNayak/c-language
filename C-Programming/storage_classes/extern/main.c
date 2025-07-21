#include <stdio.h>

/* This tells the compiler not to allocate memory for 'a' here,
   but to search for it in another file (external linkage) */
extern int a;

extern int foo();

int main(void)
{
    a = a + 1;
    printf("%d\n", a);

    foo();
    return 0;
}