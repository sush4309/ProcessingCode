void importPts(String fName, int type) {

  String[] lines = loadStrings(fName);
  for (int i = 0; i < lines.length; i++) {
    String[] nums = lines[i].split(",");
    if (random(10) < 2) {
      if (nums.length == 3) {
        Vec3D vec = new Vec3D(int(nums[0]), int(nums[1]), int(nums[2]));
        pts.add(vec);
        agent a = new agent(vec, type);
        agentList.add(a);
      }
    }
  }
}

void importCrvs(String fName){
  String[] lines = loadStrings(fName);
  for(int i = 0; i < lines.length; i++){
    String[] nums = lines[i].split(",");
    Vec3D start = new Vec3D(int(nums[0]), int(nums[1]), int(nums[2]));
    Vec3D end = new Vec3D(int(nums[3]), int(nums[4]), int(nums[5]));
    Line3D myLine = new Line3D(start,end);
    crvList.add(myLine);
  }
}
