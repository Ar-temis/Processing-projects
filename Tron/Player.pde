class Player {
  float x;
  float y;
  float front = 30;
  float side = 56;
  int health = 5;
  float speed = 5;
  float angle = PI+HALF_PI;  // Angle in radians
  float turnSpeed = 0.05;  // Adjusted turn speed for better control
  char motion;
  boolean playerOne;
  color c;
  PImage img;
  //the trail attributes
  ArrayList<Segment> body;
  int len = 15;
  float r = 18; //distance between each trail segment

  public Player(float x, float y, boolean playerOne) {
    this.x = x;
    this.y = y;
    this.playerOne = playerOne;
    if (playerOne){
      img = loadImage("p1Bike.png");
      c = color(209,224,0,255);
    }else{
      img = loadImage("p2Bike.png");
      c = color(224,0,66,225);
    }
    body = new ArrayList<Segment>();
    for(int i=0; i<len; i++){
      body.add(new Segment(x, y + r*i, angle, r, r,c));
    }
  }

  public Player(float x, float y, boolean playerOne, int health) {
    this.x = x;
    this.y = y;
    this.health = health;
    this.playerOne = playerOne;
    if (playerOne){
      c = color(209,224,0,255);
    }else{
      c = color(224,0,66,225);
    }
    body = new ArrayList<Segment>();
    for(int i=0; i<len; i++){
      body.add(new Segment(x, y + r*i, angle, r, r,c));
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    rotate(angle);  
    fill(52, 119, 235);
    imageMode(CENTER);
   
    rotate(HALF_PI);
    image(img, 0, 0, front, side);
    popMatrix();
    x += speed * cos(angle);
    y += speed * sin(angle);
    
    checkBoundaries();
    update();
    drawTrail();
    checkTouchOwn();
    // Handle input
    if (playerOne){
      switch(motion){
        case 'a':
          angle -= turnSpeed;  // Turn left (counterclockwise)
          break;
        case 'd':
          angle += turnSpeed;  // Turn left (counterclockwise)
          break;
     }
    } else {
      switch(motion){
        case 'h':
          angle -= turnSpeed;  // Turn left (counterclockwise)
          break;
        case 'l':
          angle += turnSpeed;  // Turn left (counterclockwise)
          break;
      }
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
        if (health > 0){
          resetRound();
        }
      }
    }
  }

  void checkTouchOther(Player enemy){
    for (int i=1; i<len; i++){
      Segment s = enemy.body.get(i);
      float d = dist(x,y,s.x,s.y);

      if (d < r/2) {
        health--;
        if (health > 0){
          resetRound();
        }
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
    head.c = color(0,0,0,0);
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

  void playerReset(){
    if (playerOne){
      x = arenaX + 60;
      y = height/2;
    }else{
      x = arenaX + arenaW - 60;
      y = height/2;
    }
    motion = 'w';
    angle = HALF_PI + PI;
    body = new ArrayList<Segment>();
    for(int i=0; i<len; i++){
      body.add(new Segment(x, y + r*i, angle, r, r,c));
    }
  }
}
