import peasy.*;

PeasyCam cam;

PImage img;

int bucketSize = 128;
float tileFactor = 8;

ArrayList catalog;
ArrayList ptCloudPos;
ArrayList ptCloudCol;

void setup(){
  size(1280,720,P3D);
  cam = new PeasyCam(this, 1000);
  img = loadImage("p10_1.png");
  
  catalog = new ArrayList();
  ptCloudPos  = new ArrayList();
  ptCloudCol = new ArrayList();
  
  importTiles();
  
  placeTiles();
  
  exportPoints();
  println("I exported");
}

void draw(){
  background(0);
  image(img,0,0);
  
  PVector pos;
  color c ;
  for(int i = 0; i < ptCloudPos.size(); i++){
    pos = (PVector) ptCloudPos.get(i);
    c = (color) ptCloudCol.get(i);
    stroke(c);
    point(pos.x,pos.y, pos.z);
  }
}
