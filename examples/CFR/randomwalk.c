#include <assert.h>

int nondet();

int main(){
  int w, s, i, z, c;
  w=1; s=1; i=1; z = nondet(); assert(z >= 0);
  while ( 1 <= w && w <= 2 ) {
    c = nondet(); assert(0 <= c && c <= 1);
    if ( z >= 1 ) {
      z--;
    } else {
      if ( i <= 0 ) {
        s++; i = s; z = nondet(); assert(z >= 0);
      } else if ( i >= 1 && c <= 0 ) {
        i--;
      } else {
        break;
      }
    }
    if ( c <= 0 ) {
      w--;
    } else {
      w++;
    }
  }
  return 0; 
}
