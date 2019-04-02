int gcd(int x, int y){
  assert(x>0 && y>0);
  while(x != y){
    if(x<y)
      y = y-x;
    else
      x = x-y;
  }
  return x;
}
