#include <assert.h>
int search(int q[], int n, int h, int t, int v) {
  assert(n>0 && h<n && t<n && h>=0 && t>=0);
  while ( h != t && q[t] != v) {
    if ( h < n-1 ) h++;
    else h = 0;
  }
  return h;
}
