class Segment {
  float x, y;
  float angle;
  float distance;
  float radius;
  float opacity = 255;
  
  Segment(float x, float y, float a, float d, float r){
    this.x = x;
    this.y = y;
    angle = a;
    distance = d;
    radius = r;
  }

  void update(Segment prev){
    float a = atan2(prev.y-y, prev.x-x);
    angle = a;
    float d = sqrt(pow(prev.x-x,2) + pow(prev.y-y,2));
    if (d > distance){
      float delta = d - distance;
      x+= delta*cos(angle);
      y+= delta*sin(angle);
    }
  }

  void display(){
    pushMatrix();
      translate(x,y);
      rotate(angle);
      stroke(255, 255, 255, opacity);
      line(0,0,distance,0);
    popMatrix();
  }
}
