void calculateFlow(){
  int stepX = floor(img1.width/(float(bucketSize)*stride));
  int stepY = floor(img1.height/(float(bucketSize)*stride));
  PImage startBucket = createImage(bucketSize,bucketSize,RGB);
  PImage tempImg = createImage(bucketSize,bucketSize,RGB);
  //loop through every bucket in img1
  for(int m = 0; m < stepX; m++){
     for(int n = 0; n < stepX; n++){
       int sX = int(m*stride*bucketSize);
       int sY = int(n*stride*bucketSize);
       startBucket = img1.get(sX,sY,bucketSize,bucketSize);
  
      int closX = 0;
      int closY = 0;
      float closDistance = 28267;
      float maxDistance = 28267;
      for(int i = 0; i < stepX; i++){
        for(int j = 0; j < stepY; j++){
          int x = int(i*stride*bucketSize);
          int y = int(j*stride*bucketSize);
          tempImg = img2.get(x,y,bucketSize,bucketSize);
          tempImg.loadPixels();
          startBucket.loadPixels();
          float totDis = 0;
          for(int k = 0; k < tempImg.pixels.length; k++){
            float r1 = startBucket.pixels[k] >> 16 & 0xFF;
            float r2 = tempImg.pixels[k] >> 16 & 0xFF;
            float g1 = startBucket.pixels[k] >> 8 & 0xFF;
            float g2 = tempImg.pixels[k] >> 8 & 0xFF;
            float b1 = startBucket.pixels[k] >> 0xFF;
            float b2 = tempImg.pixels[k] >> 0xFF;
            float dis = (r1-r2)*(r1-r2) + (g1-g2)*(g1-g2) + (b1-b2)*(b1-b2);
            //dis = pow(dis,.5);
            totDis += dis;        
          }
          tempImg.updatePixels();
          startBucket.updatePixels();
          totDis = pow(totDis,.5);
          if(i == 0 && j == 0){
            closDistance = totDis;
            closX = x;
            closY = y;
          }
          if(totDis < closDistance){
            closDistance = totDis;
            
            closX = x;
            closY = y;
                       
          }  
        }  
      }
      PVector dir = new PVector(closX, closY);
      dir.sub(new PVector(sX,sY));
      vectorGrid[m][n] = dir.copy();
      
    }
  }
  
  
}
