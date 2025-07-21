#include <stdio.h>

int a = 10;

int foo() {
  /* Initialized only once */
  static char b = 0;
  /* Increamented with the retained value */
  b = b + 1;

  printf("Entering %s %d\n", __FUNCTION__, b);

  return 0;
}

int main(void) {
  a = a + 1;
  printf("%d\n", a);

  foo();
  foo();
  foo();
  return 0;
}