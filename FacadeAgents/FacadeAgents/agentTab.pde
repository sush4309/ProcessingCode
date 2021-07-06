class agent {
  Vec3D pos;
  Vec3D vel;
  ArrayList history;
  int type;
  boolean death;
  int branchTimer;
  boolean branchCheck;

  //make a constructor function
  agent(Vec3D inPos, int inType) {
    pos = inPos.copy();
    pos.x = int(pos.x/speed)*speed;
    pos.y = int(pos.y/speed)*speed;
    pos.z = int(pos.z/speed)*speed;
    vel = new Vec3D(0,0,0);
    history = new ArrayList();
    //node n = new node(pos, vel);
    //history.add(n);
    type = inType;
    death = true;
    branchTimer = 0;
    branchCheck = true;
  }
  
  agent(Vec3D inPos, Vec3D inVel, int inType) {
    pos = inPos.copy();
    vel = inVel.copy();
    history = new ArrayList();
    //node n = new node(pos, vel);
    //history.add(n);
    type = inType;
    death = true;
    branchTimer = 0;
    branchCheck = true;
  }
  
  

  void update() {    
    
    branchCheck = true;
    branchTimer++;
    //make empty acceleration vector
    Vec3D acc = new Vec3D();

    //call behaviors
    Vec3D con = connect();
    Vec3D aliTrail = alignTrail();
    Vec3D aliCrv = alignCurve();
    Vec3D avd = avoid();
    float gz = (1-(frameCount/gens))*.5;
    Vec3D grav = new Vec3D(0,0,gz);
    
    Vec3D mAtt = meshAttract();
    
    //scale behaviors
    con.scaleSelf(1);
    aliTrail.scaleSelf(1);
    aliCrv.scaleSelf(1);
    avd.scaleSelf(1);

    //blend behaviors and add
    acc.addSelf(con);
    acc.addSelf(aliTrail);
    acc.addSelf(aliCrv);
    acc.addSelf(grav);
    acc.addSelf(avd);
    acc.addSelf(mAtt);
    
    acc.normalize();
    acc.limit(speed);
    vel.addSelf(acc);
    vel.normalize();
    vel = forceOrtho(vel);
    vel.limit(speed);
    pos.addSelf(vel);

    if (death) {
      node n = new node(pos, vel);
      history.add(n);
    }
    //if i've grown enough times and I'm not close to other agents, make a child
    if(branchTimer > branchGens && branchCheck){
      //Vec3D newPos = new Vec3D(random(-.1,.1),random(-.1,.1),0);
      Vec3D newPos = pos.copy();
      Vec3D tempVel = vel.copy();
      Vec3D axis = seekMeshNorm(mesh,pos);
      tempVel.normalize();
      tempVel.rotateAroundAxis(axis,PI/2);
      agent other = new agent(newPos, tempVel, type);
      //for(int i = 0; i < history.size(); i++){
      //  node n = (node) history.get(i);
      //  node n1 = new node(n.pos, n.vel);
      //  other.history.add(n1);
      //}
      
      agentList.add(other);
      branchTimer = 0;
    }
  }
  Vec3D meshAttract(){
    Vec3D cp = seekMeshPt(mesh,pos);
    cp.subSelf(pos);
    cp.limit(speed);
    //can add normalization too
    //cp.normalize();
    return cp;
  }
  Vec3D constrainByAngle(Vec3D inVec){
    /// First make the flat angle
    Vec3D flat = inVec.copy();
    flat.z = 0;
    flat.normalize();
    //test angle
    float testAng = PI/6;
    Vec3D goodAngle = new Vec3D(1,0,0);
    Vec3D testVec = goodAngle.copy();
    float closAng = 999999;
    int angCnt = floor(2*PI/testAng);
    for( int i = 0; i < angCnt; i++){
      testVec.rotateZ(testAng);
      testVec.normalize();
      float ang = testVec.angleBetween(flat);
      if(ang < closAng){
         closAng = ang;
         goodAngle = testVec.copy();
      }
    }
    flat = goodAngle.copy();
    if(inVec.z < -.2){
      flat.z = -1;
    }else if(inVec.z > .2){
      flat.z = 1;
    }else{
      flat.z = 0;
    }
    
    return flat;
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
  
  Vec3D alignCurve() {
    Vec3D closDir = new Vec3D();
    float closDis = 99999999.0;
    for (int i = 0; i < crvList.size(); i++) {
      Line3D crv = (Line3D) crvList.get(i);
      Vec3D cPt = crv.closestPointTo(pos);
      float dis = cPt.distanceTo(pos);
      if ( dis < closDis) {
        closDis = dis;
        closDir = crv.getDirection();
      }
    }
    //now we know closest Crv calculate the direction vector
    closDir.normalize();
    Vec3D outVel = new Vec3D();
    if(vel.magnitude() > 0){
      outVel = closDir.copy();
      //check the angle between vel and closDir
      float ang = vel.angleBetween(closDir);
      if(ang > PI/2){
        outVel.scaleSelf(-1);
      }
    }
    return outVel;
  }

  Vec3D alignTrail() {
    Vec3D sum = new Vec3D();
    //loop through all the agents and move towards the ones of different types
    for (int i = 0; i < agentList.size(); i++) {
      agent other = (agent) agentList.get(i);
      if (other != this) {
        for (int j = 0; j < other.history.size(); j++) {
          node n = (node) other.history.get(j);
          float dis = pos.distanceToSquared(n.pos);
          if (dis > 0 && dis < pow(1, 2)) {
            Vec3D temp = n.vel.copy();
            float factor = 1/dis;
            temp.scaleSelf(factor);
            sum.addSelf(temp);
          }
          if (dis <= speed && branchTimer > 3) {
            death = false;
          }
        }
      }
    }
    sum.normalize();
    return sum;
  }

  Vec3D connect() {
    Vec3D sum = new Vec3D();
    //loop through all the agents and move towards the ones of different types
    for (int i = 0; i < agentList.size(); i++) {
      agent other = (agent) agentList.get(i);
      //if (type != other.type) {
        float dis = pos.distanceTo(other.pos);
        if (dis > 4*speed) {
          Vec3D temp = other.pos.copy();
          temp.subSelf(pos);
          temp.normalize();
          float factor = 1/pow(dis, 2);
          temp.scaleSelf(factor);
          sum.addSelf(temp);
        }
      //}
    }
    sum.normalize();
    return sum;
  }
  
  Vec3D avoid() {
    Vec3D sum = new Vec3D();
    //loop through all the agents and move towards the ones of different types
    for (int i = 0; i < agentList.size(); i++) {
      agent other = (agent) agentList.get(i);
      if (this != other) {
        float dis = pos.distanceTo(other.pos);
        if (dis > 0 && dis < 2*speed) {
          Vec3D temp = pos.copy();
          temp.subSelf(other.pos);
          temp.normalize();
          float factor = 1/pow(dis, 2);
          temp.scaleSelf(factor);
          sum.addSelf(temp);
          branchCheck = false;
        }
      }
    }
    sum.normalize();
    return sum;
  }

  void render() {

    stroke(255, 0, 0);
    noFill();
    strokeWeight(1);
    beginShape();
    for (int i = 0; i < history.size(); i++) {
      node p = (node) history.get(i);
      vertex(p.pos.x, p.pos.y, p.pos.z);
    }
    endShape();
    if (type == 1) {
      stroke(255, 255, 0);
    } else if (type == 2) {
      stroke(0, 255, 0);
    } else {
      stroke(0, 0, 255);
    }
    point(pos.x, pos.y, pos.z);
  }
}
