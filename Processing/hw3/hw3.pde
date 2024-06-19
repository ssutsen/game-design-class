import ddf.minim.*;
Minim minim;
AudioPlayer in;
PImage play, pause, unmute, mute, reload, stop, guitar;

void setup()
{
  size(300, 400);
  play = loadImage("play.png");
  pause = loadImage("pause.png");
  unmute = loadImage("unmute.png");
  mute = loadImage("mute.png");
  reload = loadImage("reload.png");
  stop = loadImage("stop.png");
  guitar = loadImage("guitar.png");
  minim = new Minim(this);
  in = minim.loadFile("The Bluest Star.mp3");
  in.play();
  in.loop();
  PFont Tfont;
  Tfont = createFont("DotGothic16-Regular-2.ttf", 14);
  textFont(Tfont);
}
void draw()
{
  background(#C4E4F5);
  stroke(#000000);
  text("HW3 [41071110H] 陳思岑 播放器", 45, 270);
  fill(#ffffff);
  rect(83, 30, 130, 130, 20); // 最后一个参数 20 表示圆角的半径
  image(guitar, 100, 50);

  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, in.bufferSize(), 0, width );
    float x2 = map( i+1, 0, in.bufferSize(), 0, width );
    //line( x1, 50 + in.left.get(i)*50, x2, 50 + in.left.get(i+1)*50 );
    line( x1, 200 + in.right.get(i)*50, x2, 200 + in.right.get(i+1)*50 );
  }

  // draw a line to show where in the song playback is currently located
  float posx = map(in.position(), 0, in.length(), 0, width);
  stroke(0, 200, 0);
  line(posx, 170, posx, 230);

  noStroke();
  fill(#000000);
  circle(150, 318, 50);

  if ( in.isMuted() )
  {
    image(unmute, 200, 305);
  } else
  {
    image(mute, 200, 305);
  }

  if ( in.isPlaying() )
  {
    image(pause, 133, 301);
  } else
  {
    image(play, 134, 300);
  }

  image(stop, 40, 310);
  image(reload, 73, 308);
}
void mousePressed()
{
  if (mouseX > 100 && mouseX < 200 && mouseY > 268 && mouseY < 368) {
    if (in.isPlaying()) {
      in.pause();
    } else {
      in.loop();
    }
  }

  if (mouseX > 174 && mouseX < 226 && mouseY > 279 && mouseY < 331) {
    if (in.isMuted()) {
      in.unmute();
    } else {
      in.mute();
    }
  }


  if (mouseX > 38 && mouseX < 53 && mouseY > 280 && mouseY < 360) {
    minim.stop();
  }
  if (mouseX > 73 && mouseX < 85 && mouseY > 280 && mouseY < 360) {
    minim.stop();
    in = minim.loadFile("The Bluest Star.mp3");
    in.play();
  }

  //int position = int( map( mouseX, 0, width, 0, in.length() ) );
  //in.cue( position );
}
