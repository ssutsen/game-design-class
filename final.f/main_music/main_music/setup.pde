int scl = 30, cols, rows;  
Snake snake;
Food food;
int frameRate = 8; 
int score = 0;
int lives = 6;
boolean gameover = false;
Obstacle[] obstacles;
int lastKeyCode = RIGHT; 
PImage backgroundImage, obstacleImage, startImage, introductionImage, hardImage, billboardImage, startBackgroundImage;
PImage appleImage, cherryImage, cobnutImage, mongoImage, orangeImage, peachImage, strawberryImage,foodImage;
PImage Skin1, Skin2, Skin3, Skin4, Skin;
int[] eatenWordIndices = new int[4]; // 记录已经成功吃掉的单词
int eatenWordsCount = 0; 
int randomNumber;
boolean fSkin = false;
Table table;  
Word[] words;  
int selectedWordIndex = -1;
import ddf.minim.*;
Minim minim;
AudioPlayer button, dead, eat, menuBg, gameBg, winBg ;


void setup() {
  table = loadTable("Vocab.csv", "header");  
  words = new Word[table.getRowCount()];  

  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    String vocab = row.getString("Vocab");
    String partOfSpeech = row.getString("詞性");
    String meaning = row.getString("meaning");
    String letters = row.getString("Vocab"); // 获取单词字母
    char[] lettersArray = letters.toCharArray(); // 将字母字符串转换为字符数组
    words[i] = new Word(vocab, partOfSpeech, meaning, lettersArray);
  }
  
  backgroundImage = loadImage("playingBackground.png");
  obstacleImage = loadImage("Tree.png");
  startImage = loadImage("開始遊戲.png");
  introductionImage = loadImage("遊戲教學.png");
  hardImage = loadImage("挑戰模式.png");
  billboardImage = loadImage("title.png");
  startBackgroundImage = loadImage("startBackground.png");
  appleImage = loadImage("apple.png");
  cherryImage = loadImage("cherry.png");
  cobnutImage = loadImage("cobnut.png");
  mongoImage = loadImage("mongo.png");
  orangeImage = loadImage("orange.png");
  peachImage = loadImage("peach.png");
  strawberryImage = loadImage("strawberry.png");
  Skin1 = loadImage("1.png");
  Skin2 = loadImage("2.png");
  Skin3 = loadImage("3.png");
  Skin4 = loadImage("4.png");
  
  backgroundImage.resize(600, 600);
  startBackgroundImage.resize(600, 700);
  billboardImage.resize(460,300);
  startImage.resize(200, 150);
  hardImage.resize(200, 150);
  introductionImage.resize(200,150);
  obstacleImage.resize(scl,scl);
  appleImage.resize(scl,scl);
  cherryImage.resize(scl,scl);
  cobnutImage.resize(scl,scl);
  mongoImage.resize(scl,scl);
  orangeImage.resize(scl,scl);
  peachImage.resize(scl,scl);
  strawberryImage.resize(scl,scl);
  Skin1.resize(scl,scl);
  Skin2.resize(scl,scl);
  Skin3.resize(scl,scl);
  Skin4.resize(scl,scl);
  
  size(600, 700);
  frameRate(frameRate); 
  cols = width / scl;
  rows = 600 / scl;
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
  
  surface.setTitle("果實學園");
  background(#E3E3E3);

  TCSmall = createFont("NotoSansTC-Regular.otf", 18);
  TCBig = createFont("NotoSansTC-Regular.otf",28);
  TCHuge = createFont("NotoSansTC-Regular.otf", 72);
  
  //UI size
  titleX = 90;
  titleY = 90;
  bW = 110;
  bH = 50;
  bStartX = titleX - 10;
  bStartY = 420;
  bStartW = bW;
  bStartH = bH;
  bHardX = (width-bW) / 2 ;
  bHardY = 420;
  bHardW = bW;
  bHardH = bH;
  bTorialX = width - bStartX - bW;
  bTorialY = 420;
  bTorialW = bW;
  bTorialH = bH;
  bAboutX = bTorialX - 30;
  bAboutY = titleY + 140;
  bAboutW = bW;
  bAboutH = bH;
  torialX = 80;
  torialY = 60;
  torialW = width - torialX*2;
  torialH = height - torialY*2;
  
  //音效
    minim = new Minim(this);
    button = minim.loadFile("botton.mp3");
    dead = minim.loadFile("dead.mp3");
    eat = minim.loadFile("eat.mp3");
    menuBg = minim.loadFile("menuBg.mp3");
    gameBg = minim.loadFile("gamingBg.mp3");
    winBg = minim.loadFile("winBg.mp3");
    
    menuBg.loop();
    //botton.loop();
}
