#include <assert.h>
int search2(int q[], int n, int h, int t, int v) {
  assert(n>0 && h<n && t<n && h>=0 && t>=0);
  int w = t - h + 1;
  while ( h != t && q[t] != v) {
    if ( h < n-1 ) h++;
    else { h = 0; w = 1;}
  }
  while (x>=1)
    x=x-w;
  return q[h] == v;
}
