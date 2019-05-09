void m(in sec, int met){
  int t,d,s;
  t=0;d=0;s=0;
  while(1==1){
    if(sec>0){
      s=0;
      if(t++==4) break;
    }
    if(met>0){
      if(s++==3) break;
      assert(d++ != 10);
    }
  }
}
