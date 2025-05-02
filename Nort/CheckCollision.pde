public class CheckCollision extends Thread {
  Player player, enemy;
  volatile boolean running = true;
  
  CheckCollision(Player player, Player enemy) {
    this.player = player;
    this.enemy = enemy;
  }

  public void run() {
    while (running) {
      // Only check collisions if the player is alive
      if (player.health > 0) {
        player.checkTouchOwn();
        player.checkBoundaries();
        player.checkTouchOther(enemy);
      }
      
      try {
        Thread.sleep(10); // Add a small delay 
      } catch (InterruptedException e) {
        // Handle interruption gracefully
        running = false;
      }
    }
  }

  void stopCheckCollision() {
    running = false;
    interrupt(); // Ensure the thread exits cleanly
  }
}
