public class Ball {

  int x, y;
  int vx, vy;
  int r = 20;
  float maxSpeed = 5;
  float minSpeed = 4;
  
  color beforeColor;

  Ball() {
    x = int(random(r, width-r));
    y = int(random(r, height-r));
    if (random(-1, 1)<0) {
      vx = int(random(minSpeed, maxSpeed));
    } else {
      vx = int(random(-maxSpeed, -minSpeed));
    }
    if (random(-1, 1)<0) {
      vy = int(random(minSpeed, maxSpeed));
    } else {
      vy = int(random(-maxSpeed, -minSpeed));
    }
    beforeColor = color(0, 0, 0);
  }

  public void pointDraw() {
    noFill();
    stroke(#FFFFFF);
    strokeWeight(2);
    ellipse(x, y, r, r);
  }

  public void move() {
    x = x + vx;
    if (x>width-10 || x<10) {
      vx=-1*vx;
    }
    y = y + vy;
    if (y>height-10 || y<10) {
      vy=-1*vy;
    }
    pointDraw();
  }

  public boolean judge_collision() {
    boolean flag = false;
    if (get(x, y) != beforeColor && get(x, y)!=color(0, 0, 0)) {
      flag = true;
      beforeColor = get(x, y);
    } else {
      flag = false;
    }
    return flag;
  }
}
