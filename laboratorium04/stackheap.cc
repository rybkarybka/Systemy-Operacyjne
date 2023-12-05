#include <cstdlib>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

void statyczna(){
  printf("Statyczne przypisywanie miejsca\n");
  double tab[1000000];
  getchar();
  printf("");
}

void dynamiczna() {
  printf("Dynamiczne przypisywanie miejsca\n");
  double *tab = new double[1000000]();
  getchar();
  free(tab);
  printf("Zwolniono dynamiczne przypisana pamiec");
}

int main() {
  statyczna();
  getchar();
  dynamiczna();
  getchar();
  return 0;
}
