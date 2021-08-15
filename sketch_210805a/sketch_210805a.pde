int SIZE = 20;
Ripple[] ripples = new Ripple[SIZE];

Point[] points = new Point[SIZE];

boolean pointJudge;
//中心からの波を一つにする
boolean mouseJudge = false;
int pointX = 310;
int pointY = 230;

void setup() {
//  size(screen.width, screen.height);
  size(640, 480);
  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
  
  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Ripple();
    points[i] = new Point();
  }
  
}

void draw() {
  background(0);
  
  for(int i=0;i<SIZE;i++) {
    if(ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }
  
  for(int i=0;i<SIZE;i++) {
     if(points[i].getFlag()) {
       points[i].move();
       points[i].pointDraw();
     }
   }
   
   //Pointに波が当たったか判定
   pointJudge = judge_collision(pointX,pointY);
   pointDraw(pointX,pointY);
   
   if(pointJudge && mouseJudge){
     for(int i=SIZE-1;i>0;i--) {
       points[i] = new Point(points[i-1]);
     }
    points[0].init(pointX,pointY,random(5,15),int(random(10,80)));
    mouseJudge = false;
  }
}

public void pointDraw(int x,int y){
    noFill();
    stroke(#FFFFFF,66,90);
    strokeWeight(2);
    ellipse(x,y,20,20);
}

public boolean judge_collision(int x,int y){
    boolean flag = false;
    if(get(x,y) != color(0,0,0)){
      flag = true;
    } else {
      flag = false;
    }
    return flag;
}
  
// mouse ver.
void mousePressed() {
  mouseJudge = true;
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(mouseX,mouseY,random(5,15),int(random(10,80)));
}

// keyboard ver.
void keyPressed() {
  for(int i=SIZE-1;i>0;i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(int(random(0,width)),int(random(0,height)),random(5,15),int(random(10,80)));
}
