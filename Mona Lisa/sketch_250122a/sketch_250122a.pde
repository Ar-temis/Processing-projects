PImage img;
PFont font;
color pixColor;

// Characters representing the different brightness levels. From 0 to 255.
char[] characters= {
    ' ', '`', '.', ',', ':', '-', '~', '=', '+', '*', 
    'o', 'O', 'G', 'R', 'Q', 'H', 'X', 'W', 'M', 'B', 
    '8', '&', '%', '@', '#', 'W'
};

//change the path of the picture but remember to change the window size from setup too.
String path = "Mona_Lisa.jpg"; 
int photoW = 725; //photo width
int photoH = 1080;  //photo height

void setup(){
  size(2175,1080); // Image size got to have the width times three since we have 3 pictures
  img = loadImage(path); // Image size 725x1080
  // Have to use a Mono font
  font = createFont("HackNerdFontMono-Regular.ttf", 12);
  textSize(4);
}

void draw(){
  background(0);
  image(img, 0,0);
  for (int y=0; y<photoH; y+=2){
    for (int x=0; x<photoW; x+=2){       
       pixColor = get(x, y);     // selecting each pixel
       int b = round(brightness(pixColor));   // getting the brightness value
       int rand = (int) random(-5, 5);
       
       // only selecting some pixels to randomize due to index being out of bounds
       // pixels without the random glitching effect
       if (rand + b/10 > 25 || rand + b/10 < 0){
         fill(247, 223, 5);
         if (mouseX < 725){
           text(characters[b/10], mouseX + x, y);
         } else {
           text(characters[b/10], x + photoW, y);
         }
         fill(50, 88, 168);
         if (mouseX < 1450){
           text(characters[b/10], mouseX + x, y);
         } else {
           text(characters[b/10], x + 1450, y);
         }
       }
       // pixels with the random glitching effect
       else{
         fill(247, 223, 5);
         if (mouseX < 725){
           text(characters[rand + b/10], mouseX + x, y);
         } else {
           text(characters[rand + b/10], x + photoW, y);
         }
         fill(50, 88, 168);
         if (mouseX < 1450){
           text(characters[rand + b/10], mouseX + x, y);
         } else {
           text(characters[rand + b/10], x + 1450, y);
         }
       }
    }
  }
}
