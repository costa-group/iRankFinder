#include "assert.h"

void m(){
  int x, y;
  x=0; y=0;
  while(1==1){
    if(x<= 50) y++;
    else y--;
    if(y<0) break;
    x++;
  }
  assert(x==102);
}
