#include <cstdio>
#include <cstdlib>

using namespace std;

int main(){
  printf("Hello, I'm system program\n");
  getchar();
  system("ls -la /var/log/");
  return 0;
}
