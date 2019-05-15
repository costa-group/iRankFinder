#include <assert.h>

int nondet();

int randomwalk(int n) {
  int w=1, i=1, z=n, c=0;
  while ( 1 <= w && w <= 2 ) {
    c=nondet(); assert(0 <= c && c <= 1);
    if ( z >= 1 ) z--;
    else if ( i <= 0 ) { i=2; z=n; }
    else if ( i >= 1 && c <= 0 ) i--;
    else break;
    if ( c <= 0 ) w--; else  w++;
  }
  return 0; 
}
