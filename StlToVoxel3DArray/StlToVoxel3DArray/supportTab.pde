int searchRange = 120;

void downSupport() {
  for (int z = int(dimz)-1; z > 0; z+= -1) {
    println(z);
    int z1 = z-1;
    for (int x = 0; x < dimx; x++) {
      for (int y = 0; y < dimy; y++) {
        if (grid3[x][y][z] != 0) {
          boolean check = false;
          for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
              int x1 = x+i;
              int y1 = y+j;
              if (x1 >=0 && x1 < dimx && y1 >= 0 && y1 < dimy) {
                if (grid3[x1][y1][z1] != 0) {
                  check = true;
                }
              }
            }
          }
          if (!check) {
            waterfall(new Vec3D(x, y, z));
          }
        }
      }
    }
    for (int x = 0; x < dimx; x++) {
      for (int y = 0; y < dimy; y++) {
        grid3[x][y][z1] = grid2[x][y][z1];
        grid3[x][y][z1+1] = grid2[x][y][z1+1];
      }
    }
  }
}

void waterfall(Vec3D inVec) {
  int z1 = floor(inVec.z -1);
  int x1 = floor(inVec.x);
  int y1 = floor(inVec.y);
  Vec3D test = new Vec3D(x1, y1, z1);
  Vec3D sum = new Vec3D();
  float val = 0;
  for (int x = x1-searchRange; x <= x1+searchRange; x++) {
    for (int y = y1-searchRange; y <= y1+searchRange; y++) {
      if (x >= 0  && x < dimx && y >= 0 && y < dimy) {
        if (grid3[x][y][z1] != 0) {
          Vec3D temp = new Vec3D(x, y, z1);
          float dis = test.distanceToSquared(temp);
          temp.scaleSelf(1/(dis*dis));
          sum.addSelf(temp);
          val = val +(1/(dis*dis));
        }
      }
    }
  }
  if (sum.magSquared() != 0) {
    sum.scaleSelf(1/val);
    sum.subSelf(test);
    sum = forceOrtho(sum);
    int x2 = floor(x1 + sum.x);
    int y2 = floor(y1 + sum.y);
    int z2 = floor(z1 + sum.z);
    grid2[x2][y2][z2] = grid3[x1][y1][z1 + 1];
    grid2[x2][y2][z2+1] = grid3[x1][y1][z1 + 1];
  }
}

Vec3D forceOrtho(Vec3D inVec) {
  Vec3D temp = inVec.copy();
  if (abs(temp.x) > abs(temp.y) && abs(temp.x) > abs(temp.z)) {
    temp.y = 0;
    temp.z = 0;
  } else if (abs(temp.y) > abs(temp.z)) {
    temp.x = 0;
    temp.z = 0;
  } else {
    temp.x = 0;
    temp.y = 0;
  }
  temp.normalize();
  return temp;
}
