public class Ball{
  
  int x,y;
  int vx,vy;
  color beforeColor;
  color afterColor;
  
  Ball() {
    x = int(random(50,700));
    y = int(random(50,700));
    if(random(-1,1)<0){
      vx = int(random(3,4));
    }else{
      vx = int(random(-4,3));
    }
    if(random(-1,1)<0){
      vy = int(random(3,4));
    }else{
      vy = int(random(-4,3));
    }
    beforeColor = color(0,0,0);
  }
  
  public void pointDraw(){
    noFill();
    stroke(#FFFFFF);
    strokeWeight(2);
    ellipse(x,y,20,20);
}

public void move(){
  x = x + vx;
  if(x>width-10 || x<10){vx=-1*vx;}
  y = y + vy;
  if(y>height-10 || y<10){vy=-1*vy;}
  pointDraw();
  
}

public boolean judge_collision(){
    boolean flag = false;
    if(get(x,y) != beforeColor && get(x,y)!=color(0,0,0) && get(x,y)!=color(#FFFFFF)){
      flag = true;
      beforeColor = get(x,y);
    } else {
      flag = false;
    }
     
    return flag;
}
  
}
