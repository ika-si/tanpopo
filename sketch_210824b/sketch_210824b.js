let SIZE = 100; 
let ballSIZE = 10;
let audioSIZE = 15;
let maxSpeed = 7;
let minSpeed = 5;
let frameCut = 5; 
var ripples = [];
var points = [];
var balls = [];
var player;
var audio = ["F3","F4","G3","A3","A4","B3","B4","C3","C4","C5","D3","D4","E3","E4","G4"];
var players = [];

function preload(){
		soundFormats('wav', 'mp3');
		player = loadSound("bgm.mp3");
		for (let i=0; i<audioSIZE; i++){
    players[i] = loadSound(audio[i]+".wav");
		}
	}

function setup() {
  createCanvas(700, 700);
  colorMode(HSB, 100);
  smooth();
  frameRate(60);
  player.loop();
  
  for (let i=0; i<SIZE; i++) {
    ripples[i] = new Ripple();
  }
 
  for (let i=0; i<ballSIZE; i++) {
    balls[i] = new Ball();
  }
}

function draw() {
  background(0);

  for (let i=0; i<SIZE; i++) {
    if (ripples[i].getFlag) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }

  for (let i=1; i<ballSIZE; i++) {
    balls[i].move();
  }

  for (let k=ballSIZE-1; k>0; k--) { 
    if (balls[k].judge_collision() && frameCount%frameCut==0) {
      for (let i=SIZE-1; i>0; i--) {
        ripples[i].NewRipple(ripples[i-1].getX,ripples[i-1].getY,ripples[i-1].getSpeed,ripples[i-1].getColorH,ripples[i-1].dia,ripples[i-1].flag);
      }
      ripples[0].Ripple(balls[k].getX, balls[k].getY, random(minSpeed, maxSpeed), int(random(10, 80)));
      players[int(random(0,audioSIZE))].play();
    }
  }
  }

 function mousePressed() {
  for (let i=SIZE-1; i>0; i--) {
    ripples[i].NewRipple(ripples[i-1].getX,ripples[i-1].getY,ripples[i-1].getSpeed,ripples[i-1].getColorH,ripples[i-1].dia,ripples[i-1].flag);
  }
  ripples[0].Ripple(mouseX, mouseY, random(5, 15), int(random(10, 80)));
}

function keyPressed() {
  for (let i=SIZE-1; i>0; i--) {
    ripples[i].NewRipple(ripples[i-1].getX,ripples[i-1].getY,ripples[i-1].getSpeed,ripples[i-1].getColorH,ripples[i-1].dia,ripples[i-1].flag);
  }
  ripples[0].Ripple(int(random(0, width)), int(random(0, height)), random(5, 15), int(random(10, 80)));
}


class Ball {

  constructor() {
    this.beforeColor = color(0, 0, 0);
    this.r = 20;
    let Max = 5;
    let min = 4;
    this.x = int(random(this.r, width-this.r));
    this.y = int(random(this.r, height-this.r));
    if (random(-1, 1)<0) {
      this.vx = int(random(min, Max));
    } else {
      this.vx = int(random(-Max, -min));
    }
    if (random(-1, 1)<0) {
      this.vy = int(random(min, Max));
    } else {
      this.vy = int(random(-Max, -min));
    }
  }

  get getX(){
    return this.x;
  }

  get getY(){
    return this.y;
  }

  pointDraw() {
    noFill();
    colorMode(RGB);
    stroke(255,255,255);
    strokeWeight(2);
    ellipse(this.x, this.y, this.r, this.r);
  }

  move() {
    this.x = this.x + this.vx;
    if (this.x>width-10 || this.x<10) {
      this.vx=-1*this.vx;
    }
    this.y = this.y + this.vy;
    if (this.y>height-10 || this.y<10) {
      this.vy=-1*this.vy;
    }
    this.pointDraw();
  }

  judge_collision() {
    this.flag = false;
    if (String(color(get(this.x,this.y)).levels)!="0,0,0,255") {
      this.flag = true;
      this.beforeColor = get(this.x, this.y);
    } else {
      
      this.flag = false;
    }
    return this.flag;
  }
}


let FRICTION = 0.985;
class Ripple {

  constructor(_x,  _y, _speed, _colorH) {
    this.x = 0;
    this.y = 0;
    this.speed = 0;
    this.colorH = 0;
    this.dia = 0.0;
    this.flag = false;
  }
  
  Ripple(x,y,speed,colorH) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.colorH = colorH;
    this.dia = 0.0;
    this.flag = true;
  }

  NewRipple(x,y,speed,colorH,dia,flag){
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.colorH = colorH;
    this.dia = dia;
    this.flag = true; 
  }

  rippleDraw() {
    noFill();
    if (this.speed > 1.0) {
      colorMode(HSB);
      stroke(this.colorH, 60, 99, 100*(this.speed-1)/3);
      strokeWeight(4);
      ellipse(this.x, this.y, this.dia, this.dia);
    }
  }

  move() {
    this.dia += this.speed;
    this.speed *= FRICTION;
    if (this.speed < 0.5) {
      this.flag = false;
    }
  }

  get getX(){
    return this.x;
  }
  get getY(){
    return this.y;
  }
  get getSpeed(){
    return this.speed;
  }
  get getColorH(){
    return this.colorH;
  }

  get getDia(){
    return this.dia;
  }

  get getFlag() {
    return this.flag;
  }

}
