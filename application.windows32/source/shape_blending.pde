/**
  by zherui cao
  homework for computer animation
 **/

float[] startx = new float[5];
float[] starty = new float[5];
float[] endx = new float[5];
float[] endy = new float[5];
float[] tempx = new float[5];
float[] tempy = new float[5];
float[] temp_len = new float[5];
float[] temp_angle = new float[5];
float[] start_angle =new float[5];
float[] end_angle =new float[5];
float[] start_len= new float[5];
float[] end_len = new float[5];
float[] s= new float[5];
float[] Lab= new float[5];
float[] alpha= new float[5];
float[] theta= new float[5];
String[] lines;
Tool tool=new Tool();
int n,m;
int move=0;
int timeline=0;

void setup() {
  size(840, 560);
  background(255);
  frameRate(500);
  fill(0);
  n=0; m=0;
  timeline=0;
  lines = loadStrings("in.txt");
  startx = float(split(lines[0], ','));
  starty = float(split(lines[1], ','));
  endx = float(split(lines[2], ','));
  endy = float(split(lines[3], ','));
  int n;
  //inport the data
  for(n=0;n<5;n++){
    if(n>=1){
      if(n==1)start_angle[0]=tool.calc_angle(0,startx[0]+1,starty[0],startx[0],starty[0],startx[1],starty[1]);
      else if(n>=2)start_angle[n-1]=tool.calc_angle(1,startx[n-2],starty[n-2],startx[n-1],starty[n-1],startx[n],starty[n]);
      start_len[n-1]=(float)Math.sqrt(Math.pow(startx[n]-startx[n-1],2)+Math.pow(starty[n]-starty[n-1],2));
      if(n==4){
        start_angle[4]=tool.calc_angle(1,startx[3],starty[3],startx[4],starty[4],startx[0],starty[0]);
        start_len[4]=(float)Math.sqrt(Math.pow(startx[4]-startx[0],2)+Math.pow(starty[4]-starty[0],2));
      }
    }
    m=n;
    if(m>=1){
      if(m==1) end_angle[0]=tool.calc_angle(0,endx[0]+1,endy[0],endx[0],endy[0],endx[1],endy[1]);
      else if(m>=2)end_angle[m-1]=tool.calc_angle(1,endx[m-2],endy[m-2],endx[m-1],endy[m-1],endx[m],endy[m]);
      end_len[m-1]=(float)Math.sqrt(Math.pow(endx[m]-endx[m-1],2)+Math.pow(endy[m]-endy[m-1],2));
      if(m==4){
        end_angle[4]=tool.calc_angle(1,endx[3],endy[3],endx[4],endy[4],endx[0],endy[0]);
        end_len[4]=(float)Math.sqrt(Math.pow(endx[4]-endx[0],2)+Math.pow(endy[4]-endy[0],2));
      }
    }
    //calculate the length of each edge, and the angle
  }
    move=1;
    int i;
    float s,e,dif;
    for(i=0;i<5;i++){
      s=tool.adjust(start_angle[i]);
      e=tool.adjust(end_angle[i]);
      dif=e-s;
      while(dif>Math.PI) dif-=2*Math.PI;
      while(dif<-Math.PI) dif+=2*Math.PI;
      e=s+dif;
      end_angle[i]=e;
      start_angle[i]=s;
      //even the rotation of every line is limited to -180 to 180
      //but the rotation is concerned with the rotation of last line.
    }
     
} 

float debug(float a){
  a=a*180/(float)Math.PI;
  return a;
}



void interpolation(int t, int type){
  int i;
  for(i=0;i<5;i++){
      tempx[i]=startx[i]+t*(endx[i]-startx[i])/1000.0;
      tempy[i]=starty[i]+t*(endy[i]-starty[i])/1000.0;
  }
  if(type==0){
    tool.draw_graph(5,tempx,tempy);
  }
  else if (type==1){
    for(i=0;i<5;i++){
      temp_len[i]=start_len[i]+t*(end_len[i]-start_len[i])/1000.0;
      temp_angle[i]=start_angle[i]+t*(end_angle[i]-start_angle[i])/1000.0;
    }
    tool.draw_graph_angle(5,tempx[0],tempy[0],temp_len,temp_angle);
  }
  else if(type==2){ 
    calc_Lab();
    calc_lambda(t);
    //in this occasion, we should add s to make sure the figure is closed.
    for(i=0;i<5;i++){     
      temp_len[i]=(start_len[i]+t*(end_len[i]-start_len[i])/1000.0)+s[i];
      temp_angle[i]=start_angle[i]+t*(end_angle[i]-start_angle[i])/1000.0;
    }
    tool.draw_graph_angle2(5,tempx[0],tempy[0],temp_len,alpha);
  }
}

void calc_Lab(){
  int i;
  float tol=0;
  for(i=0;i<5;i++){
    Lab[i]=abs(start_len[i]-end_len[i]);
    if(Lab[i]>tol) tol=Lab[i];
  }
  tol=tol/10000;
  for(i=0;i<5;i++){
    if(Lab[i]<=tol) Lab[i]=tol;
    print(Lab[i],"  ");
  }
  println(" lab");
}
void calc_lambda(float t){
  int i;
  float e=0,f=0,g=0,u=0,v=0,lam1=0,lam2=0;
  for(i=0;i<5;i++){
    theta[i]=start_angle[i]+t*(end_angle[i]-start_angle[i])/1000.0;
  }
  alpha[0]=theta[0];
  for(i=1;i<5;i++){
    alpha[i]=alpha[i-1]-theta[i];
  }
  for(i=0;i<5;i++){
    e+=Lab[i]*Lab[i]*cos((float)alpha[i])*cos((float)alpha[i]);
    f+=Lab[i]*Lab[i]*cos((float)alpha[i])*sin((float)alpha[i]);
    g+=Lab[i]*Lab[i]*sin((float)alpha[i])*sin((float)alpha[i]);
    u+=2*cos((float)alpha[i])*(start_len[i]+t*(end_len[i]-start_len[i])/1000.0);
    v+=2*sin((float)alpha[i])*(start_len[i]+t*(end_len[i]-start_len[i])/1000.0);
  }  
  lam1=(u*g-f*v)/(e*g-f*f);
  lam2=(e*v-u*f)/(e*g-f*f);
  for(i=0;i<5;i++){
    s[i]=-(0.5)*Lab[i]*Lab[i]*(lam1*cos((float)alpha[i])+lam2*sin((float)alpha[i]));
    //if(abs((float)s[i])>5) println(s[i],"  ",Lab[i],"   ",e,"   ",lam1,"   " ,f,"   ",lam2,"   ",u,"  ",cos(90));
  }    
}


void draw() {   
  if(move==1){    
    background(255);
    fill(0);
    interpolation(timeline,2);
    timeline=timeline+10;
    if(timeline>=1000){
      move=0;
    }
  }
  //saveFrame("frames/####.png");
}


//the following code aims to input shape by clicking a mouse.
// which has been abandoned because every test process need me to click so many times
/*
void mousePressed(){
  if(n<5){
    //print(n);
    startx[n]=mouseX;
    starty[n]=mouseY;
    rect((float)startx[n]-2,(float)starty[n]-2,4,4);
    if(n>=1){
      if(n==1)start_angle[0]=tool.calc_angle(0,startx[0]+1,starty[0],startx[0],starty[0],startx[1],starty[1]);
      else if(n>=2)start_angle[n-1]=tool.calc_angle(1,startx[n-2],starty[n-2],startx[n-1],starty[n-1],startx[n],starty[n]);
      start_len[n-1]=(float)Math.sqrt(Math.pow(startx[n]-startx[n-1],2)+Math.pow(starty[n]-starty[n-1],2));
      if(n==4){
        start_angle[4]=tool.calc_angle(1,startx[3],starty[3],startx[4],starty[4],startx[0],starty[0]);
        start_len[4]=(float)Math.sqrt(Math.pow(startx[4]-startx[0],2)+Math.pow(starty[4]-starty[0],2));
      }
    }
    n++;
    //tool.draw_graph(n,startx,starty);
    tool.draw_graph_angle(n,startx[0],starty[0],start_len,start_angle);
  }
  else{
    if(m<5){
      endx[m]=mouseX;
      endy[m]=mouseY;
      rect((float)endx[m]-2,(float)endy[m]-2,4,4);
      if(m>=1){
        if(m==1) end_angle[0]=tool.calc_angle(0,endx[0]+1,endy[0],endx[0],endy[0],endx[1],endy[1]);
        else if(m>=2)end_angle[m-1]=tool.calc_angle(1,endx[m-2],endy[m-2],endx[m-1],endy[m-1],endx[m],endy[m]);
        end_len[m-1]=(float)Math.sqrt(Math.pow(endx[m]-endx[m-1],2)+Math.pow(endy[m]-endy[m-1],2));
        if(m==4){
          end_angle[4]=tool.calc_angle(1,endx[3],endy[3],endx[4],endy[4],endx[0],endy[0]);
          end_len[4]=(float)Math.sqrt(Math.pow(endx[4]-endx[0],2)+Math.pow(endy[4]-endy[0],2));
        }
      }
      m++;
      //tool.draw_graph(m,endx,endy);
      tool.draw_graph_angle(m,endx[0],endy[0],end_len,end_angle);
      if(m==5){ 
      move=1;
      int i;
      float s,e,dif;
      for(i=0;i<5;i++){
        s=tool.adjust(start_angle[i]);
        e=tool.adjust(end_angle[i]);
        dif=e-s;
        while(dif>Math.PI) dif-=2*Math.PI;
        while(dif<-Math.PI) dif+=2*Math.PI;
        e=s+dif;
        end_angle[i]=e;
        start_angle[i]=s;
        //even the rotation of every line is limited to -180 to 180
        //but the rotation is concerned with the rotation of last line.
        println(debug(start_angle[i]),debug(end_angle[i]),debug(e-s));
        }
      } 
    }
  }
}
*/