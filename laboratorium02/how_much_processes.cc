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
	
	pid_t pid;
	long long int ctr = 0;
	while (1==1) {
	  pid = fork();

	  if (pid == 0) {
		sleep(1);
	  }
	  else if (pid > 0) {
		ctr++;
		printf("Ile procesow: %d\n", ctr);
	  }

	}
}
