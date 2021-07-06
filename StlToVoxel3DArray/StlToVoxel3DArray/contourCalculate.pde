ArrayList contourCalculate( WETriangleMesh meshIn, PVector p1, PVector p2) {
  
  ArrayList pointSum = new ArrayList();

  for ( Face f : meshIn.getFaces()) {
    Triangle3D m = f.toTriangle(); 
    PVector A= new PVector(m.a.x, m.a.y, m.a.z);
    PVector B= new PVector(m.b.x, m.b.y, m.b.z);
    PVector C= new PVector(m.c.x, m.c.y, m.c.z);

    // boolean temp = isLineCrossTri(A, B, C, p1, p2);
    stroke(0, 255, 0);
    strokeWeight(2);

    boolean AB =isLineCrossSeg(A, B, p1, p2 );
    boolean AC =isLineCrossSeg(A, C, p1, p2 );
    boolean BC =isLineCrossSeg(B, C, p1, p2 );
    
    PVector cp1 = new PVector();
    PVector cp2 = new PVector();
    
    
    if ( AB || AC || BC) {
      
      if (!AB) {
         cp1 = CP( A, C, p1, p2);
         cp2 = CP( B, C, p1, p2);
        
      }
      if (!AC) {

         cp1 = CP( A, B, p1, p2);
         cp2 = CP( B, C, p1, p2);
        
      }
      if (!BC) {

         cp1 = CP( A, B, p1, p2);
         cp2 = CP( A, C, p1, p2);
       
      }
      if ( AB && AC && BC) {

        float b = (p1.x * p2.y - p2.x * p1.y) / ( p1.x - p2.x);
        float a = (p1.y- p2.y)/ ( p1.x - p2.x);
        float b1 =   A.y - a*A.x;
        float b2 =   B.y - a*B.x;  
        float b3 =   C.y - a*C.x;  
         cp1 = new PVector();
         cp2 = new PVector();
        if ( b == b1) {
          cp1 = A;
          cp2 = CP( B, C, p1, p2);
        }

        if ( b == b2) {
          cp1 = B;
          cp2 = CP(A, C, p1, p2);
        }
        if ( b == b3) {

          cp1 = C;
          cp2 = CP(A, B, p1, p2);
        }

      
      }
      
      pointSum.add(cp1);
      pointSum.add(cp2);
      
    }

    //if(temp){
    // strokeWeight(10);
    // stroke(0,0,255);
    //point(A.x, A.y,A.z); 
    //}
  }

  
  
  
  return pointSum;
  
}

PVector CP( PVector A, PVector B, PVector p1, PVector p2) {
  PVector crossPoint = new PVector();

  if ( p1.x == p2.x && A.x != B.x) {
    float a1 = (A.y -B.y)/(A.x - B.x);
    float b1 = (A.x* B.y - B.x * A.y)/ (A.x - B.x);

    float x = p1.x;
    float y = a1 * x + b1;
    float z = (B.z*( x - A.x) + A.z*(B.x - x))/ ( B.x - A.x);

    crossPoint = new PVector( x, y, z);
  } else if ( p1.x != p2.x && A.x == B.x) {
    float a2 = (p1.y - p2.y)/ (p1.x - p2.x);
    float b2 = (p1.x * p2.y - p2.x * p1.y)/ (p1.x - p2.x);

    float x = A.x;
    float y = a2 * x + b2;

    float z = (B.z*( y - A.y) + A.z*(B.y - y))/ ( B.y - A.y);
    crossPoint = new PVector( x, y, z);
  } else if (p1.y == p2.y && A.y != B.y) {
    float a1 = (A.y -B.y)/(A.x - B.x);
    float b1 = (A.x* B.y - B.x * A.y)/ (A.x - B.x);

    float x = (p1.y - b1) / a1;
    float y = p1.y;
    float z = (B.z*( y - A.y) + A.z*(B.y - y))/ ( B.y - A.y);
    crossPoint = new PVector( x, y, z);
  } else if (p1.y != p2.y && A.y == B.y) {
    float a2 = (p1.y - p2.y)/ (p1.x - p2.x);
    float b2 = (p1.x * p2.y - p2.x * p1.y)/ (p1.x - p2.x);

    float x = (A.y - b2) / a2;
    float y = A.y;

    float z = (B.z*( x - A.x) + A.z*(B.x - x))/ ( B.x - A.x);
    crossPoint = new PVector( x, y, z);
  } else {
    float a1 = (A.y -B.y)/(A.x - B.x);
    float b1 = (A.x* B.y - B.x * A.y)/ (A.x - B.x);

    float a2 = (p1.y - p2.y)/ (p1.x - p2.x);
    float b2 = (p1.x * p2.y - p2.x * p1.y)/ (p1.x - p2.x);


    float x = (b2 - b1) / (a1 -a2);
    float y = (a1*b2 - a1*b1 + a1*b1 - a2*b1) / (a1-a2);

    float z = (B.z*( x - A.x) + A.z*(B.x - x))/ ( B.x - A.x);
    crossPoint = new PVector( x, y, z);
  }
  return crossPoint;
}



boolean isLineCrossTri( PVector A, PVector B, PVector C, PVector P1, PVector P2) {
  boolean temp =true;
  if (P1.x - P2.x != 0) {
    float b = (P1.x * P2.y - P2.x * P1.y) / ( P1.x - P2.x);
    float a = (P1.y- P2.y)/ ( P1.x - P2.x);
    float b1 =   A.y - a*A.x;
    float b2 =   B.y - a*B.x;  
    float b3 =   C.y - a*C.x;

    if ( b1 > b && b2 > b && b3 > b) temp = false;
    if ( b > b1 && b > b2 && b > b3) temp = false;
  } else {
    if ( P1.x> A.x && P1.x> B.x&&P1.x> C.x) temp = false;
    if ( P1.x<A.x && P1.x< B.x&&P1.x< C.x) temp = false;
  }

  return temp;
}

boolean isLineCrossSeg( PVector A, PVector B, PVector P1, PVector P2) {
  boolean temp =true;
  if (P1.x - P2.x != 0) {
    float b = (P1.x * P2.y - P2.x * P1.y) / ( P1.x - P2.x);
    float a = (P1.y- P2.y)/ ( P1.x - P2.x);
    float b1 =   A.y - a*A.x;
    float b2 =   B.y - a*B.x;  

    if ( b1 > b && b2 > b ) temp = false;
    if ( b > b1 && b > b2 ) temp = false;
    if ( b == b1 && b== b2) temp = false;
    if ( a == 0 && b1 == b2) temp = false;
  } else {
    if ( P1.x> A.x && P1.x> B.x) temp = false;
    if ( P1.x<A.x && P1.x< B.x) temp = false;
    if ( P1.x == A.x && P1.x == B.x) temp = false;
  }
  return temp;
}
