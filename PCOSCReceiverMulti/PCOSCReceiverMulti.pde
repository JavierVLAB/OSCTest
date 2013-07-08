import oscP5.*;
import netP5.*;

OscP5 oscP5;
String addr = "/cursor";

int posX = 0, posY = 0;

void setup() {
  size(displayWidth, displayHeight);
  
  oscP5 = new OscP5(this, 8000);
  
}

void draw() {
  background(0);
  ellipse(posX, posY, 30, 30);
}

void oscEvent(OscMessage theOscMessage) {
  check(theOscMessage);
  theOscMessage.print();
}

void check(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern(addr)) {
    posX = (int) theOscMessage.get(1).floatValue();
    posY = (int) theOscMessage.get(2).floatValue();
  }
}

boolean sketchFullScreen() {
  return false;
}

