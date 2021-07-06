void exportAgents(){
  PrintWriter output;
  output = createWriter("agentPts.txt");
  for(int i =0; i < agentList.size(); i++){
    agent me = (agent) agentList.get(i);
    if(me.history.size() > 1){
      for(int j = 0; j < me.history.size(); j++){
        node n = (node) me.history.get(j);
        Vec3D v = n.vel.copy();
        Vec3D u = n.up.copy();
        
        output.println(n.pos.x + "," + n.pos.y + "," + n.pos.z + "/" + v.x + "," + v.y + "," + v.z +"/" + u.x + "," + u.y + "," + u.z);
      }
    }
  }
  output.flush();
  output.close();
}


void exportAgentsCrvs(){
  PrintWriter output;
  output = createWriter("agentPtsCrvs.txt");
  for(int i =0; i < agentList.size(); i++){
    agent me = (agent) agentList.get(i);
    if(me.history.size() > 1){
      
      for(int j = 0; j < me.history.size(); j++){
        node n = (node) me.history.get(j);
        
        output.print(n.pos.x + "," + n.pos.y + "," + n.pos.z );
        if( j < me.history.size() -1 ){
          output.print("/");
        }
      }
    }
    if( i < agentList.size() - 1){
      output.println();
    }
  }
  output.flush();
  output.close();
}
