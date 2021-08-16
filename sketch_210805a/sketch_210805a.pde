float FRICTION = 0.985;

public class Ripple{
  int x,y;
  float dia;
  float speed;
  int colorH;
  boolean flag;
  
  Ripple() {
    init(0,0,0,0);
    flag = false;
  }

  public Ripple(Ripple src) {
    this.x = src.x;
    this.y = src.y;
    this.speed = src.speed;
    this.colorH = src.colorH;
    this.dia = src.dia;
    this.flag = src.flag;
  }

  public void init(int _x, int _y, float _speed, int _colorH) {
    x = _x;
    y = _y;
    speed = _speed;
    colorH = _colorH;
    dia = 0.0;
    flag = true;
  }

  public void rippleDraw() {
    noFill();
  
    if(speed > 1.0) {
      stroke(colorH, 60, 99, 100*(speed-1)/3);
      strokeWeight(4);
      ellipse(x,y,dia,dia);
    }
    if(speed > 1.5) {
      stroke(colorH, 60, 99, 100*(speed-1.5)/3);
      strokeWeight(2);
      ellipse(x,y,dia*0.7,dia*0.7);
    }
    if(speed > 2.0) {
      stroke(colorH, 60, 99, 100*(speed-2)/3);
      strokeWeight(1);
      ellipse(x,y,dia*0.6,dia*0.6);
    }
  }

  public void move() {
    dia += speed;
    speed *= FRICTION;
    if(speed < 0.5) {
      flag = false;
    }
  }

  public boolean getFlag() {
    return flag;
  }
}
int SIZE = 20;
Ripple[] ripples = new Ripple[SIZE];

void setup() {
//  size(screen.width, screen.height);
  size(640, 480);
  colorMode(HSB,100);
  background(0);
  smooth();
  frameRate(30);
  
  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Ripple();
  }
}

void draw() {
  background(0);
  pointdraw();
  
  for(int i=0;i<SIZE;i++) {
    if(ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }
}

// mouse ver.
void mousePressed() {
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
