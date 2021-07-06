// 1=x
// 2=y

void plankMaker() {
  for(int z = 0; z < grid[0][0].length; z++){
    int start = z%2;
    for(int x = start; x < grid.length; x+=2){
      for(int y = start; y < grid[0].length; y+=2){
        //check if we are in the grid volume
        if(grid[x][y][z] != 0){
          //loop through the stress nodes, get weighted average and calculate plank direction
          PVector sum = new PVector();
          PVector test = new PVector(x,y,z);
          for(int i = 0; i < stressList.size(); i++){
            sNode s = (sNode) stressList.get(i);
            float dis = test.dist(s.pos);
            if(dis > 0){
              float factor = 1/(dis*dis);
              PVector temp = s.dir.copy();
              temp.mult(factor);
              sum.add(temp);
            }
          }
          //check if x is biggest component in primary stress
          if(abs(sum.x) > abs(sum.y)){
            grid2[x][y][z] = 1;
          }else{
            grid2[x][y][z] = 2;
          }
        }
      }
    }
  }
}
