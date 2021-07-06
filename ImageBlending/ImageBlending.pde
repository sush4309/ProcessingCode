PImage img1;
PImage moveImg;
PImage img2;

PVector[][] vectorGrid;


int bucketSize = 64;
float stride = 1;
int bx = 0;
int by = 0;
float threshold = .25;

void setup() {
  size(1024, 1024);
  background(255);
  img1 = loadImage("Facade_1.png");
  moveImg = img1.copy();
  img2 = loadImage("Facade_2.png");
  
  int dimx = floor(img1.width/(bucketSize*stride));
  int dimy = floor(img1.height/(bucketSize*stride));
  
  vectorGrid = new PVector[dimx][dimy];
  
  image(img1,0,0);
  calculateFlow();
  
  
}

void draw() {
  image(img1,0,0);
  img1.loadPixels();
  img2.loadPixels();
  moveImg.loadPixels();
  
  for(int x = 0; x < img1.width; x++){
    for(int y = 0; y < img1.height; y++){
      //get the color of image 1 at the current x y
      int index = floor(x+y*img1.width);
      int col1 = img1.pixels[index];
      
      //calculate the target pixels in image2 based on our vector field
      int gridx = int(float(x)/bucketSize);
      int gridy = int(float(y)/bucketSize);
      
      if(gridx > vectorGrid.length-1){
        gridx = vectorGrid.length-1;
      }
      if(gridy > vectorGrid.length-1){
        gridy = vectorGrid.length-1;
      }
      PVector temp = vectorGrid[gridx][gridy].copy();
      //temp.normalize();
      temp.mult(.01);
      if(temp.x < -.4){
        temp.x = -1;
      }
      if(temp.x > -.4){
        temp.x = 1;
      }
      if(temp.y < -.4){
        temp.y = -1;
      }
      if(temp.y > -.4){
        temp.y = 1;
      }
      int x2 = int(x + temp.x);
      int y2 = int(y + temp.y);
      if(x2 >= 0 && x2 < img1.width && y2 >= 0 && y2 < img1.height){
        int index2 = floor(x2+y2*img1.width);
        moveImg.pixels[index2] = lerpColor(col1,img2.pixels[index2],.1);
        
      }
    }
  }
  
  moveImg.updatePixels();
  img1.updatePixels();
  img2.updatePixels();
  image(moveImg,0,0);
  img1 = moveImg.get();
  saveFrame();
}
