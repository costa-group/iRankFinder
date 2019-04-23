int disjunctive(int x, int y){
  int z;
  if(x < y){
    assume(z <= 0);
    while(z <= 0) z++;
  }else if(x > y){
    assume(z >= 0);
    while(z >= 0) z--;
  }
  while( x != y ) x = x + z;
  return 0;
}
