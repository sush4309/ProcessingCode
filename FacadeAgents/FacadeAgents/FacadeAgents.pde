import peasy.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

PeasyCam cam;

ArrayList pts;
ArrayList agentList;
ArrayList crvList;

int gens = 100;
int branchGens = 10;
float speed = .5;

WETriangleMesh mesh;
ToxiclibsSupport gfx;

void setup() {
  size(1280, 720, P3D);
  
  cam = new PeasyCam(this, 150);  
  //gfx = new ToxiclibsSupport(this);
  
  pts = new ArrayList();
  agentList = new ArrayList();
  crvList = new ArrayList();
  
  mesh = new WETriangleMesh();
  importStl();
  importAgentsVerts();
  //importPts("pts1.txt", 1);
  ///importPts("pts2.txt", 2);
  //importPts("pts3.txt", 3);
  //importPts("pts4.txt", 4);
  //importPts("pts5.txt", 5);
  //importCrvs("crvs.txt");
  println(agentList.size());
  frameRate(15);
}

void draw() {
  background(255);
  lights();
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
  
  //shininess(1.0);
  noFill();
  stroke(0);
  strokeWeight(.5);
  //gfx.mesh(mesh);
  
  if( frameCount == gens){
    exportAgents();
    //exportAgentsCrvs();
    saveFrame();
    println("I exported");
    
    //exit();
  }
}
