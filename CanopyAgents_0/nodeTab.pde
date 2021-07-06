class node{
  Vec3D pos;
  Vec3D vel;
  
  node(Vec3D inPos, Vec3D inVel){
    pos = inPos.copy();
    vel = inVel.copy();
  }
}
