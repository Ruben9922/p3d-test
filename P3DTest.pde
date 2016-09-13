final int BALL_START_INTERVAL = 1;

PVector windowCenter;
int ballStarts = 0;
ArrayList<Ball> ballList = new ArrayList<Ball>((60 * Ball.MAX_RADIUS) / (BALL_START_INTERVAL * Ball.RADIUS_DECREMENT));

void setup() {
  size(800, 600, P3D);
  windowCenter = new PVector(width / 2, height / 2, 0);
}

void draw() {
  background(50);
  lights();
  rectMode(CENTER);

  stroke(255);
  fill(75);
  pushMatrix();
  translate(windowCenter.x, windowCenter.y, windowCenter.z);
  rotateX(atan((mouseX - windowCenter.x) / (mouseY - windowCenter.y)) * 2);
  rotateY(PI/7);
  box(100);
  popMatrix();

  if (mousePressed && ++ballStarts % BALL_START_INTERVAL == 0) {
    ballList.add(new Ball());
    ballStarts = 0;
  }
  for (int i = 0; i < ballList.size(); i++) {
    Ball ball = ballList.get(i);
    if (ball.radius <= 0) {
      ballList.remove(i);
    } else {
      noStroke();
      fill(255);
      ball.display();
      ball.move();
      ball.decreaseRadius();
    }
  }
}

class Ball {
  static final int MAX_RADIUS = 20;
  static final int RADIUS_DECREMENT = 1;

  PVector center;
  int radius;

  Ball(float x, float y, float z, int radius) {
    center = new PVector(x, y, z);
    this.radius = radius;
  }

  Ball() {
    this(random(-100, 101), random(-100, 101), random(-100, 101), (int)random(MAX_RADIUS + 1));
  }

  void display() {
    pushMatrix();
    translate(windowCenter.x + center.x, windowCenter.y + center.y, windowCenter.z + center.z);
    sphere(radius);
    popMatrix();
  }

  void move() {
    center.mult(1.2);
  }

  void decreaseRadius() {
    radius -= RADIUS_DECREMENT;
  }
}
