
class Player {
  float x;
  float y;
  float front = 30;
  float side = 50;
  int health = 5;
  float speed = 5;
  float angle = 0.0;  // Angle in radians
  float turnSpeed = 0.05;  // Adjusted turn speed for better control
  char motion;
  
  //the trail attributes
  ArrayList<Segment> body;
  int len = 10;
  float r = 18; //distance between each trail segment

  public Player(float x, float y) {
    this.x = x;
    this.y = y;

    body = new ArrayList<Segment>();
    for(int i=0; i<len; i++){
      body.add(new Segment(x - r*i, y, angle, r, r));
    }
  }

  public Player(float x, float y, int health, float speed) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.speed = speed;

    body = new ArrayList<Segment>();
    for(int i=0; i<len; i++){
      body.add(new Segment(x - r*i, y, angle, r, r));
    }
  }
  
  void draw() {
    pushMatrix();
    translate(x, y);
    rotate(angle);  
    fill(52, 119, 235);
    rectMode(CENTER);
    
    // TODO change it to a bike
    rect(0, 0, side, front);
    popMatrix();
    x += speed * cos(angle);
    y += speed * sin(angle);
    
    checkBoundaries();
    update();
    drawTrail();
    checkTouchOwn();
    // Handle input
    if (keyPressed) {
      motion = key;
    }
    switch(motion){
      case 'a':
        angle -= turnSpeed;  // Turn left (counterclockwise)
        break;
      case 'd':
        angle += turnSpeed;  // Turn left (counterclockwise)
        break;
    }
  }

  void checkBoundaries() {
    float halfSide = side / 2;
    float halfFront = front / 2;

    // Prevent going beyond left boundary
    if (x - halfSide < arenaX) {
      x = arenaX + halfSide;
    }

    // Prevent going beyond right boundary
    if (x + halfSide > arenaX + arenaW) {
      x = arenaX + arenaW - halfSide;
    }

    // Prevent going beyond top boundary
    if (y - halfFront < arenaY) {
      y = arenaY + halfFront;
    }

    // Prevent going beyond bottom boundary
    if (y + halfFront > arenaY + arenaH) {
      y = arenaY + arenaH - halfFront;
    }
  }



  // touch own line
  void checkTouchOwn(){
    for (int i=3; i<len; i++){
      Segment s = body.get(i);
      float d = dist(x,y,s.x,s.y);

      if (d < r/2) {
        health--;
        resetRound();
      }
    }
  }

  void checkTouchOther(Player enemy){
    for (int i=1; i<len; i++){
      Segment s = enemy.body.get(i);
      float d = dist(x,y,s.x,s.y);

      if (d < r/2) {
        health--;
        resetRound();
      }
    }
  }

  // update the trail 
  void update(){
    Segment head = body.get(0);
    float a = atan2(y - head.y, x - head.x);
    head.angle = a;
    head.x += speed * cos(head.angle);
    head.y += speed * sin(head.angle);
    head.opacity = 0;
    for (int i=1; i<len; i++){
      Segment c = body.get(i);
      Segment p = body.get(i-1);
      c.update(p);
    }
  }

  void drawTrail(){
    for (int i=0; i<len; i++){
      body.get(i).display();
    }
  }
}
