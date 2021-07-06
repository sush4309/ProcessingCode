class node{
  Vec3D pos;
  Vec3D vel;
  Vec3D up;
  
  node(Vec3D inPos, Vec3D inVel){
    pos = inPos.copy();
    vel = inVel.copy();
    vel.normalize();
    up = seekMeshNorm(mesh,pos);
    up = vel.cross(up);
    up.normalize();
    up = up.cross(vel);
    up.normalize();
    up = forceOrtho(up); 
    vel.scaleSelf(speed);
    up.scaleSelf(speed);
  }
}

  Vec3D forceOrtho(Vec3D inVec) {
    if (abs(inVec.x) > abs(inVec.y) && abs(inVec.x) > abs(inVec.z)) {
      inVec.y = 0;
      inVec.z = 0;
    } else if (abs(inVec.y) > abs(inVec.z)) {
      inVec.x = 0;
      inVec.z = 0;
    } else {
      inVec.x = 0;
      inVec.y = 0;
    }
    inVec.normalize();
    return inVec;
  }
  
