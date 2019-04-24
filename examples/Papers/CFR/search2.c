#include <assert.h>
int search(int h, int t, int n, int a[], int v) {
  assert(n>0 && h<n && t<n && h>=0 && t>=0);
  while ( h != t && a[t] != v) {
    if ( t < n-1 ) t++;
    else t = 0;
  }
  return t;
}
