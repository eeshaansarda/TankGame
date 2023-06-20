class Shell {

  PVector pos;
  PVector velocity;
  float angle, speed;
  boolean collided;

  Shell(int x, int y, float angle, float speed) {
    this.pos = new PVector(x, y);
    this.angle = radians(angle);
    this.speed = speed;
    float vx = speed * cos(this.angle);
    float vy = -speed * sin(this.angle);
    velocity = new PVector(vx, vy);
    collided = false;
  }

  void update() {
    pos.add(velocity);
    velocity.add(gravity);
    velocity.add(wind);
    velocity.mult(DAMPING);
    
    
    // Bounce back
    if (pos.y < 0) {
      velocity.y = -velocity.y;
    }
    
    if (pos.x < 0 || pos.x > width) {
      System.out.println("width " + width);
      System.out.println("pos.x " + pos.x);
      pos.x = pos.x < 0 ? 0 : width;
      velocity.x = -velocity.x;
    }
    
    // Collisions
    Iterator<Obstacle> iter = obstacles.iterator();
    while (iter.hasNext()) {
      Obstacle obstacle = iter.next();
      if (obstacle.collides((int) pos.x, (int) pos.y)) {
          iter.remove();
        collided = true;
      }
    }
    if(tank1.collides((int)pos.x, (int)pos.y)) {
      tank1.decreaseHP();
      collided = true;
    }
    
    if(tank2.collides((int)pos.x, (int)pos.y)) {
      tank2.decreaseHP();
      collided = true;
    }
    
    if(gameOver()) {
      state = GameState.AFTER;
    }
       
  }

  void display() {
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  boolean isDead() {
    if (pos.x < 0 || pos.x > width || pos.y > height || pos.y > bottomHeight || collided) {
      return true;
    }
    return false;
  }

}
