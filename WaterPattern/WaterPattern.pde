float radius;

void setup(){
  size(900, 900);
  
  fill(0);
  stroke(255);
}

void draw(){
  background(255, 102, 179);
  radius = (mouseX * 90 / 900) * 2;
  for (int x = width; x >= 0; x-=90){
    for (int y = height; y >= 0; y-=90){
      fill(187, 230, 228);
      arc(x, y-mouseY*10/900, radius, radius, HALF_PI + PI, 3*PI);
      fill(66, 191, 221);
      arc(x - 15, y-mouseY*50/900, radius, radius, HALF_PI + PI, 3*PI);
      fill(8, 75, 131);
      arc(x-30, y-mouseY*100/900, radius, radius, HALF_PI + PI, 3*PI); 
    }
  }
}
