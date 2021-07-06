import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import toxi.volume.*;
import peasy.*;
import nervoussystem.obj.*;
//////



/////file name here
String fn = "mesh.stl";

////////set box dimensions here/////
float dimx = 233;
float dimy = 252;
float dimz = 12;

float offsetX = 0;
float offsetY = 0;
float offsetZ = 0;


WETriangleMesh mesh1;
ToxiclibsSupport gfx;
PeasyCam pcam;

PVector p1;
PVector p2;
PVector L1, L2, L3, L4;

ArrayList contour;

int[][][] grid3;
int[][][] grid2;

Vec3D offset;

void setup() {
  //basic setup
  size(1000, 1000, P3D);
  smooth();
  pcam = new PeasyCam(this, 1000);
  gfx=new ToxiclibsSupport(this);
  mesh1 = new WETriangleMesh();
  offset = new Vec3D(offsetX, offsetY, offsetZ);

  //initial grid3

  grid3 = new int[int(dimx)][int(dimy)][int(dimz)];
  grid2 = new int[int(dimx)][int(dimy)][int(dimz)];
  for (int i = 0; i< grid3.length; i++) {
    for (int j =0; j < grid3[i].length; j++) {
      for (int k = 0; k < grid3[i][j].length; k++) {
        grid3[i][j][k] = 0;
        grid2[i][j][k] = 0;
      }
    }
  } 

  //import stl object from rhino
  importStl(fn, mesh1);


  for ( int i = 0; i < dimx; i++) {
    ArrayList xDir = contourCalculate( mesh1, new PVector( i, 0, 0), new PVector( i, dimy, 0)  );
    for ( int k = 0; k < dimy; k++) {
      IntList zValue = new IntList();
      for ( int j= 0; j< xDir.size ()-1; j+=2) {

        PVector cp1 = (PVector)xDir.get(j);
        PVector cp2 = (PVector)xDir.get(j+1);

        //  ArrayList objectEdgePoint = new ArrayList();




        boolean temp = isLineCrossSeg( cp1, cp2, new PVector( 0, k, 0), new PVector( dimx, k, 0));
        if ( temp) {  
          PVector edgePoint = CP( cp1, cp2, new PVector( 0, k, 0), new PVector( dimx, k, 0) );

          zValue.append(round(edgePoint.z));
        }
      }
      if (zValue.size() %2 != 0) {
        println(" unclosedMesh");
      }
      if ( zValue.size() >1 && zValue.size()%2 == 0) {
        zValue.sort();
        for ( int l = 0; l < zValue.size ()-1; l +=2) {
          int st = zValue.get(l);
          int en = zValue.get(l+1);

          if ( st < 0) st = 0;
          if ( en > dimz) en = floor(dimz);

          for ( int m = st; m < en; m++) {
            int x =  i;
            int y =  k;
            int z =  m; 
            int index = floor(x + y*dimx + z * dimx * dimy);
            grid3[x][y][z] = 1;
            grid2[x][y][z] = 1;
          }
        }
      }
      //boolean AB =isLineCrossSeg(A, B, p1, p2 );
      //boolean temp = isLineCrossSeg( cp1, cp2,
    }
  }
  downSupport();

  String fileName =new String(str(int(offset.x)) + "_" + str(int(offset.y)) + "_" + str(int(offset.z))  + "_" + "Grid3" + ".txt");
  exportGrid(fileName);
  meshGenerator();
}




void draw() {  
  background(255); 

  //three dimentions line
  strokeWeight(1);
  stroke(255, 0, 0);
  line(0, 0, 0, 500, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 500, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 500);




  for (int i = 0; i < grid3.length; i++) {
    for (int j = 0; j < grid3[i].length; j++) {
      for (int k = 0; k < grid3[i][j].length; k++) {
        if (grid3[i][j][k] != 0) {
          fill(255, 0, 0);


          stroke(0);
          strokeWeight(1);
          pushMatrix();
          translate(i, j, k);
          box(1);
          popMatrix();
        }
      }
    }
  }




  if ( keyPressed  && key == 's') {
    saveFrame();
  }

  exit();
}
