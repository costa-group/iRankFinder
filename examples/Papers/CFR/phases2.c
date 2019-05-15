void phases2(int x, int y, int z){
  while(x>=0){
    x = x + y;
    y = y + z;
    z = z - 1;
  }
}
