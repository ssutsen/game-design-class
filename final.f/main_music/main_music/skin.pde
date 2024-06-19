void snakeSkin(){
  randomNumber = int(random(1, 5));
  if(randomNumber == 1){
    Skin = Skin1;
  }
  if(randomNumber == 2){
    Skin = Skin2;
  }
  if(randomNumber == 3){
    Skin = Skin3;
  }
  if(randomNumber == 4){
    Skin = Skin4;
  }
 
}
void foodSkin(){
  randomNumber = int(random(1, 6));
  if(randomNumber == 1){
    foodImage = appleImage;
  }
  if(randomNumber == 2){
    foodImage = strawberryImage;
  }
  if(randomNumber == 3){
    foodImage = peachImage;
  }
  if(randomNumber == 4){
    foodImage =  mongoImage;
  }
  if(randomNumber == 5){
    foodImage = orangeImage;
  }
  if(fSkin == false){
    fSkin = true;
  }
}
