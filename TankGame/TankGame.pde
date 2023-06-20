import java.util.Iterator;

// Game state
enum GameState {
  BEFORE, PLAYING, AFTER 
}
GameState state;

// Physics
PVector wind = new PVector(0f, 0f);
PVector gravity = new PVector(0f, .1f);
final float DAMPING = .995F;

// Game objects
Tank tank1, tank2;
ArrayList<Obstacle> obstacles;
Shell shell;

// Game controls
boolean player1Turn;
boolean fire;  // flag to determine if the projectile is fired or not

// To control floor
int bottomHeight;

float xoff = 0.0;
float yoff = 0.0;

void setup() {
  size(800, 600);
  bottomHeight = height - 50;
  
  state = GameState.BEFORE;
  initialize();
}

void initialize() {
  //initialise every value
  player1Turn = true;
  shell = null;
  fire = false;
  
  // setup terrain
  createTanks();
  createObstacles();
}

void createTanks() {
  tank1 = new Tank(100, bottomHeight - Tank.height);
  tank2 = new Tank(width - 100, bottomHeight - Tank.height);
  tank2.angle = 45 + 90;
}

void createObstacles() {
  obstacles = new ArrayList<Obstacle>();
  // bh = block height
  for(int bh = 0; bh < 3; bh++) {
    for (int i = 200 + Obstacle.width*bh; i < width - 200 - Obstacle.width*(bh+1); i+=Obstacle.width) {
      obstacles.add(new Obstacle(i, bottomHeight - Obstacle.height*(bh+1)));
    }
  }
}
// enum in draw and keypress
void draw() {
  // sky and ground
  background(230, 255, 255);
  fill(255, 224, 179);
  rect(0, bottomHeight, width, height - bottomHeight);
  
  // terrain
  drawCloud();
  stroke(0);
  drawTanks();
  drawObstacles();
  
  
  // information
  showDetails();
  
  // shooting shells
  if (fire) {
    updateShells();
  }
  
}

boolean gameOver() {
  return tank1.isDead() || tank2.isDead();
}

void showDetails() {
  fill(0);
  switch(state) {
    case BEFORE:
      textSize(64);
      textAlign(CENTER);
      text("Welcome to Artillery", width/2, height/2 -100);
      textSize(32);
      text("To play press Enter", width/2, height/2 - 40);
      break;
    case PLAYING:
      textSize(16);
      textAlign(LEFT);
      Tank playerTank = player1Turn ? tank1 : tank2;
      text(player1Turn ? "Player 1's Turn" : "Player 2's Turn", 40, 100);
      text("Player HP: " + tank1.hp + " | " + tank2.hp, 40, 120);
      text("Angle: " + playerTank.angle, 40, 140);
      text("Speed: " + playerTank.speed, 40, 160);
      text("Wind speed: " + wind.mag(), 40, 180);
      text("Wind direction: " + wind.heading(), 40, 200);
      break;
    case AFTER:
      textSize(64);
      textAlign(CENTER);
      text("Player " + (tank1.isDead() ? "2":"1") + "'s VICTORY!", width/2, height/2 -100);
      textSize(32);
      text("To play again press Enter", width/2, height/2 - 40);
      break;
    default:
  }
  
}

void drawTanks() {
  tank1.display();
  tank2.display();
}


void drawObstacles() {
  for(int i = 0; i < obstacles.size(); i++) {
    fill(255, 204, 153);
    obstacles.get(i).display();
  }
}

void updateShells() {
  shell.update();
  shell.display();
  if (shell.isDead()) {
    shell = null;
    fire = false;
    wind = new PVector(random(-.05f, .05f), random(-.05f, .05f));
  }
}

void drawCloud() {
  noStroke();
  fill(255);
  ellipse(200, 100, 80, 80);
  ellipse(240, 100, 70, 70);
  ellipse(280, 100, 60, 60);
  ellipse(320, 100, 50, 50);
  arc(235, 80, 80, 80, PI, TWO_PI);
  arc(280, 80, 70, 70, PI, TWO_PI);
  arc(305, 80, 50, 50, PI, TWO_PI);
  
  ellipse(width - 100, 100, 80, 80);
  ellipse(width - 140, 100, 70, 70);
  ellipse(width - 180, 100, 60, 60);
  ellipse(width - 220, 100, 50, 50);
  arc(width - 135, 80, 80, 80, PI, TWO_PI);
  arc(width - 180, 80, 70, 70, PI, TWO_PI);
  arc(width - 205, 80, 50, 50, PI, TWO_PI);

}

void keyPressed() {
  switch(state) {
    case BEFORE:
      if (keyCode == ENTER) {
          state = GameState.PLAYING;
      }
      break;
    case PLAYING:
      Tank playerTank = player1Turn ? tank1 : tank2;
      if (key == ' ' && !fire) {
          fire = true;
          shell = new Shell((int) playerTank.pos.x, (int) playerTank.pos.y, playerTank.angle, playerTank.speed);
          player1Turn = !player1Turn;
      }
      if (keyCode == LEFT) {
          playerTank.angle += 5;
      }
      if (keyCode == RIGHT) {
          playerTank.angle -= 5;
      }
      if (keyCode == UP) {
          playerTank.speed += 1;
      }
      if (keyCode == DOWN) {
          playerTank.speed -= 1;
      }
      if (key == 'a') {
          playerTank.moveX(-3);
      }
      if (key == 'd') {
          playerTank.moveX(3);
      }
      break;
    case AFTER:
      if (keyCode == ENTER) {
          initialize();
          state = GameState.PLAYING;
      }
      break;
    default:
  }
  
}
