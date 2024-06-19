int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;
int g = 0;
int h = 0;
PImage img, img2, img3;
void setup(){
  size(600, 600);
  img = loadImage("流れ星.png");
  img2 = loadImage("流れ星-1.png");
  img3 = loadImage("月と星.png");
  PFont Tfont;
  Tfont = createFont("DotGothic16-Regular-2.ttf", 14);
  textFont(Tfont);
};

void draw(){
  background(#070625);
  fill(#ffffff);
  text("HW2_2D點陣彩圖置入及換圖以及自體旋轉繪圖物件, 41071110H, 陳思岑", 70, 30);
  fill(#E0A420);
  planet(300, 300, 50);
  
  image(img3, 100, 100, width/8, height/8);
  
  noFill();
  stroke(#ffffff);
  arc(300, 300, 80, 80, 0, TWO_PI);
  if(a < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(a));
    planet(28, 28, 10);
    popMatrix();
    a += 8;
  }else{
    a = 0;
  }
  
  stroke(#8F7A61);
  arc(300, 300, 110, 110, 0, TWO_PI);
    if(b < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(b));
    planet(40, 40, 15);
    popMatrix();
    b += 7;
  }else{
    b = 0;
  }
  
  
  stroke(#496C4B);
  arc(300, 300, 150, 150, 0, TWO_PI);
  if(c < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(c));
    planet(53, 53, 20);
    popMatrix();
    c += 6;
  }else{
    c = 0;
  }
  
  
  stroke(#7A6464);
  arc(300, 300, 180, 180, 0, TWO_PI);
  if(d < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(d));
    planet(63, 63, 12);
    popMatrix();
    d += 5;
  }else{
    d = 0;
  }
  
  stroke(#96967D);
  arc(300, 300, 220, 220, 0, TWO_PI);
  if(e < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(e));
    planet(78, 78, 30);
    popMatrix();
    e += 4;
  }else{
    e = 0;
  }
  
  stroke(#5C5656);
  arc(300, 300, 260, 260, 0, TWO_PI);
  if(f < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(f));
    planet(93, 93, 30);
    popMatrix();
    f += 3;
  }else{
    f = 0;
  }
  
  stroke(#4D7A9A);
  arc(300, 300, 300, 300, 0, TWO_PI);
  if(g < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(g));
    planet(106, 106, 20);
    popMatrix();
    g += 2;
  }else{
    g = 0;
  }
  
  stroke(#558987);
  arc(300, 300, 340, 340, 0, TWO_PI);
  if(h < 360){
    pushMatrix();
    translate(300, 300);
    rotate(radians(h));
    planet(120, 120, 22);
    popMatrix();
    h++;
  }else{
    h = 0;
  }
  
  imageMode(CENTER);
  if(mousePressed){
    image(img2,mouseX,mouseY,100,100);
  }
  else{
    image(img,mouseX,mouseY,100,100);
  }
 
};

void planet(int X, int Y, int Size) {
  circle(X, Y, Size);
}
