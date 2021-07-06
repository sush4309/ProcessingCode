void exportAgents(){
  PrintWriter output;
  output = createWriter("agentPts.txt");
  for(int i =0; i < agentList.size(); i++){
    agent me = (agent) agentList.get(i);
    if(me.history.size() > 1){
      for(int j = 0; j < me.history.size(); j++){
        node n = (node) me.history.get(j);
        Vec3D v = n.vel.copy();
        if(j < me.history.size()-1){
          node forward = (node) me.history.get(j+1);
          v = forward.pos.sub(n.pos);
          v.normalize();
        }
        output.println(n.pos.x + "," + n.pos.y + "," + n.pos.z + "," + v.x + "," + v.y + "," + v.z);
      }
    }
  }
  output.flush();
  output.close();
}
