public class PlayerController extends Thread {
  Player player;
  volatile boolean running = true;
  volatile char currentKey = 0;
  volatile int currentArrowKey = 0;
  boolean isPlayerOne;

  PlayerController(Player player, boolean isPlayerOne) {
    this.player = player;
    this.isPlayerOne = isPlayerOne;
  }

  public void run() {
    while (running) {
      if (isPlayerOne) {
        if (currentKey == 'a' || currentKey == 'd' || currentKey == 'w') {
            switch(currentKey){
                case 'a':
                    player.angle -= player.turnSpeed;  // Turn left (counterclockwise)
                    break;
                case 'd':
                    player.angle += player.turnSpeed;  // Turn left (counterclockwise)
                    break;
            }
        }
      } else {
        if (currentArrowKey == LEFT || currentArrowKey == RIGHT || currentArrowKey == UP) {
            switch(currentArrowKey){
                case LEFT:
                    player.angle -= player.turnSpeed;  // Turn left (counterclockwise)
                    break;
                case RIGHT:
                    player.angle += player.turnSpeed;  // Turn left (counterclockwise)
                    break;
            }
        }
      }
      try {
        Thread.sleep(16); // Approximately 60 FPS
      } catch (InterruptedException e) {
        e.printStackTrace();
        running = false;
      }
    }
  }

  void setKey(char k) {
    currentKey = k;
  }

  void setArrowKey(int k) {
    currentArrowKey = k;
  }

  void stopController() {
    running = false;
    interrupt();
  }
}
