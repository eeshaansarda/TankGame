class Obstacle extends GameObject {
  
  static final int height = 20, width = 50;
  
  public Obstacle(int x, int y) {
    super(x, y);
    this.w = width;
    this.h = height;
  }
  
  void display() {
    rect(pos.x, pos.y, Obstacle.width, Obstacle.height);
  }
}
