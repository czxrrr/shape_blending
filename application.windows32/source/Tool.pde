class Tool{
  
  //this tool includes 3 drawing methods 
  //and calculate angle method and adjust angle method
   void draw_graph(int n, float x[], float y[]){
    fill(0);  
    int i=0; 
    if(n==5){
      for(i=0;i<n-1;i++){
      line(x[i], y[i], x[i+1],y[i+1]);
      }
      line(x[0], y[0], x[4],y[4]);
    }
    else{
      for(i=0;i<n-1;i++){
        line(x[i], y[i], x[i+1],y[i+1]);
      }
    }
  }

  void draw_graph_angle(int n,float x,float y,float len[], float angle[]){
    fill(0);  
    int i=0; 
    if(n>=2){
      float q=angle[0];
      //println(q);
      line(x,y,x+len[0]*cos(q),y+len[0]*sin(q));
      x=x+len[0]*cos(q);
      y=y+len[0]*sin(q);
      for(i=1;i<=n-2;i++){
        q-=angle[i];
        line(x,y,x+len[i]*cos(q),y+len[i]*sin(q));
        x=x+len[i]*cos(q);
        y=y+len[i]*sin(q);
      }
      if(n==5){
        q-=angle[4];
        line(x,y,x+len[4]*cos(q),y+len[4]*sin(q));
      }
    }   
  }
  
  void draw_graph_angle2(int n,float x,float y,float len[], float angle[]){
    fill(0);  
    int i=0; 
    float q;
    if(n>=2){
      for(i=0;i<n;i++){
      q=angle[i];
      line(x,y,x+len[i]*cos(q),y+len[i]*sin(q));
      x=x+len[i]*cos(q);
      y=y+len[i]*sin(q);
      }
    }   
  }
  
  
  float calc_angle(int label,float a,float b,float c,float d,float e,float f){
      float aa,bb,cc,cos_angle,angle;
      aa=(float)Math.sqrt(Math.pow(a-c,2)+Math.pow(b-d,2));
      bb=(float)Math.sqrt(Math.pow(e-c,2)+Math.pow(f-d,2));
      cc=(float)Math.sqrt(Math.pow(a-e,2)+Math.pow(b-f,2));
      cos_angle=(aa*aa+bb*bb-cc*cc)/(2*aa*bb);
      angle=(float)Math.acos(cos_angle);
      float sign=(a-c)*(f-d)-(e-c)*(b-d);
      if(sign>=0) {angle=0+angle;}
      else{
         angle=-angle;
      }
      if(label==1){
        return (float)Math.PI-angle;
      }
      else{
        return angle;
      }
  }
  float adjust(float input){
    while(input>2*Math.PI){
      input=input-(float)(2*Math.PI);
    }
    while(input<0){
      input=input+(float)(2*Math.PI);
    }
    
    return input;
  }

}