int scl = 50; 
int cols, rows; 
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Snake snake;
Food food;
int frameRate = 5; 
int score = 0;
boolean gameover = false;
int lastKeyCode = RIGHT; 
PImage backgroundImage;
PImage treeImage;
float x,y;

void setup() {
  size(600, 600);
  frameRate(frameRate); 
  cols = width / scl;
  rows = height / scl;
  snake = new Snake();
  food = new Food();
  food.pickLocation();
  backgroundImage = loadImage("Background.png");
  backgroundImage.resize(600, 600);
  treeImage = loadImage("tree.png");
  treeImage.resize(scl, scl);
  for (int i = 0; i < 3; i++) {
    float x = (floor(random(cols)) * 50) ;
    float y = (floor(random(rows)) * 50) ; 
    obstacles.add(new Obstacle(x, y));
  }
}

void draw() {
  if (!gameover) {
    image(backgroundImage, 0, 0);
    for (Obstacle obstacle : obstacles) {
      obstacle.move();
      obstacle.show();
    }
    snake.update();
    snake.show();
    food.show();
    displayScore();
    
  }
}

void keyPressed() {
  if (!gameover) {
    if (keyCode == UP && lastKeyCode != DOWN) {
      snake.dir(0, -1);
      lastKeyCode = UP;
    } else if (keyCode == DOWN && lastKeyCode != UP) {
      snake.dir(0, 1);
      lastKeyCode = DOWN;
    } else if (keyCode == LEFT && lastKeyCode != RIGHT) {
      snake.dir(-1, 0);
      lastKeyCode = LEFT;
    } else if (keyCode == RIGHT && lastKeyCode != LEFT) {
      snake.dir(1, 0);
      lastKeyCode = RIGHT;
    }
  }
}

void gameOver() {
  textSize(32);
  fill(255);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);
  noLoop(); 
}

void restartGame() {
  gameover = false;
  snake = new Snake();
  food = new Food();
  food.pickLocation();
  loop(); 
}

void displayScore() {
  textSize(20);
  fill(255);
  textAlign(RIGHT);
  text("Score: " + score, width - 10, 20);
}
//蛇
class Snake {
  ArrayList<PVector> body = new ArrayList<PVector>();
  int x = 0;
  int y = 0;
  int xspeed = 1;
  int yspeed = 0;

  Snake() {
    body.add(new PVector(x, y));
  }

void update() {
  x = x + xspeed * scl;
  y = y + yspeed * scl;

  x = constrain(x, 0, width - scl);
  y = constrain(y, 0, height - scl);

  PVector head = new PVector(x, y);
  
  // Check for collision with own body
  for (int i = 0; i < body.size(); i++) {
    PVector part = body.get(i);
    if (head.x == part.x && head.y == part.y) {
      gameOver();
      gameover = true;
      break;
    }
  }

  PVector tail = body.get(0).copy();
  tail.set(x, y);
  body.add(tail);

  // Check if the snake eats the food
  if (x == food.x && y == food.y) {
    food.pickLocation();
    score++;
  } else {
    body.remove(0);
  }
}

void show() {
    fill(255);
    for (PVector v : body) {
      rect(v.x, v.y, scl, scl);
    }
  }

  void dir(int x, int y) {
    xspeed = x;
    yspeed = y;
  }
  int getLastKeyCode() {
    return lastKeyCode;
  }
}
//食物
class Food {
  int x, y;

  void pickLocation() {
    x = floor(random(cols)) * scl;
    y = floor(random(rows)) * scl;
  }

  void show() {
    fill(255, 0, 100);
    rect(x, y, scl, scl);
  }
}
//障礙
class Obstacle {
  float x, y;
  
  Obstacle(float x, float y) {
    this.x = x;
    this.y = y;
    println("Obstacle created at (" + x + ", " + y + ")");
  }
   void move() {
    int lastKeyCode = snake.getLastKeyCode();
    if (lastKeyCode == UP) {
      y += 50; 
    } else if (lastKeyCode == DOWN) {
      y -= 50; 
    } else if (lastKeyCode == LEFT) {
      x += 50; 
    } else if (lastKeyCode == RIGHT) {
      x -= 50; 
    }
  }
  void show() {
    image(treeImage, x, y);
  }
}
