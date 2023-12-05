#include <stdio.h>
#include <stdlib.h>


// Function to free the memory allocated for the array
void freeArray(int*** array) {
  // Free memory for each 2D array and then for the array of pointers
  for (int i = 0; i < 1000; ++i) {
	for (int j = 0; j < 3; ++j) {
	  free(array[i][j]);
	}
	free(array[i]);
  }

  // Free memory for the array of pointers
  free(array);
}

int main() {

  printf("Before allocating array\n");
  getchar();

  int size = 1000;

  // create array
  int*** array = (int***)malloc(size * sizeof(int**));

  printf("After allocating array\n");
  getchar();

  // Initialize each pointer with a 2D array
  for (int i = 0; i < size; ++i) {
	array[i] = (int**)malloc(size * sizeof(int*)); 

	for (int j = 0; j < size; ++j) {
	  array[i][j] = (int*)malloc(size * sizeof(int));
	}
  }

  printf("After allocating each element in array\n");
  getchar();


  // Free the allocated memory
  freeArray(array);

  printf("After freeing space from this array");
  getchar();

  return 0;
}

