void setup() {
  size(400, 600); 
  PFont JPfont;
  PFont Tfont;
  JPfont = createFont("DotGothic16-Regular.ttf", 20);
  Tfont = createFont("DotGothic16-Regular-2.ttf", 14);
  textFont(JPfont);
  textFont(Tfont);
}

void draw() {
  background(255); 
  fill(#E1343A);
  rect(100, 50, 200, 200);
  
  textSize(14);
  fill(#000000);
  text("HW1_向量繪圖造型練習, 41071110H, 陳思岑", 70, 30);
  textSize(20);
  fill(#ffffff);
  text("アンパンマン", 140, 70);
  // head
  fill(#DA9E6F); 
  strokeWeight(2);
  ellipse(200, 150, 100, 100);


  // eye
  fill(#633523);
  ellipse(185, 130, 10, 20);
  ellipse(215, 130, 10, 20);

  // mouse
  noFill();
  arc(200, 162, 50, 36, QUARTER_PI, PI-QUARTER_PI);

  // nose  
  fill(#D5644F);
  //rotate(PI/10.0);
  ellipse(173, 157, 25, 30);
  ellipse(227, 157, 25, 30);


  fill(#CB4B39);
  ellipse(200, 155, 33, 30);
  
  //eyebrow
  noFill();
  arc(185, 135, 25, 50, QUARTER_PI+PI, TWO_PI-QUARTER_PI);
  arc(215, 135, 25, 50, QUARTER_PI+PI, TWO_PI-QUARTER_PI);
  
  //reflect
  noStroke();
  fill(#E2E5DD);
  rect(200, 150, 5, 4);
  rect(220, 152, 5, 4);
  rect(175, 153, 5, 4);
  
  stroke(2);
  
  //hand
  fill(#EBD336);
  ellipse(250, 190, 10, 20);
  ellipse(270, 190, 10, 20);
  ellipse(260, 210, 40, 35);
  //arc(260, 210, 40, 35, PI+PI/4, PI+PI/4+PI/6);
  noFill();
  arc(265, 205, 13, 10, HALF_PI, HALF_PI+PI);

  
}
