void importStl(String fName, WETriangleMesh inMesh) {
  TriangleMesh tMesh = (TriangleMesh) new STLReader().loadBinary(sketchPath(fName), STLReader.TRIANGLEMESH);
  inMesh.addMesh(tMesh);
}
