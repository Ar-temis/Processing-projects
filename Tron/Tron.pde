import java.util.*;
float arenaX;
float arenaY;
float arenaW;
float arenaH;

float rotateRight = 0.01;
float rotateLeft = -0.01;
int round = 0;
int enemyCount;
int allyCount;
Player p1;
Player p2;

int countdownTime = 5;
int startTime;
boolean roundStarted = false;

void setup(){
  size(1080, 1080);
  frameRate(60);
  arenaX = width/8;
  arenaY = height/8;
  arenaW = width/8*6;
  arenaH = height/8*6;
  p1 = new Player(arenaX + arenaW/3, height/2);
  p2 = new Player(arenaX + arenaW/3*2, height/3);
  startTime = millis();
}

void draw(){
  background(0);
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
  if (p1.health == 0 || p2.health == 0){
    
  } else {
    stroke(255);
    noFill();
    rectMode(CORNER);
    rect(arenaX, arenaY, arenaW, arenaH);
    p1.draw();
    p2.draw();
    p1.checkTouchOther(p2);
  }
}


void resetRound(){
  roundStarted = false;
  startTime = millis();
  p1 = new Player(arenaX + arenaW/3, height/2);
  p2 = new Player(arenaX + arenaW/3*2, height/3);
}

