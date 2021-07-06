PrintWriter output;

void exportGrid(String txtName) {
  output = createWriter(txtName);

  for (int i = 0; i < grid3.length; i++) {
    for (int j = 0; j < grid3[i].length; j++) {
      for (int k = 0; k < grid3[i][j].length; k++) {
        output.print(grid3[i][j][k]);
        if (k < grid3[i][j].length -1) {
          output.print(",");
        }
      }
      if (j < grid3[i].length-1) {
        output.print("/");
      }
    }
    output.println();
  }
  output.flush();
  output.close();
}

void meshGenerator() {

  OBJExport obj = (OBJExport) createGraphics(10, 10, "nervoussystem.obj.OBJExport", "cube0_"+0+"_"+ 0+"_"+ 0+".obj");
  obj.setColor(false);
  obj.beginDraw();
  obj.beginShape(QUADS);
  int checkCol = color(0, 0, 254);
  for (int x = 0; x < grid3.length; x++) {
    for (int y = 0; y < grid3[x].length; y++) {
      for (int z = 0; z < grid3[x][y].length; z++) {

        if (grid3[x][y][z] !=0) {
          obj.fill(grid3[x][y][z]);
          if (x < dimx-1) {

            if (grid3[x+1][y][z] == 0) {
              obj.vertex(x+.5, y+.5, z + .5);
              obj.vertex(x+.5, y-.5, z + .5);
              obj.vertex(x+.5, y-.5, z - .5);

              obj.vertex(x+.5, y+.5, z - .5);
            }
          } else {
            obj.vertex(x+.5, y+.5, z + .5);
            obj.vertex(x+.5, y-.5, z + .5);
            obj.vertex(x+.5, y-.5, z - .5);

            obj.vertex(x+.5, y+.5, z - .5);
          }
          if (x > 0) {

            if (grid3[x-1][y][z] == 0) {
              obj.vertex(x-.5, y+.5, z - .5);
              obj.vertex(x-.5, y-.5, z - .5);
              obj.vertex(x-.5, y-.5, z + .5);
              obj.vertex(x-.5, y+.5, z + .5);
            }
          } else {
            obj.vertex(x-.5, y+.5, z - .5);
            obj.vertex(x-.5, y-.5, z - .5);
            obj.vertex(x-.5, y-.5, z + .5);
            obj.vertex(x-.5, y+.5, z + .5);
          }
          if (y < dimy-1) {

            if (grid3[x][y+1][z] == 0) {
              obj.vertex(x+.5, y+.5, z - .5);
              obj.vertex(x-.5, y+.5, z - .5);
              obj.vertex(x-.5, y+.5, z + .5);
              obj.vertex(x+.5, y+.5, z + .5);
            }
          } else {
            obj.vertex(x+.5, y+.5, z - .5);
            obj.vertex(x-.5, y+.5, z - .5);
            obj.vertex(x-.5, y+.5, z + .5);
            obj.vertex(x+.5, y+.5, z + .5);
          }
          if (y >0) {

            if (grid3[x][y-1][z] == 0) {
              obj.vertex(x+.5, y-.5, z + .5);
              obj.vertex(x-.5, y-.5, z + .5);
              obj.vertex(x-.5, y-.5, z - .5);

              obj.vertex(x+.5, y-.5, z - .5);
            }
          } else {
            obj.vertex(x+.5, y-.5, z + .5);
            obj.vertex(x-.5, y-.5, z + .5);
            obj.vertex(x-.5, y-.5, z - .5);

            obj.vertex(x+.5, y-.5, z - .5);
          }
          if (z < dimz-1) {

            if (grid3[x][y][z+1] == 0) {

              obj.vertex(x+.5, y+.5, z + .5);
              obj.vertex(x-.5, y+.5, z + .5);
              obj.vertex(x-.5, y-.5, z + .5);


              obj.vertex(x+.5, y-.5, z + .5);
            }
          } else {
            obj.vertex(x+.5, y+.5, z + .5);
            obj.vertex(x-.5, y+.5, z + .5);
            obj.vertex(x-.5, y-.5, z + .5);


            obj.vertex(x+.5, y-.5, z + .5);
          }
          if (z >0) {

            if (grid3[x][y][z-1] == 0) {
              obj.vertex(x+.5, y-.5, z - .5);
              obj.vertex(x-.5, y-.5, z - .5);
              obj.vertex(x-.5, y+.5, z - .5);
              obj.vertex(x+.5, y+.5, z - .5);
            }
          } else {

            obj.vertex(x+.5, y-.5, z - .5);
            obj.vertex(x-.5, y-.5, z - .5);
            obj.vertex(x-.5, y+.5, z - .5);
            obj.vertex(x+.5, y+.5, z - .5);
          }
        }
      }
    }
  }
  obj.endShape();
  obj.endDraw();
  obj.dispose();
}
