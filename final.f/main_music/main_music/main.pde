void draw() {
  if(!gameover && window_current == "menu") {
    menu();
  }
  if(!gameover && window_current == "tutorial") {
    tutorial();
  }
  if(!gameover && window_current == "about") {
    about();
  }
  if (!gameover && window_current == "game") {
    menuBg.unmute();
    gameBg.play();
    gameBg.rewind();
    frameRate(frameRate); 
    image(backgroundImage,0,0);
    snake.update();
    snake.show();
    food.show();
    for (Obstacle obs : obstacles) {
      obs.show();
    }
    displayScore();
    displayLives();
    displayword();
  }
   if (!gameover && window_current == "win"){
     win();
     winBg.play();
   }
   if (window_current == "gameover"){
     gameOver();
     dead.play();
   }
   
}

void keyPressed() {
  if (!gameover) {
    if ((keyCode == UP || key == 'W' || key == 'w') && lastKeyCode != DOWN) {
      snake.dir(0, -1);
      lastKeyCode = UP;
    } else if ((keyCode == DOWN || key == 'S' || key == 's') && lastKeyCode != UP) {
      snake.dir(0, 1);
      lastKeyCode = DOWN;
    } else if ((keyCode == LEFT || key == 'A' || key == 'a') && lastKeyCode != RIGHT) {
      snake.dir(-1, 0);
      lastKeyCode = LEFT;
    } else if ((keyCode == RIGHT || key == 'D' || key == 'd') && lastKeyCode != LEFT) {
      snake.dir(1, 0);
      lastKeyCode = RIGHT;
    }
  }
}

void restartGame() {
  gameover = false;
  lives = 6; 
  score = 0;
  eatenWordsCount = 0;
  snake = new Snake();
  snakeSkin();
  pickword();
  foodSkin();
  food = new Food(words[selectedWordIndex]);
  obstacles = new Obstacle[3];
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i] = new Obstacle();
    obstacles[i].pickLocation();
  }
  food.pickLocation();
  loop(); 
}

void displayScore() {
  fill(255);
  rect(0, 600, 600, 700);
  textSize(20);
  fill(0);
  textAlign(RIGHT);
  text("Score: " + score, width - 10, 620);
}

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
  y = constrain(y, 0, 600 - scl);

  PVector head = new PVector(x, y);
  
  // Check for collision with own body
  for (int i = 0; i < body.size() ; i++) {
    PVector part = body.get(i);
    if (head.x == part.x && head.y == part.y) {
      window_current = "gameover";
      gameover = true;
      break;
    }
  }
  
  for (Obstacle obs : obstacles) {
      if (head.x == obs.x && head.y == obs.y) {
        lives--; // 碰撞障碍物减少生命值
        dead.play();
        dead.rewind();
        if (lives <= 0) {
          window_current = "gameover";
          gameover = true;
        } else {
            obs.pickLocation();
        }
        break;
      }
    }

  PVector tail = body.get(0).copy();
  tail.set(x, y);
  body.add(tail);

  // Check if the snake eats the food
  if (x == food.x && y == food.y) {
    food.nextChar();
    fSkin = false;
    foodSkin();
    snakeSkin();
    food.pickLocation();
    score++;
    eat.play();
    eat.rewind();
    if (food.currentCharIndex == 0) { // 如果已经吃完所有字母
        eatenWordIndices[eatenWordsCount] = selectedWordIndex; 
        eatenWordsCount++;
        if (eatenWordsCount == 4) { 
          window_current = "win";
        } else {
          pickword();
          food = new Food(words[selectedWordIndex]);
          food.pickLocation();
        }
      }
  } else {
    body.remove(0);
  }
}

void show() {
    fill(255);
    for (PVector v : body) {
      image(Skin, v.x, v.y);
    }
  }

  void dir(int x, int y) {
    xspeed = x;
    yspeed = y;
  }
}

class Food {
  int x, y;
  Word word;
  int currentCharIndex;
  
   Food(Word word) {
    this.word = word;
    this.currentCharIndex = 0;
  }

 void pickLocation() {
    boolean validLocation;
    do {
      x = floor(random(cols)) * scl;
      y = floor(random(rows)) * scl;
      validLocation = true;
      // Check if the new location is occupied by an obstacle
      for (Obstacle obs : obstacles) {
        if (x == obs.x && y == obs.y) {
          validLocation = false;
          break;
        }
      }
    } while (!validLocation);
  }

  void nextChar() {
    currentCharIndex = (currentCharIndex + 1) % word.letters.length;
  }

  void show() {
    fill(255, 0, 100);
    image(foodImage,x,y);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(word.letters[currentCharIndex], x + scl / 2, y + scl / 2);
  }
}

class Obstacle {
  int x, y;

  void pickLocation() {
    boolean validLocation;
    do {
      x = floor(random(cols)) * scl;
      y = floor(random(rows)) * scl;
      validLocation = true;
      // Check if the new location is occupied by the food
      if (x == food.x && y == food.y) {
        validLocation = false;
      }
    } while (!validLocation);
  }

  void show() {
    fill(150);
    image(obstacleImage ,x ,y);
  }
}

void displayLives() {
  textSize(20);
  fill(0);
  textAlign(LEFT);
  text("Lives: " + lives, 10, 620);
}
