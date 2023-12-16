#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  // check args
  if (argc != 4) {
	printf("Nieprawidłowa liczba argumentów, sprobuj:\n./kopiuj N FILE FILE");
	return -1;
  }

  int buffer = atoi(argv[1]);
  char temp[buffer];
  
  // open read file
  FILE *fr;
  fr = fopen(argv[2], "r");
  if (fr == NULL) {
	printf("Failed to open file %s", argv[2]);
	return -1;
  }

  // open write file 
  FILE *fw;
  fw = fopen(argv[3], "w");
  if (fw == NULL) {
	printf("Failed to open file %s", argv[3]);
  }

  // save content to temp array and write it back to other file
  while( fgets(temp, buffer, fr) != NULL ) {
	fwrite(temp, sizeof(char), buffer-1, fw);
  }

  fclose(fr);
  fclose(fw);


  return 0;
}
