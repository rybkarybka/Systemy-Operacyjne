#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

int main(){
	int dziadek = getpid();
	printf("Pid: %d\n", dziadek);
	getchar();

	// this is where the fun begins
	while (1==1) {
	  pid_t test;
	  test = fork();

	  printf("Pid: %d\n", getpid());
	}
}
