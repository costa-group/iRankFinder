int phases1(int x, int y, int z){
  while( x > 0 ){
    if ( y < z )
      y = y + 1;
    else
      x = x - 1;
  }
  return 0;
}
