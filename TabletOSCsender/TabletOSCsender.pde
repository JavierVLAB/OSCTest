import ketai.net.wifidirect.*;

import ketai.net.*;
import ketai.ui.*;
import oscP5.*;
import netP5.*;

KetaiWiFiDirect net;
NetAddress myRemoteLocation;

OscP5 oscP5;


void setup(){
  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("192.168.0.198",8000);
}

void draw(){
    background(0);
}

void mouseDragged()
{
  ellipse(mouseX,mouseY,20,20);

  OscMessage m = new OscMessage("/cursor");
  m.add(mouseX);
  m.add(mouseY);
  oscP5.send(m, myRemoteLocation);
}



