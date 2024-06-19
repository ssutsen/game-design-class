
//for mode change
String window_current = "menu";
String textTutorial = "遊戲說明:\n\n歡迎來到果實學園!\n在這個學園我們會教你許多的英文單字，你可以使用方向鍵操控角色蒐集果實，蒐集到的果時會組合成單字，變成字卡。想要稱霸果實學園，就多多蒐集字卡，成為英文大師!\n\n當然，我們果實學園也是有測驗的! 在挑戰模式中，你可以點選字卡來進行測驗，你必須按照字母順序蒐集果實，否則就會遊戲失敗。別擔心，我們會幫你複習不熟的單字，你一定能學好這些單字的!\n\n祝你學習順利 ~";
String textAbout = "製作人員名單\n\n許庭豪\n主程式設計、統整\n\n郭語新\n程式設計\n\n李苡嘉\n圖片、美編\n\n林鈺茹\n程式設計、上台報告\n\n王依仁\n主視覺圖片、美編、簡報製作\n\n陳思岑\n圖片、美編、簡報製作";

//UI size declare
//the first b means button
int titleX, titleY, titleH, titleW;
int bStartX, bStartY, bStartH, bStartW;
int bHardX, bHardY, bHardH, bHardW;
int bTorialX, bTorialY, bTorialH, bTorialW;
int bAboutX, bAboutY, bAboutH, bAboutW;
int torialX, torialY, torialH, torialW;
int bH, bW;

PFont TCSmall, TCBig, TCHuge;

void menu() {
  frameRate(60); 
  if (window_current == "menu") {
    //draw title, 3buttons, maybe login?
     drawStartBG();
     menuBg.play();
    // title
    pushMatrix();
    translate(titleX, titleY);
    image(billboardImage, -100, -80);
    popMatrix();

    // game start
    pushMatrix();
    translate(bStartX, bStartY);
    image(startImage, -60, -50);
    popMatrix();

    // hard mode
    /*pushMatrix();
    translate(bHardX, bHardY);
    image(hardImage, -50, -50);
    popMatrix();*/

    // tutorial
    pushMatrix();
    translate(bTorialX, bTorialY);
    image(introductionImage, -40, -50);
    popMatrix();
    
    // about
    pushMatrix();
    translate(bAboutX, bAboutY);
    noStroke();
    fill(#E8E8E8);
    rect(0,0,90,35);
    textFont(TCSmall);
    fill(#4D4D4D);
    text("關於我們", 10, 10, torialW - 10, torialH - 10);
    //image(hardImage, -40, -50);
    popMatrix();

    //detect input (clicked on button)
    //and mode change

    if (mousePressed) {
      //start button
      if (mouseX > bStartX && mouseX < bStartX + bStartW && mouseY > bStartY && mouseY < bStartY + bStartH) {
        window_current = "game";
        fill(#FFFFFF);
        rect(0,0,width,height);
        menuBg.unmute();
        button.play();
        button.rewind();
        gameBg.play();
        gameBg.rewind();
      }

      //hard button
      /*else if (mouseX > bHardX && mouseX < bHardX + bHardW && mouseY > bHardY && mouseY < bHardY + bHardH) {
        window_current = "hard";
        fill(#FFFFFF);
        rect(0,0,width,height);
      }*/

      //tutorial button
      else if (mouseX > bTorialX && mouseX < bTorialX + bTorialW && mouseY > bTorialY && mouseY < bTorialY + bTorialH) {
        window_current = "tutorial";
        fill(#FFFFFF, 80);
        rect(0,0,width,height);
        button.play();
        button.rewind();
      }
      
      //about us
      else if (mouseX > bAboutX && mouseX < bAboutX + bAboutW && mouseY > bAboutY && mouseY < bAboutY + bAboutH) {
        window_current = "about";
        fill(#FFFFFF, 80);
        rect(0,0,width,height);
        button.play();
        button.rewind();
      }
    }
    fill(#000000);
  } /*else if (window_current == "tutorial") {
    //draw title, 3buttons, maybe login, draw grey, tutorial
    //detect input (mouse clicked on non-grey space)
    //and mode change (back to menu)
    pushMatrix();
    fill(#FFFFFF);
    translate(torialX, torialY);
    rect(0, 0, torialW, torialH);
    fill(#000000);
    textFont(TCSmall);
    text(textTutorial, 10, 10, torialW - 10, torialH - 10);
    popMatrix();
    textAlign(CENTER);
    textFont(TCSmall);
    fill(#A0A0A0);
    text(" 點擊教學外任意處關閉", width/2, 570);
    textAlign(LEFT);
    if (mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      drawStartBG();
    }
  } else if (window_current == "game") {
    textAlign(CENTER);
    text("game", width/2, height/2);
    textAlign(LEFT);
    if(mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      drawStartBG();
    }
  } else if (window_current == "hard") {
    textAlign(CENTER);
    text("hard", width/2, height/2);
    textAlign(LEFT);
    if(mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      drawStartBG();
    }
  }*/
}

void drawStartBG() {
  // rewrite this func after BG picture finish
  image(startBackgroundImage, 0, 0);
}

void win(){
  gameBg.unmute();
  winBg.play();
  drawStartBG();
  pushMatrix();
    fill(#FFFFFF);
    translate(torialX, torialY);
    rect(0, 0, torialW, torialH);
    textFont(TCBig);
    fill(#000000);
    text("成功通關!!!", 10, 40);
    textFont(TCSmall);
    text("今天的收穫:", 10, 90);
    for (int i = 0; i < eatenWordsCount; i++){
      text(words[eatenWordIndices[i]].getInfo(), 10, (i+1)*30+120);
    }
    popMatrix();
    textAlign(CENTER);
    textFont(TCSmall);
    fill(#A0A0A0);
    text(" 點擊白框外任意處關閉", width/2, 570);
    textAlign(LEFT);
    if (mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      restartGame();
      drawStartBG();
    }
}

void gameOver() {
  menuBg.play();
  drawStartBG();
  pushMatrix();
    fill(#FFFFFF);
    translate(torialX, torialY);
    rect(0, 0, torialW, torialH);
    textFont(TCBig);
    fill(#000000);
    text("再接再厲!!!", 10, 40);
    textFont(TCSmall);
    text("今天學到的單字:", 10, 90);
    for (int i = 0; i < eatenWordsCount; i++){
      text(words[eatenWordIndices[i]].getInfo(), 10, (i+1)*30+120);
    }
    popMatrix();
    textAlign(CENTER);
    textFont(TCSmall);
    fill(#A0A0A0);
    text(" 點擊白框外任意處關閉", width/2, 570);
    textAlign(LEFT);
    if (mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      restartGame();
      drawStartBG();
    }
} 

void tutorial(){
   menuBg.play();
   pushMatrix();
    fill(#FFFFFF);
    translate(torialX, torialY);
    rect(0, 0, torialW, torialH);
    fill(#000000);
    textFont(TCSmall);
    text(textTutorial, 10, 10, torialW - 10, torialH - 10);
    popMatrix();
    textAlign(CENTER);
    textFont(TCSmall);
    fill(#A0A0A0);
    text(" 點擊教學外任意處關閉", width/2, 570);
    textAlign(LEFT);
    if (mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      drawStartBG();
      button.play();
    }
}

void about() {
  menuBg.play();
  pushMatrix();
    fill(#FFFFFF);
    translate(torialX, torialY);
    rect(0, 0, torialW, torialH);
    fill(#000000);
    textFont(TCSmall);
    text(textAbout, 10, 10, torialW - 10, torialH - 10);
    popMatrix();
    textAlign(CENTER);
    textFont(TCSmall);
    fill(#A0A0A0);
    text(" 點擊名單外任意處關閉", width/2, 600);
    textAlign(LEFT);
    if (mousePressed && !(mouseX > torialX && mouseX < torialX + torialW && mouseY > torialY && mouseY < torialY + torialH)) {
      window_current = "menu";
      drawStartBG();
      button.play();
    }
}
