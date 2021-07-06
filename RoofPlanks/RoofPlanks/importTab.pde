void importGrid(String fName) {
  //load our text file into an array of strings
  String[] lines = loadStrings(fName);
  for (int x = 0; x < lines.length; x++) {
    String[] column = lines[x].split("/");
    for (int y = 0; y < column.length; y++) {
      String[] row = column[y].split(",");
      for (int z = 0; z < row.length; z++) {
        int val = int(row[z]);
        if (val != 0) {
          grid[x][y][z] = 1;
        }
        grid2[x][y][z] = 0;
      }
    }
  }
}

void importStress(String fName) {
  String[] lines = loadStrings(fName);
  print(lines.length);
  for(int i = 0 ; i < lines.length; i++){
    String[] row = lines[i].split(",");
    float x = float(row[0]);
    float y = float(row[1]);
    float z = float(row[2]);
    if( x>=0 && x < dimx && y >=0 && y < dimy && z >= 0 && z < dimz){
      float dx = float(row[3]);
      float dy = float(row[4]);
      float dz = float(row[5]);
      PVector p = new PVector(x,y,z);
      PVector d = new PVector(dx,dy,dz);
      d.sub(p);
      sNode s = new sNode(p,d);
      stressList.add(s);     
    }
  }
}
