void importTiles() {

  PVector pos = new PVector();
  color c = color(255, 255, 255);
  for (int i = 1; i <= 19; i++) {
    tile t = new tile();
    String fName = i +".txt";
    println(fName);
    String[] lines = loadStrings(fName);
    for (int j = 0; j < lines.length; j+=100) {
      //lines[j] = lines[j].replaceAll("^\"|\"$", "");

      String[] row = lines[j].split(",");

      float x = float(row[0].replaceAll("^\"|\"$", ""));
      float y = float(row[1].replaceAll("^\"|\"$", ""));
      float z = float(row[2].replaceAll("^\"|\"$", ""));
      x = abs(x);
      y = abs(y);
      z = abs(z);
      pos.x = x;
      pos.y = y;
      pos.z = z;
      if (pos.x >1024 || pos.y >1024) {
        println(pos);
      }
      float r = float(row[3].replaceAll("^\"|\"$", ""));
      float g = float(row[4].replaceAll("^\"|\"$", ""));
      float b = float(row[5].replaceAll("^\"|\"$", ""));
      c = color(r, g, b);
      t.posList.add(pos.copy());
      t.colList.add(c);
    }
    catalog.add(t);
  }
}

void placeTiles() {
  PImage bucket;
  
  color c;
  for (int x = 0; x < img.width; x+=bucketSize) {
    for (int y = 0; y < img.height; y+=bucketSize) {
      // println(x+"," +y);
      bucket = img.get(x, y, bucketSize, bucketSize);
      //println(bucket.width);
      // println(bucket.height);
      //println(bucket.pixels.length);
      float closeDis = 460000.0;
      int closeIndex = 0;
      bucket.loadPixels();
      for (int i = 0; i < catalog.size(); i++) {
        tile t = (tile) catalog.get(i);
        float totDis = 0;
        for (int j = 0; j < t.posList.size(); j+=10) {
          PVector pos = (PVector) t.posList.get(j);
          //println(pos);
          float x1 = floor(pos.x/tileFactor);
          float y1 = floor(pos.y/tileFactor);
          //println(pos.y);
          //println(y1);
          int index = floor(x1 + y1*bucket.width);
          c = (color) t.colList.get(j);

          float r1 = bucket.pixels[index] >> 16 & 0xFF;
          float r2 = c >> 16 & 0xFF;
          float g1 = bucket.pixels[index] >> 8 & 0xFF;
          float g2 = c >> 8 & 0xFF;
          float b1 = bucket.pixels[index] >> 0xFF;
          float b2 = c >> 0xFF;
          float dis = (r1-r2)*(r1-r2) + (g1-g2)*(g1-g2) + (b1-b2)*(b1-b2);
          //dis = pow(dis,.5);
          totDis += dis;
        }
        totDis =  pow(totDis, .5);
        if (totDis < closeDis) {
          closeDis = totDis;
          closeIndex = i;
        }
      }
      tile good = (tile) catalog.get(closeIndex);
      for (int i = 0; i < good.posList.size(); i+=1) {
        PVector temp = (PVector) good.posList.get(i);
        PVector pos = temp.copy();
        pos.x += x*tileFactor;
        pos.y += y*tileFactor;
        ptCloudPos.add(pos.copy());
        c = (color) good.colList.get(i);
        ptCloudCol.add(c);
      }
      bucket.updatePixels();
    }
  }
}
