class Tank extends GameObject {
  float angle = 45;  // initial angle of the cannon
  float speed = 10;  // initial speed of the projectile

  //PVector pos; // position of cannon
  static final int height = 20, width = 50;
  
  int hp;
  
  public Tank(int x, int y) {
    //pos = new PVector(x, y);
    super(x, y);
    hp = 3;
    
    this.h = height;
    this.w = width;
  }
  
  PVector pos() {
    return pos;
  }
  
  void display() {
    if(!isDead()) {
      fill(100);
      rect(pos.x, pos.y, Tank.width, Tank.height);
    }
  }
  
  void decreaseHP() {
    hp--;
  }
    
  boolean isDead() {
    return hp == 0;
  }
  
  void moveX(int x) {
    pos.x += x;
    for(Obstacle obstacle: obstacles) {//int i = 0; i < obstacles.size(); i++ {
      if(obstacle.collides((int) pos.x, (int) pos.y, height, width)) {
        System.out.println("Collided");
        pos.x -= x;
      }
    }
  }
}
