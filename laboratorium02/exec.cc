#include <iostream>
#include <cstdio>
#include <unistd.h>

using namespace std;

int main(){
  printf("Hello, I'm exec program");
  getchar();

  execvp("/home/linas/agieh/3sem/sysopy/laby/laboratorium02/another",NULL);

  return 0;
}
