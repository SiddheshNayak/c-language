
int main(void) {
  int x = 11;
  /* This tells the compiler to try to allocate variable as a CPU register.
   * Scope - local (within the block)
   */
  register int a = 10;
  a = a + 1;
  x = x + 1;

  return a;
}