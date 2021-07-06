import nervoussystem.obj.*;
import peasy.*;

PeasyCam cam;

int[][][] grid;
int[][][] grid2;
ArrayList stressList;
int dimx = 234;
int dimy = 253;
int dimz = 12;

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 256);
  background(255);

  grid = new int[dimx][dimy][dimz];  
  grid2 = new int[dimx][dimy][dimz];
  
  stressList = new ArrayList();
  
  importGrid("grid.txt");
  importStress("stressPts.txt");
  plankMaker();
  writePlanks();
}

void draw() {
  background(255);
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[i].length; j++) {
      for (int k = 0; k < grid[i][j].length; k++) {       
        if (grid2[i][j][k] == 1) {
          stroke(255,0,255);
          float z1 = k-.5;
          float z2 = k+.5;
          //line(i,j,z1,i,j,z2);
          point(i,j,k);
        }      
        
      }
    }
  }
}
