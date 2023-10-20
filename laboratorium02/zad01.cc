#include <cstdlib>
#include <fstream>
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

// GLOBAL

// open file to write
/* ofstream f ("text"); */
 
// alloc statically
int const LENTGH = 5; // it has to be const if we want it here
  
// alloc dynamically
int *dynglob = (int*)malloc(sizeof(int));

int main(){
  // LOCAL

  // open file to write
  ofstream f ("text");
 
  // alloc statically
  int len = 5;
  
  // alloc dynamically
  int *dynloc = (int*)malloc(sizeof(int));
  *dynloc = 1;

  pid_t pid;
  // fork a child process
  pid = fork();

  printf("Child PID: %i\nParent PID: %i\n\n", getpid(), getppid());

  int r;
  if (pid < 0) { //error occurred
	fprintf(stderr,"Fork Failed");
	return 1;
  }
  else if (pid == 0) { //child process
	printf("Child scanf: \n");
	scanf("%i",&r);
	printf("Child scanf completed\n\n");
  }
  else { //parent process
	// parent will wait for the child to complete
	wait(NULL);
	printf("Child Complete\n");
	getchar();
  }
  return 0;
}
