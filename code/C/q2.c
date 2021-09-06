#include <stdio.h>

void inv(int a, int b, int *x, int *y) {
  if (a == 0) {
    *x = 0;
    *y = 1;
    return;
  }

  int x1, y1;
  inv(b % a, a, &x1, &y1);

  *x = y1 - (b / a) * x1;
  *y = x1;
  return;
}

int main() {
start:
  printf("Enter a: ");

  int a;
  scanf("%i", &a);

  printf("Enter m: ");

  int m;
  scanf("%i", &m);

  int x, y;
  inv(a, m, &x, &y);
  int res = (x % m + m) % m;

  printf("%i", a);
  printf("*");
  printf("%i", res);
  printf(" = 1 (mod ");
  printf("%i", m);
  printf(")\n");

  printf("Wish to continue?: ");

  char c;
  scanf("%s", &c);

  printf("\n");

  if (c == 'Y')
    goto start;

  return 0;
}
