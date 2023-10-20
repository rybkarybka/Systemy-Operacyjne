/*
 * Send signal nie dziala tak jak kazano, ma z gory zdeficiowane jakies syngaly, ktore
 * wysyla do sendsignal.cpp
 * ostatni sygnal w tablicy zatrzyma nam obydwa programy
 */
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <csignal>
#include <string>
#include <unistd.h>

using namespace std;

int signum;

int main(){
  sleep(5);
  //trying to get pid of process to send signal to
  char line[6];
  FILE * command = popen("pidof catchsignal","r");
  fgets(line, 6, command);
  int pid = atoi(line);
	
  int tab[] = {2,4,6,8,11,14,15, 3};
  for(int i = 0; i <= 7; i++){
	signum = tab[i];
	printf("Sending signal nr: %i\n", signum);
	kill(pid, signum);
	sleep(1);
  }
  return 0;
}
