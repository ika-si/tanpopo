import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim = new Minim(this);
AudioPlayer player;


int SIZE = 20; //マウスクリックとキーボードで生成できる波の上限数
int pointSIZE = 100; //ボールから生成できる波の上限数
int ballSIZE = 10; //ボールの数

float maxSpeed = 5;
float minSpeed = 8; //波の進行速度設定

int frameCut = 10; //生成する波の個数を間引く（値が大きいほど間引かれる）

Ripple[] ripples = new Ripple[SIZE];
Point[] points = new Point[pointSIZE];
Ball[] balls = new Ball[ballSIZE];



void setup() {
  
  player = minim.loadFile("bgm.wav");

  size(700, 700);
  colorMode(HSB, 100);
  background(0);
  smooth();
  frameRate(60);

  for (int i=0; i<SIZE; i++) {
    ripples[i] = new Ripple();
  }
  for (int i=0; i<pointSIZE; i++) {
    points[i] = new Point();
  }
  for (int i=0; i<ballSIZE; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(0);
  player.play();



  for (int i=0; i<SIZE; i++) {
    if (ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }

  for (int i=0; i<pointSIZE; i++) {
    if (points[i].getFlag()) {
      points[i].move();
      points[i].rippleDraw();
    }
  }

  for (int i=1; i<ballSIZE; i++) {
    balls[i].move();
  }

  for (int k=ballSIZE-1; k>0; k--) { 
    if (balls[k].judge_collision() && frameCount%frameCut==0) {
      for (int i=pointSIZE-1; i>0; i--) {
        points[i] = new Point(points[i-1]);
      }
      points[0].init(balls[k].x, balls[k].y, random(minSpeed, maxSpeed), int(random(10, 80)));
    }
  }
}

// mouse ver.
void mousePressed() {
  for (int i=SIZE-1; i>0; i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(mouseX, mouseY, random(5, 15), int(random(10, 80)));
}

// keyboard ver.
void keyPressed() {
  for (int i=SIZE-1; i>0; i--) {
    ripples[i] = new Ripple(ripples[i-1]);
  }
  ripples[0].init(int(random(0, width)), int(random(0, height)), random(5, 15), int(random(10, 80)));
}
