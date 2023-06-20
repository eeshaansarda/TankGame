public class GameObject {
  public PVector pos;
  int h, w;
  
  GameObject(int x, int y) {
    pos = new PVector(x, y);
  }
  
  // for a shell
  boolean collides(int x, int y) {
    if (x > pos.x && x < pos.x + w && y > pos.y && y < pos.y + h) {
      return true;
    }
    return false;
  }
  
  // for an object with height and width
  boolean collides(int x, int y, int height, int width) {    
    int left = (int) Math.max(x, pos.x);
    int right = (int) Math.min(x + width, pos.x + w);
    int top = (int) Math.max(y, pos.y);
    int bottom = (int) Math.min(y + height, pos.y + h);

    return (right > left && bottom > top);
    
  }

}
