#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

int main(){
  //prints PID of this process
  int glownyPID = getpid();
  printf("PID: %i\n",glownyPID);
  getchar();

  //prints PID and PPID of new process
  pid_t pid;
  pid = fork();

  if (getppid() == glownyPID){
	printf("Child PID: %i\nParent PID: %i\n",getpid(), getppid());
  }
  getchar();
}
