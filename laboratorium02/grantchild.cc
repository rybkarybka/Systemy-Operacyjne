#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

int main(){
	//prints PID of THIS process 
	int dziadek = getpid();
	printf("Pid: %d\n", dziadek);
	getchar();

	//prints PID and PPID of 2nd proceess
	pid_t grandchild;
	grandchild = fork();
	int ojciec = 0;
	if(getpid() != dziadek){
	  ojciec = getpid();
	  printf("2nd PID: %d\nParent: PID: %d\n\n", getpid(),getppid());
	}
	getchar();	
	
	// last child
	pid_t anotherchild;
	anotherchild = fork();
	if(ojciec && getpid() != ojciec){
	  printf("3rd PID: %d\nParent PID: %d\n\n", getpid(), getppid());
	}
	getchar();
}
