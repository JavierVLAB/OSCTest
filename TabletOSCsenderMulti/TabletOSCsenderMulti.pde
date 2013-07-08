import ketai.net.wifidirect.*;
import android.view.MotionEvent;
import ketai.net.*;
import ketai.ui.*;
import oscP5.*;
import netP5.*;

KetaiWiFiDirect net;
NetAddress myRemoteLocation;

OscP5 oscP5;
int ntoques;
boolean activo = false;

Puntos[] p;

int[] c = {
  color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), color(0, 255, 255), color(255, 0, 255), 
  color(255, 128, 0), color(255, 0, 128), color(0, 255, 128), 
  color(0, 128, 255), color(128, 0, 255), color(128, 255, 0)
}; 

void setup() {
  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("192.168.0.198", 8000);
  p = new Puntos[14];
  for (int i = 0; i<14;i++) {
    p[i] = new Puntos();
  }
}

void draw() {
  background(0);
  if(activo){
    OSCenvia();}
  //println(ntoques);
  activo = false;
}

//void mouseDragged()
//{
//  //ellipse(mouseX, mouseY, 20, 20);
//
//  OscMessage m = new OscMessage("/cursor");
//  m.add(mouseX);
//  m.add(mouseY);
//  oscP5.send(m, myRemoteLocation);
//}

public boolean surfaceTouchEvent(MotionEvent me) {
  activo = true;
  ntoques = me.getPointerCount();

  for (int i = 0; i<ntoques; i++) {
    p[i].Id = me.getPointerId(i);
    p[i].x = me.getX(i);
    p[i].y = me.getY(i);

    fill(c[p[i].Id]);
    ellipse(p[i].x, p[i].y, 50, 50);
  }


  return super.surfaceTouchEvent(me);
}

class Puntos {
  float x;
  float y;
  int Id;

  Puntos() {
    x = 0;
    y = 0;
    Id = 0;
  }
}

void OSCenvia() {

  if (ntoques >0) { 
    OscMessage m = new OscMessage("/cursor");
    for (int i= 0; i<ntoques;i++) {
      m.add(p[i].Id);
      m.add(p[i].x);
      m.add(p[i].y);
    }
    oscP5.send(m, myRemoteLocation);
  }
}

