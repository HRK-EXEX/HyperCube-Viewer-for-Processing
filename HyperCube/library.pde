// Vector to Matrix
float[][] vtm(PVector v){
  float[][] m = new float[3][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  return m;
}

// Vector4 to Matrix
float[][] vtm(P4Vector v){
  float[][] m = new float[4][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  return m;
}

// Matrix to Vector
PVector mtv(float[][] m){
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  if(m.length > 2){
    v.z = m[2][0];
  }
  return v;
}

// Matrix to Vector
P4Vector mtv4(float[][] m){
  P4Vector v = new P4Vector(0,0,0,0);
  v.x = m[0][0];
  v.y = m[1][0];
  v.z = m[2][0];
  v.w = m[3][0];
  return v;
}

PVector matmul(float[][] a, PVector b){
  float[][] m = vtm(b);
  return mtv(matmul(a,m));
}

PVector matmul(float[][] a, P4Vector b){
  float[][] m = vtm(b);
  return mtv(matmul(a,m));
}

P4Vector matmul(float[][] a, P4Vector b, boolean W){
  float[][] m = vtm(b);
  return mtv4(matmul(a,m));
}

float[][] matmul(float[][] a,float[][] b){
  int cA = a[0].length;
  int rA = a.length;
  int cB = b[0].length;
  int rB = b.length;
  
  if(cA != rB){
    println("Columns of A must match rows of B.");
    return null;
  }
  
  /*
    (i,k) k,j
    1,0,0 x
    0,1,0 y
          z
  */
  
  float result[][] = new float[rA][cB];
  for(int i=0;i<rA;++i){
    for(int j=0;j<cB;++j){
      float sum=0;
      for(int k=0;k<cA;++k){
        sum += a[i][k] * b[k][j];
      } result[i][j] = sum;
    }
  }
  return result;
}

void connect(int i, int j, PVector[] pts){
  PVector a = pts[i];
  PVector b = pts[j];
  strokeWeight(line);
  line(a.x,a.y+(float)d,b.x,b.y+(float)d);
}

void connect3(int i, int j, PVector[] pts){
  PVector a = pts[i];
  PVector b = pts[j];
  strokeWeight(line);
  line(a.x,a.y+(float)d,a.z,b.x,b.y+(float)d,b.z);
}

void fillquad(int i, int j, int k, int l, PVector[] pts){
  PVector a = pts[i];
  PVector b = pts[j];
  PVector x = pts[k];
  PVector y = pts[l];
  
  beginShape();
  vertex(a.x,a.y+(float)d,a.z);
  vertex(b.x,b.y+(float)d,b.z);
  vertex(x.x,x.y+(float)d,x.z);
  vertex(y.x,y.y+(float)d,y.z);
  endShape(CLOSE);
}
