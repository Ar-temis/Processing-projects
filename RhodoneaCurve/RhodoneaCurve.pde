boolean random=true; //make this true to get a random artwork everytime the code is run

float k = 8; // Number of petals if odd, 2k petals if even
float scale = 250; // flower scale
int num_flowers = 5; //number of flowers
float radius = 64; // radius of sphere
float angle = 0.0;
float aOff = 0.05; // rotation speed

float x,y;

void setup() {
  size(1080, 1080);
  background(0);
  stroke(145, 140, 200);
  noFill();
  smooth(8);
  frameRate(60);
}

void keyPressed(){
  if (key == 'r'){
    k = random(15);
    scale = random(200) + 100;
    num_flowers = (int) random(20);
    radius = random(100);
    aOff = random(1);
    stroke(random(255), random(255), random(255));
  }
}

void drawFlower(float xPos, float yPos, float k, float scale, float a) {
  pushMatrix(); 
  translate(xPos, yPos);
  rotate(a);
  beginShape();
  for (float t = 0; t < TWO_PI * 5; t += 0.02) { 
    float radius = scale * cos(k * t); 
    float x = radius * cos(t);
    float y = radius * sin(t);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}


void draw(){
  background(0);
  ellipse(width/2, height/2, radius*2, radius*2);
  translate(width/2, height/2);
  float rotation = TWO_PI / num_flowers; // angle between each flower
  angle += aOff;
  for (int i=1; i<num_flowers+1;i++){
    y = (float) Math.sin(rotation * i) * radius;
    x = (float) Math.cos(rotation * i) * radius;
    drawFlower(x,y,k, scale, angle);
  }
}
