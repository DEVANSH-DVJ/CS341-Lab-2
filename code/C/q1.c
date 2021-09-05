#include <stdio.h>

int comb(int n, int r) {
  if (r == 0)
    return 1;

  if (n == r)
    return 1;

  int res1 = comb(n - 1, r - 1);
  int res2 = comb(n - 1, r);

  return res1 + res2;
}

int main() {
start:
  printf("Enter n: ");

  int n;
  scanf("%i", &n);

  printf("Enter r: ");

  int r;
  scanf("%i", &r);

  int res = comb(n, r);
  printf("%i", n);
  printf("C");
  printf("%i", r);
  printf(": ");
  printf("%i", res);
  printf("\n");

  printf("Wish to continue?: ");

  char c;
  scanf("%s", &c);

  printf("\n");

  if (c == 'Y')
    goto start;

  return 0;
}
