#include <stdio.h>

int main(void) {
    
  /* Scope - local (within the block) */
  {
    auto int a = 10;
  }
  /* This will throw compilation error as the variable is local to the above
   * block */
  printf("%d\n", a);

  return 0;
}