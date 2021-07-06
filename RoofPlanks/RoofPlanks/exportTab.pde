void writePlanks(){
  PrintWriter output = createWriter("planks.txt");
  for(int x = 0; x < grid.length; x++){
    for(int y = 0; y < grid[x].length; y++){
      for(int z = 0; z < grid[x][y].length; z++){
        if(grid2[x][y][z] != 0){
          PVector dir = new PVector();
          if(grid2[x][y][z] ==1){
            dir = new PVector(1,0,0);
          }else{
            dir = new PVector(0,1,0);
          }
          PVector offset = dir.copy();
          offset = offset.cross(new PVector(0,0,1));
          PVector p1 = new PVector(x,y,z);
          PVector p2 = p1.copy();
          p1.sub(dir);
          p2.add(dir);
          p1.add(offset);
          p2.add(offset);
          output.println(p1.x + "," + p1.y + "," + p1.z + "," + p2.x +"," + p2.y + "," + p2.z);
        }
      }
    }
  }
  output.flush();
  output.close();
}
