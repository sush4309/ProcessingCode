
void exportPoints() {
  String ptName = "pts.txt";
  PrintWriter output = createWriter(ptName);
  for (int i = 0; i < ptCloudPos.size(); i++) {
    PVector p = (PVector) ptCloudPos.get(i);
    color c = (color) ptCloudCol.get(i);
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    output.println(p.x + "," + p.y + "," + p.z + "," + r + "," + g + "," + b);
  }
  output.flush();
  output.close();
}
