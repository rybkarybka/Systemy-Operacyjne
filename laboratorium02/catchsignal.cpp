#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <csignal>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

void signalHandler(int signum){
  printf("Received signal %i.\n",signum);
  /* exit(signum); */
}

int main(){
  signal(SIGINT, signalHandler);
  signal(SIGABRT,signalHandler);
  signal(SIGFPE, signalHandler);
  signal(SIGILL, signalHandler);
  signal(SIGSEGV, signalHandler);
  signal(SIGTERM, signalHandler);
  signal(SIGALRM, signalHandler);

  while(1) {
	printf("Sleeping ...\n");
	sleep(1);
  }
  return 0;
}
