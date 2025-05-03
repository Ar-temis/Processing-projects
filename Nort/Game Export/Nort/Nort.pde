import java.util.*;
import processing.sound.*;

SoundFile file;
PFont font;
float arenaX;
float arenaY;
float arenaW;
float arenaH;
boolean menu = true;

int round = 0;
int enemyCount;
int allyCount;
Player p1;
Player p2;

// Threads for the game logic
PlayerController p1Controller;
PlayerController p2Controller;
CheckCollision p1Collision;
CheckCollision p2Collision;

int countdownTime = 3;
int startTime;
boolean roundStarted = false;

float healthMenuY;
float healthMenuX;

void setup(){
  fullScreen();
  background(0);
  frameRate(60);
  arenaX = width/8;
  arenaY = height/8-100;
  arenaW = width/8*6;
  arenaH = height/8*6-100;
  healthMenuY = height/8*6;
  healthMenuX = width/10*3;
  
  font = createFont("dogica.ttf", 32);
  textFont(font);
  
  file = new SoundFile(this, "asc-binary.mp3");
  file.loop();

  p1 = new Player(arenaX + arenaW/3, height/2, true);
  p2 = new Player(arenaX + arenaW/3*2, height/2, false);
  
  // Initialize and start controllers and collision checkers
  p1Controller = new PlayerController(p1, true);
  p2Controller = new PlayerController(p2, false);
  p1Collision = new CheckCollision(p1, p2);
  p2Collision = new CheckCollision(p2, p1);
  p1Controller.start();
  p2Controller.start();
  p1Collision.start();
  p2Collision.start();
}

void keyPressed(){
  if (key ==  'a' || key == 'w' || key == 'd'){
    p1Controller.setKey(key);
  }
  if (key == CODED){
    p2Controller.setArrowKey(keyCode);
  }
}

void draw(){
  // Count Down
  background(0);
  if (menu){
    textAlign(CENTER);
    text("Press S to start the game", width/2, height/3);
    text("Player 1 uses W, A, D to move", width/2, height/2);
    text("Player 2 uses arrow keys to move", width/2, height/2 + 50);
    if (keyPressed){
      if (key == 's'){menu = false;}
      startTime = millis();
    }
  } else {
    if (!roundStarted){
      int elapsedTime = (millis() - startTime) / 1000;  // Convert to seconds
      int remainingTime = countdownTime - elapsedTime;  // Countdown
      
      if (remainingTime > 0) {
        // Show countdown on screen
        fill(255);
        textSize(50);
        textAlign(CENTER, CENTER);
        text(remainingTime, width / 2, height / 2);
        return; 
      } else { roundStarted = true; }
    }
    // Game Over Menu
    if (p1.health == 0 || p2.health == 0){
      textSize(40);
      if (p1.health == 0){
        textAlign(CENTER);
        fill(p2.c);
        text("PLAYER 2 WINS!", width/2, height/2);
      } else {
        textAlign(CENTER);
        fill(p1.c);
        text("PLAYER 1 WINS!", width/2, height/2);
      }
      textSize(20);
      text("Press R to restart!", width/2, height/3*2);
      if (keyPressed){
        if (key == 'r'){
          p1 = new Player(arenaX + arenaW/3, height/2, true);
          p2 = new Player(arenaX + arenaW/3*2, height/2, false);
          p1Controller.player = p1;
          p2Controller.player = p2;
          p1Collision.player = p1;
          p1Collision.enemy = p2;
          p2Collision.player = p2;
          p2Collision.enemy = p1;
          roundStarted = false;
          startTime = millis();
        }
      }
    // Main Game Play
    } else {
      float elapsedTime = (millis() - startTime) / 1000;
      if (elapsedTime > 15){
        startSuddenDeath(elapsedTime);
      }
      stroke(255);
      noFill();
      rectMode(CORNER);
      rect(arenaX, arenaY, arenaW, arenaH);
      pushMatrix();
        translate(healthMenuX, healthMenuY);
        textAlign(RIGHT);
        textSize(40);
        fill(p1.c);
        text("P1:", 40, 40);
        noStroke();
        textAlign(LEFT);
        text("Use W, A, D to control", 400, 40);
        for (int i=0; i<p1.health; i++){
          rect(50 + i*50, 0, 30, 60);
        }
        translate(0, 90);
        fill(p2.c);
        textAlign(RIGHT);
        text("P2:", 40, 40);
        textAlign(LEFT);
        text("Use UP, LEFT, RIGHT to control", 400, 40);
        for (int i=0; i<p2.health; i++){
          rect(50 + i*50, 0, 30, 60);
        }
      popMatrix();
      p1.draw();
      p2.draw();
    }
  }   
}

void startSuddenDeath(float elapsedTime){
  if (elapsedTime < 22){
    arenaX +=1.5;
    arenaW -=3;
  }
}

void resetRound(){
  roundStarted = false;
  startTime = millis();
  
  // Reset player positions and angles
  p1.playerReset();
  p2.playerReset();
  // Reset controller states to neutral/forward
  p1Controller.currentKey = 'w';
  p2Controller.currentArrowKey = UP;
  
  // Reset arena dimensions
  arenaX = width/8;
  arenaY = height/8-100;
  arenaW = width/8*6;
  arenaH = height/8*6-100;
}

void stop() {
  p1Controller.stopController();
  p2Controller.stopController();
  p1Collision.stopCheckCollision();
  p2Collision.stopCheckCollision();
  super.stop();
}
