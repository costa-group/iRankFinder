int McCarthy(int x){
  int c = 1;
  while (c > 0) {
    if (x > 100) {
      x -= 10;
      c--;
    } else {
      x += 11;
      c++;
    }
  }
  return x;
}
