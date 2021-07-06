import peasy.*;
import toxi.geom.*;

PeasyCam cam;

ArrayList pts;
ArrayList agentList;
ArrayList crvList;

int gens = 100;

void setup() {
  size(1920, 1080, P3D);
  cam = new PeasyCam(this, 250);  
  pts = new ArrayList();
  agentList = new ArrayList();
  crvList = new ArrayList();
  importPts("pts1.txt", 1);
  importPts("pts2.txt", 2);
  importPts("pts3.txt", 3);
  importCrvs("crvs.txt");
  println(agentList.size());
  frameRate(15);
}

void draw() {
  background(0);
  for (int i = 0; i < pts.size(); i++) {
    Vec3D me  = (Vec3D) pts.get(i);
    stroke(0, 255, 255);
    point(me.x, me.y, me.z);
  }
  int allDead = 0;
  for (int i = 0; i < agentList.size(); i++) {
    agent me = (agent) agentList.get(i);
    if (me.death) {
      me.update();
      allDead++;
    }
    me.render();
  }
  
  if(allDead < 10 || frameCount > gens){
    exportAgents();
    //exit();
  }
}
