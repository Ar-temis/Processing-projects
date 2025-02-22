import java.util.Random;
PFont font;

Random rand = new Random(); //Will be using this for random stars and planet coordinations

class Planet{
  float x;
  float y;
  int red;
  int green;
  int blue;
  float radius;
  
  Planet(){
    x = rand.nextInt(600) + 100;
    y = rand.nextInt(500) + 100;
    red = rand.nextInt(255);
    green = rand.nextInt(255);
    blue = rand.nextInt(255);
    radius = rand.nextInt(100) + 50;  
  }
  
  Planet(float X, float Y, int Size, int r, int g, int b){
    x = X;
    y = Y;
    radius = Size;
    red = r;
    green = g;
    blue = b;
  }
  
  void display(){
    noStroke();
    fill(red, green, blue);
    ellipse(x, y, radius * 2, radius * 2);
  }
  
  
  void drawArc(float offset, float angle){
    strokeWeight(6);
    // Random stroke color
    stroke(rand.nextInt(255),rand.nextInt(255),rand.nextInt(255));
    // Calculate the width of the arc using radius
    float hyp = (float) Math.sin(angle) * radius;
    // Calculate the height of the arc using radius
    float h = (float) Math.cos(angle) * radius;
    noFill();
    arc(x, y-h, hyp*2, (h-offset)*2, 0.0, PI);
  }
}

// Creating randomized stars
void setStars(int lower, int higher){
  // Atleast "lower" stars but can be up to lower + higher
  int starCount = rand.nextInt(higher) + lower; 
  
  for (int i=0; i < starCount; i++){
     stroke(255, 255);
     int x = rand.nextInt(width);
     int y = rand.nextInt(800);
     strokeWeight(rand.nextInt(4) + 3);
     // Selecting only stars that are in the bottom half
     if (500<y){
       float alpha =  Math.abs(y - 800);
       // Changing their alpha value relative to their y value, creating a gradient fade to black effect
       stroke(255, ((alpha *255)/300));  
     }
     point(x, y); 
  }
}

// Creating n number of randomized planets
void setPlanets(int n){
  for(int i=0; i<n; i++){
    Planet p1 = new Planet();
    p1.display();
    //p1.drawArc(50, PI/3);
    //p1.drawArc(80, PI/3.2);
    //p1.drawArc(100, PI/6);
  }
}

// Function used to write a text in the center
void typeText(String str, int size, int y){
  fill(247, 223, 5);
  textFont(font);
  textSize(size);
  textAlign(CENTER);
  text(str, width/2, y);
}

void setup() {
    size(800, 1000);
    background(0);
    setStars(400, 250);
    setPlanets(5);
    font = createFont("Starjedi.ttf", 32);
    typeText("Next summer", 10, 675);
    typeText("in theathers near you", 15, 690);
    typeText("Directed by Temuulen", 25, 720);
    typeText("Starring Benjamin Bacon", 33, 755);
    typeText("Star wars", 110, 860);
    typeText("Yes, disney made another one", 35, 900);
}
