#include <assert.h>
int search(int i, int n, int a[], int v) {
  assert(n>0 && i<n && i >=0);
  int t = i;
  do {
    if ( t < n-1 ) t++;
    else t = 0;
  } while ( a[t] != v && t != i );
  return t;
}
