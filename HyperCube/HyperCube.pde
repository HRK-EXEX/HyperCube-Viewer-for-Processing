int view=0, ctrl=0, vc=0, automode=0;
boolean debug=false, Orthographic=false, O2=false, vsync=true, lang=false, showCtrl=false, apply=false;
float x=0, y=0, z=0, X=0, Y=0, Z=0, spd=1.5, capX=4, capY=capX;
float size=150, W=0, f, ball=16, line=2, time=0;
float w[] = new float[3]; float memo[] = new float[10];
long c, e, g; double d;
String FontName = "Ricty Diminished with Fira Code Regular";
String processing = "";

PFont ah, aua;
PVector[] p = new PVector[8];
P4Vector[] p4 = new P4Vector[16];

int[] col = new int[16];
    
void setup() {
  surface.setResizable(true);
  surface.setTitle("HyperCube Viewer for Processing");
  size(1280, 720, P3D);
  e = System.nanoTime();
  ah = createFont(FontName, height/18);
  aua = createFont(FontName, height/40);
  
  col[0] = 0xff000000; // black
  col[1] = 0xff0000ff; // blue
  col[2] = 0xff00ff00; // green
  col[3] = 0xff00ffff; // cyan
  col[4] = 0xffff0000; // red
  col[5] = 0xffff00ff; // magenta
  col[6] = 0xffffff00; // yellow
  col[7] = 0xffffffff; // white
  
  col[8] = 0xff000000; // black
  col[9] = 0xff0000ff; // blue
  col[10] = 0xff00ff00; // green
  col[11] = 0xff00ffff; // cyan
  col[12] = 0xffff0000; // red
  col[13] = 0xffff00ff; // magenta
  col[14] = 0xffffff00; // yellow
  col[15] = 0xffffffff; // white

  textFont(ah);
  if (debug) {
    String[] tmp = PFont.list();
    printArray(tmp);
  }
  frameRate(1000);
}

void draw() {
  strokeWeight(ball);
  if ((ctrl&1<<19) == 0) {
    if ((ctrl&1<<17) == 0) {
      if ((ctrl&(1<<0))>0) x+=spd*f;
      if ((ctrl&(1<<1))>0) x-=spd*f;
      if ((ctrl&(1<<2))>0) y-=spd*f;
      if ((ctrl&(1<<3))>0) y+=spd*f;
      if ((ctrl&(1<<4))>0) z-=spd*f;
      if ((ctrl&(1<<5))>0) z+=spd*f;
      if ((ctrl&(1<<6))>0) w[0]-=spd*f;
      if ((ctrl&(1<<7))>0) w[0]+=spd*f;
      if ((ctrl&(1<<8))>0) w[1]+=spd*f;
      if ((ctrl&(1<<9))>0) w[1]-=spd*f;
      if ((ctrl&(1<<10))>0) w[2]+=spd*f;
      if ((ctrl&(1<<11))>0) w[2]-=spd*f;
    } else {
      if ((ctrl&(1<<0))>0) Y-=spd*f;
      if ((ctrl&(1<<1))>0) Y+=spd*f;
      if ((ctrl&(1<<2))>0) X-=spd*f;
      if ((ctrl&(1<<3))>0) X+=spd*f;
      if ((ctrl&(1<<4))>0) Z-=spd*f;
      if ((ctrl&(1<<5))>0) Z+=spd*f;
      if ((ctrl&(1<<6))>0) W-=spd*f;
      if ((ctrl&(1<<7))>0) W+=spd*f;
    }
  } else {
    if ((ctrl&(1<<0))>0) x=0;
    if ((ctrl&(1<<1))>0) X=0;
    if ((ctrl&(1<<2))>0) y=0;
    if ((ctrl&(1<<3))>0) Y=0;
    if ((ctrl&(1<<4))>0) z=0;
    if ((ctrl&(1<<5))>0) Z=0;
    if ((ctrl&(1<<6))>0) w[0]=0;
    if ((ctrl&(1<<7))>0) w[1]=0;
    if ((ctrl&(1<<8))>0) w[2]=0;
    if ((ctrl&(1<<9))>0) W=0;
  }
  if ((ctrl&(1<<13))>0) { size-=1; }
  if ((ctrl&(1<<14))>0) { size+=1; }
  if ((ctrl&(1<<15))>0) { spd/=1.01; }
  if ((ctrl&(1<<16))>0) { spd*=1.01; }
  if (size < 0) {size=0;}
  if (spd < 0) {spd=0;}
  
  if(automode>0){
    if(!apply){
      memo[0]=x; memo[1]=y; memo[2]=z;
      memo[3]=w[0]; memo[4]=w[1]; memo[5]=w[2];
      memo[6]=X; memo[7]=Y; memo[8]=Z; memo[9]=W;
      apply=!apply;
    }
    
    if(automode == 1){
      switch(view){
        case 1:
          break;
        case 2:
          z-=spd*f; break;
        case 3:
          y-=spd*f; break;
        case 4:
          w[1]+=spd*f; break;
      }
    } else if(automode == 2){
      switch(view){
        case 1:
          X+=spd*f; if(X-size-ball>width/2) X=-X; break;
        case 2:
          X+=spd*f*5; if(X-size-ball>width/2) X=-X;
          Y+=spd*f*3; if(Y-size-ball>height/2) Y=-Y;
          break;
        case 3:
          time = time+radians(spd*f);
          X=cos(time)*150; Y=sin(time*2)*60;
          Z=cos(time/3+PI)*90;
          break;
        case 4:
          time = time+radians(spd*f);
          W=cos(time)*120; Z=sin(time)*120;
          break;
      }
    } else if(automode == 3){
      switch(view){
        case 1:
          X-=spd*f*8; if(X+size+ball<-width/2) X-=X*2; break;
        case 2:
          X-=spd*f*5; if(X+size+ball<-width/2) X-=X*2;
          Y-=spd*f*67; if(Y+size+ball<-height/2) Y-=Y*2;
          z=random(-180,180);
          break;
        case 3:
          time = time+radians(spd*f);
          X=cos(time*8)*(1+abs(Y));Z=sin(time*8)*(1+abs(Y));Y=-cos(time/20)*150;
          x+=spd*f; y-=spd/2*f; z+=spd*2f;
          break;
        case 4:
          time = time+radians(spd*f);
          W=random(-30,30);X=random(-30,30);Y=random(-30,30);Z=random(-30,30);
          w[0]+=spd*f;w[1]+=spd/2*f;w[2]+=spd*2*f;
          x+=spd*f; y-=spd/10*f; z+=spd*10*f;
          break;
      }
    }
  } else if (apply) {
    x=memo[0]; y=memo[1]; z=memo[2];
    w[0]=memo[3]; w[1]=memo[4]; w[2]=memo[5];
    X=memo[6]; Y=memo[7]; Z=memo[8]; W=memo[9];
    apply=!apply;
  }
  
  if(x>180)x-=360; if(x<-180)x+=360;
  if(y>180)y-=360; if(y<-180)y+=360;
  if(z>180)z-=360; if(z<-180)z+=360;
  if(w[0]>180)w[0]-=360; if(w[0]<-180)w[0]+=360;
  if(w[1]>180)w[1]-=360; if(w[1]<-180)w[1]+=360;
  if(w[2]>180)w[2]-=360; if(w[2]<-180)w[2]+=360;

  f = (c-g)/1000000000.0 * 60;
  g = c;
  c = System.nanoTime();
  d = sin(radians((c-e)/8333333.3))*3;
  
  // Select View Mode
  switch(view) {
    default: Start(); break;
    case 1: View1D(); break;
    case 2: View2D(); break;
    case 3: View3D(); break;
    case 4: View4D(); break;
  }
  if (view>0)translate(-width/2, -height/2);

  showCtrl();

  textAlign(LEFT, BOTTOM);
  if(debug){
    if(!lang){
      if (vsync) text("VSync is Enabled.", capX, height-capY);
      else text("VSync is Disabled.", capX, height-capY);
    } else {
      if (vsync) text("VSyncは有効です。", capX, height-capY);
      else text("VSyncは無効です。", capX, height-capY);
    }
  }
  VSync();
}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP)      ctrl |= (1<<13);
    if (keyCode == DOWN)    ctrl |= (1<<14);
    if (keyCode == LEFT)    ctrl |= (1<<15);
    if (keyCode == RIGHT)   ctrl |= (1<<16);
    if (keyCode == SHIFT)   ctrl |= (1<<17);
    if (keyCode == CONTROL) ctrl |= (1<<18);
    if (keyCode == ALT)     ctrl |= (1<<19);
    if (keyCode == ESC) exit();
  }
  if (key == ENTER) {
    spd=1.5; size=150;
  }

  // Rotate/Move the meshes
  if (key == 'w' || key == 'W') ctrl |= (1<<0);
  if (key == 's' || key == 'S') ctrl |= (1<<1);
  if (key == 'a' || key == 'A') ctrl |= (1<<2);
  if (key == 'd' || key == 'D') ctrl |= (1<<3);
  if (key == 'q' || key == 'Q') ctrl |= (1<<4);
  if (key == 'e' || key == 'E') ctrl |= (1<<5);
  if (key == 't' || key == 'Z') ctrl |= (1<<6);
  if (key == 'g' || key == 'C') ctrl |= (1<<7);
  if (key == 'f' || key == 'F') ctrl |= (1<<8);
  if (key == 'h' || key == 'H') ctrl |= (1<<9);
  if (key == 'r' || key == 'R') ctrl |= (1<<10);
  if (key == 'y' || key == 'Y') ctrl |= (1<<11);

  if (key == 'x') { x=0; y=0; z=0; w[0]=0; w[1]=0; w[2]=0; }
  if (key == 'X') { X=0; Y=0; Z=0; W=0; }

  if (key == 'o' || key == 'O') {
    if(view==3) {Orthographic=!Orthographic; vc=Orthographic ? 1 : 0;}
    if(view==4) {
      vc++; vc %= 3;
      switch(vc){
        case 1: Orthographic=true; break;
        case 2: Orthographic=true; O2=true; break;
        default: Orthographic=false; O2=false; break;
      }
    }
  }
  if (key == 'v' || key == 'V') vsync=!vsync;
  if (key == 'l' || key == 'L') lang=!lang;
  if (key == ' ' ) { automode++; automode%=4;}
  
  if (keyCode == 97) showCtrl=!showCtrl;

  /*
    Change View Mode
   1 = Line
   2 = Plane
   3 = Cube
   4 = HyperCube
   */

  if (key == '0') view=0;
  if (key == '1') view=1;
  if (key == '2') view=2;
  if (key == '3') view=3;
  if (key == '4') view=4;
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)      ctrl &= ~(1<<13);
    if (keyCode == DOWN)    ctrl &= ~(1<<14);
    if (keyCode == LEFT)    ctrl &= ~(1<<15);
    if (keyCode == RIGHT)   ctrl &= ~(1<<16);
    if (keyCode == SHIFT)   ctrl &= ~(1<<17);
    if (keyCode == CONTROL) ctrl &= ~(1<<18);
    if (keyCode == ALT)     ctrl &= ~(1<<19);
  }

  // Rotate the meshes
  if (key == 'w' || key == 'W') ctrl &= ~(1<<0);
  if (key == 's' || key == 'S') ctrl &= ~(1<<1);
  if (key == 'a' || key == 'A') ctrl &= ~(1<<2);
  if (key == 'd' || key == 'D') ctrl &= ~(1<<3);
  if (key == 'q' || key == 'Q') ctrl &= ~(1<<4);
  if (key == 'e' || key == 'E') ctrl &= ~(1<<5);
  if (key == 't' || key == 'Z') ctrl &= ~(1<<6);
  if (key == 'g' || key == 'C') ctrl &= ~(1<<7);
  if (key == 'f' || key == 'F') ctrl &= ~(1<<8);
  if (key == 'h' || key == 'H') ctrl &= ~(1<<9);
  if (key == 'r' || key == 'R') ctrl &= ~(1<<10);
  if (key == 'y' || key == 'Y') ctrl &= ~(1<<11);
  if (key == 'x' || key == 'X') ctrl &= ~(1<<12);
  
  if (key == ' ') ctrl &= ~(1<<18);
}

void VSync() {
  PJOGL pgl = (PJOGL)beginPGL();
  if (vsync) pgl.gl.setSwapInterval(1);
  else pgl.gl.setSwapInterval(0);
  endPGL();
}

void showCtrl() {
  String Ctrl = "", help = "", isMove = "";
  if(showCtrl){
    if (!lang) {
      if ((ctrl&1<<17)>0) isMove="Move";
      else isMove="Rotation";
      if (view>=1) {
        if (view==2) {
          Ctrl += "Q,E - "+isMove+"\n";
        }
  
        if (view==3) {
          Ctrl += "W,S - "+isMove+" X\n";
          Ctrl += "A,D - "+isMove+" Y\n";
          Ctrl += "Q,E - "+isMove+" Z\n";
          Ctrl += "O - Change Projection Mode\n";
        }
        if (view==4) {
          
          if ((ctrl&1<<17)>0) {
            Ctrl += "WASDQE - "+isMove+" X,Y,Z\n";
            Ctrl += "ZC - "+isMove+" W\n";
          } else {
            Ctrl += "WASDQE - "+isMove+" YZ,XZ,XY\n";
            Ctrl += "TGFHRY - "+isMove+" XW,YW,ZW\n";
          }
          Ctrl += "O - Change Projection Mode\n";
        }
        Ctrl += "↑↓ - Change Size\n";
        Ctrl += "←→ - Change Speed\n";
      } else Ctrl += "X - All Clear "+isMove+" Parameters\n";
      Ctrl += "Shift - Moving instead Rotation\n";
      Ctrl += "Space - Automatic Rotation/Move\n";
      Ctrl += "Alt - Clear by parameter\n";
      Ctrl += "Escape - Exit is here\n";
      Ctrl += "L - 日本語に切り替える";
    } else {
      if ((ctrl&1<<17)>0) isMove="移動";
      else isMove="回転";
      if (view>=1) {
        if (view==2) {
          Ctrl += "Q,E - "+isMove+"する\n"; 
        }
  
        if (view==3) {
          Ctrl += "W,S - X軸を"+isMove+"する\n";
          Ctrl += "A,D - Y軸を"+isMove+"する\n";
          Ctrl += "Q,E - Z軸を"+isMove+"する\n";
          Ctrl += "O - 投影法を切り替える\n";
        }
        if (view==4) {
          if ((ctrl&1<<17)>0) {
            Ctrl += "WASDQE - X,Y,Z軸をそれぞれ"+isMove+"する\n";
            Ctrl += "ZC - W軸を"+isMove+"する\n";
          } else {
            Ctrl += "WASDQE - YZ,XZ,XY軸をそれぞれ"+isMove+"する\n";
            Ctrl += "TGFHRY - XW,YW,ZW軸をそれぞれ"+isMove+"する\n";
          }
        }
        Ctrl += "↑↓ - サイズ変更\n";
        Ctrl += "←→ - 速度変更\n";
      } else Ctrl += "X - "+isMove+"パラメータを初期化する\n";
      Ctrl += "Shift - 回転と移動の切り替え\n";
      Ctrl += "Space - 自動回転/移動\n";
      Ctrl += "Alt - パラメーターごとに初期化\n";
      Ctrl += "Escape - 出口はここだ！\n";
      Ctrl += "L - Back to English";
    }
  } else {
    if(!lang)help += "Press [F1] for help\n";
    else help += "[[F1を押す]]とﾍﾙﾌﾟ\n";
  }
  // More Information
  if (debug) {
    if(showCtrl)Ctrl += "\n\n --- Debug Mode --- \n";
    else Ctrl += " --- Debug Mode --- \n";
    
    if (view!=4) {
      Ctrl+="("+nfc(X, 1)+", "+nfc(Y, 1)+", "+nfc(Z, 1)+"), ("+nfc(x, 1)+", "+nfc(y, 1)+", "+nfc(z, 1)+")\n";
    } else {
      Ctrl+="("+nfc(X, 1)+", "+nfc(Y, 1)+", "+nfc(Z, 1)+", "+nfc(W, 1)+"),\n("+
      nfc(x, 1)+", "+nfc(y, 1)+", "+nfc(z, 1)+", "+nfc(w[0], 1)+", "+nfc(w[1], 1)+", "+nfc(w[2], 1)+")\n";
    }
      Ctrl += processing;
    Ctrl+="("+nfc(size, 0)+", "+nfc(spd, 1)+", "+nfs((c-g)/1000000.0,0,1)+" (ms), "+key+", "+keyCode+", "+ctrl+")\n";
  }
  
  textFont(aua);
  textAlign(CENTER, TOP);
  float fade = lerp(255,0,pow((c-e)/5e9,4));
  pushMatrix();
  if (!showCtrl) fill(-1,fade); else fill(-1);
  if(fade>0 || showCtrl) text(help, width/2, capY);
  fill(-1); popMatrix();
  textAlign(LEFT, TOP);
  text(Ctrl, capX, capY);
}

void Start() {
  // It should show in start screen
  background(0x202020);
  textFont(ah);
  textAlign(CENTER, CENTER);
  if(!lang)text("Press the Number key\nCorrespondence to the Dimensions.\n\nYou can back here when you press 0.\nPress Escape to Exit.", width/2, height/2+(float)d);
  else text("次元に対応した数字キーを\n入力してください。\n\n0キーを押すとこの画面に戻れます。\nエスケープキーで終了します。", width/2, height/2+(float)d);
}

void View1D() {
  // Setup
  background(0x602020);
  stroke(-1);

  textFont(ah);
  textAlign(RIGHT, TOP);
  if(!lang)text("1D - Line", width-capX, capY);
  else text("1次元 - 線", width-capX, capY);

  float[] poly = {-size, size};

  translate(width/2, height/2);
  strokeWeight(line);
  line(poly[0]+X, 0, poly[1]+X, 0);
  strokeWeight(ball);
  for (int i=0; i<2; ++i) {
    point(poly[i]+X, 0);
  }
}

void View2D() {
  // Setup
  background(0x206020);
  stroke(-1);

  textFont(ah);
  textAlign(RIGHT, TOP);
  if(!lang)text("2D - Square", width-capX, capY);
  else text("2次元 - 正方形", width-capX, capY);

  float[] rad = {radians(z-45), radians(z+45), radians(z+135), radians(z-135)};
  float[][] p = new float[4][2];

  for (int i=0; i<p.length; ++i) {
    p[i][0] = -size * cos(rad[i]);
    p[i][1] = -size * sin(rad[i]);
  }

  // XY Rotate
  translate(width/2, height/2);
  strokeWeight(line);
  stroke(0xffff3f3f);
  noFill();
  quad(p[0][0]+X, p[0][1]+Y, p[1][0]+X, p[1][1]+Y, p[2][0]+X, p[2][1]+Y, p[3][0]+X, p[3][1]+Y);
  strokeWeight(ball);
  stroke(-1);
  for (int i=0; i<4; ++i) {
    point(p[i][0]+X, p[i][1]+Y);
  }
}

void View3D() {
  // Setup
  if(O2)O2=false;
  background(0x202060);
  stroke(-1);
  float s=size*pow(2,0.5);

  p[0] = new PVector(-s,-s,-s);
  p[1] = new PVector( s,-s,-s);
  p[2] = new PVector( s, s,-s);
  p[3] = new PVector(-s, s,-s);
  p[4] = new PVector(-s,-s, s);
  p[5] = new PVector( s,-s, s);
  p[6] = new PVector( s, s, s);
  p[7] = new PVector(-s, s, s);

  //Defend 3 Rotation type
  float[][] RotYZ = {
    {1, 0, 0},
    {0, cos(radians(x)), -sin(radians(x))},
    {0, sin(radians(x)), cos(radians(x))}
  };

  float[][] RotXZ = {
    {cos(radians(y)), 0, -sin(radians(y))},
    {0, 1, 0},
    {sin(radians(y)), 0, cos(radians(y))}
  };

  float[][] RotXY = {
    {cos(radians(z)), -sin(radians(z)), 0},
    {sin(radians(z)), cos(radians(z)), 0},
    {0, 0, 1}
  };

  PVector[] PJD = new PVector[8];
  String HowToView;
  if(!lang){
    if (Orthographic)HowToView="Orthographic";
    else HowToView="Perspective";
  } else {
    if (Orthographic)HowToView="等角投影";
    else HowToView="透視投影";
  }

  textFont(ah);
  textAlign(RIGHT, TOP);
  if(!lang)text("3D - Cube\n"+HowToView+" View", width-capX, capY);
  else text("3次元 - 立方体\n"+HowToView+"図", width-capX, capY);
  translate(width/2, height/2);
  
  // Convert 3D to 2D
  int index=0;
  for (PVector v : p) {
    PVector Rotted = matmul(RotXZ, v);
    Rotted = matmul(RotYZ, Rotted);
    Rotted = matmul(RotXY, Rotted);

    float distance = 400;
    float Angle = 1 / (distance);
    float[][] PJT = {
      {Angle, 0, 0},
      {0, Angle, 0},
      {0, 0, Angle}
    };

    if (Orthographic) {
      PJT[2][2]=0;
    }

    PVector PJT2D = matmul(PJT, Rotted);
    PJT2D.mult(s);
    PJD[index]=PJT2D;
    index++;
  }
  pushMatrix();
    translate(X, Y, Z);
    
    //Draw a ball
    for (PVector v : PJD) {
      point(v.x, v.y+(float)d, v.z);
    }
  
    //Connecting Edges
    for (int i=0; i<4; ++i) {
      stroke(col[4]); connect3(i, (i+1)%4, PJD);
      stroke(col[1]); connect3(i+4, (i+1)%4+4, PJD);
      stroke(col[6]); connect3(i, i+4, PJD);
    }
    translate(-X, -Y, -Z);
  popMatrix();
  
  strokeWeight(12);
}

void View4D() {
  // Setup
  background(0x602060);
  stroke(-1);
  if(debug) processing = "";
  float s=size*pow(2,0.2);

  //p4[0] = new P4Vector(-1, -1, -1, -1);
  //p4[1] = new P4Vector( 1, -1, -1, -1);
  //p4[2] = new P4Vector( 1, 1, -1, -1);
  //p4[3] = new P4Vector(-1, 1, -1, -1);
  //p4[4] = new P4Vector(-1, -1, 1, -1);
  //p4[5] = new P4Vector( 1, -1, 1, -1);
  //p4[6] = new P4Vector( 1, 1, 1, -1);
  //p4[7] = new P4Vector(-1, 1, 1, -1);

  //p4[8] = new P4Vector(-1, -1, -1, 1);
  //p4[9] = new P4Vector( 1, -1, -1, 1);
  //p4[10] = new P4Vector( 1, 1, -1, 1);
  //p4[11] = new P4Vector(-1, 1, -1, 1);
  //p4[12] = new P4Vector(-1, -1, 1, 1);
  //p4[13] = new P4Vector( 1, -1, 1, 1);
  //p4[14] = new P4Vector( 1, 1, 1, 1);
  //p4[15] = new P4Vector(-1, 1, 1, 1);
  
  p4[0] = new P4Vector(-s,-s,-s,-s+W);
  p4[1] = new P4Vector( s,-s,-s,-s+W);
  p4[2] = new P4Vector( s, s,-s,-s+W);
  p4[3] = new P4Vector(-s, s,-s,-s+W);
  p4[4] = new P4Vector(-s,-s, s,-s+W);
  p4[5] = new P4Vector( s,-s, s,-s+W);
  p4[6] = new P4Vector( s, s, s,-s+W);
  p4[7] = new P4Vector(-s, s, s,-s+W);
  
  p4[8] =  new P4Vector(-s,-s,-s, s+W);
  p4[9] =  new P4Vector( s,-s,-s, s+W);
  p4[10] = new P4Vector( s, s,-s, s+W);
  p4[11] = new P4Vector(-s, s,-s, s+W);
  p4[12] = new P4Vector(-s,-s, s, s+W);
  p4[13] = new P4Vector( s,-s, s, s+W);
  p4[14] = new P4Vector( s, s, s, s+W);
  p4[15] = new P4Vector(-s, s, s, s+W);

  String HowToView;
  if(!lang){
    if (Orthographic) {
      HowToView="Orthographic View (4D)";
      if (O2) HowToView="Orthographic View (3D)";
    }
    else HowToView="Perspective View";
  } else {
    if (Orthographic) {
      HowToView="等角投影図 (4D)";
      if (O2) HowToView="等角投影図 (3D)";
    }
    else HowToView="透視投影図";
  }
  
  textFont(ah);
  textAlign(RIGHT, TOP);
  if(!lang)text("4D - HyperCube/Tesseract\n"+HowToView, width-capX, capY);
  else text("4次元 - 超立方体/正8胞体\n"+HowToView, width-capX, capY);
  translate(width/2, height/2);

  // Convert 4D to 3D looooloascacunsaubgycvycb7ab

  /*
    RotYZ      | RotXZ      | RotXY
    1  0  0  0 | c  0 -s  0 | c -s  0  0
    0  c -s  0 | 0  1  0  0 | s  c  0  0
    0  s  c  0 | s  0  c  0 | 0  0  1  0
    0  0  0  1 | 0  0  0  1 | 0  0  0  1
    
    RotXW      | RoyYW      | RotZW
    c  0  0 -s | 1  0  0  0 | 1  0  0  0
    0  1  0  0 | 0  c  0 -s | 0  1  0  0
    0  0  1  0 | 0  0  1  0 | 0  0  c -s
    s  0  0  c | 0  s  0  c | 0  0  s  c
  */


  //Defend 6 Rotation type
  float[][] RotYZ = {
    {1, 0, 0, 0},
    {0, cos(radians(x)),-sin(radians(x)), 0},
    {0, sin(radians(x)), cos(radians(x)), 0},
    {0, 0, 0, 1}
  };

  float[][] RotXZ = {
    {cos(radians(y)), 0,-sin(radians(y)), 0},
    {0, 1, 0, 0},
    {sin(radians(y)), 0, cos(radians(y)), 0},
    {0, 0, 0, 1}
  };

  float[][] RotXY = {
    {cos(radians(z)),-sin(radians(z)), 0, 0},
    {sin(radians(z)), cos(radians(z)), 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
  };

  // Welcome to the 4D World
  float[][] RotXW = {
    {cos(radians(w[1])), 0, 0,-sin(radians(w[1]))},
    {0, 1, 0, 0},
    {0, 0, 1, 0},
    {sin(radians(w[1])), 0, 0, cos(radians(w[1]))}
  };

  float[][] RotYW = {
    {1, 0, 0, 0},
    {0, cos(radians(w[0])), 0,-sin(radians(w[0]))},
    {0, 0, 1, 0},
    {0, sin(radians(w[0])), 0, cos(radians(w[0]))}
  };

  float[][] RotZW = {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, cos(radians(w[2])),-sin(radians(w[2]))},
    {0, 0, sin(radians(w[2])), cos(radians(w[2]))}
  };

  PVector[] PJT3D = new PVector[16];

  pushMatrix();
  translate(X, Y, Z);
  //Draw a ball
  for (int i=0; i<p4.length; ++i) {
    P4Vector v=p4[i];
    P4Vector Rotated = matmul(RotXW, v, true);
    Rotated = matmul(RotYW, Rotated, true);
    Rotated = matmul(RotZW, Rotated, true);
    Rotated = matmul(RotXZ, Rotated, true);
    Rotated = matmul(RotYZ, Rotated, true);
    Rotated = matmul(RotXY, Rotated, true);

    float distance = 400 ;
    float Angle = 1 / (distance - Rotated.w);

    float[][] PJT = {
      {Angle, 0, 0, 0},
      {0, Angle, 0, 0},
      {0, 0, Angle, 0},
      {0, 0, 0, Angle}
    };
    if(Orthographic){
      float m=sqrt(2);
      PJT[0][0]=0.5/s*m;
      PJT[1][1]=0.5/s*m;
      PJT[2][2]=0.5/s*m;
      PJT[3][3]=0;
      if(O2){
        PJT[0][0]=0.5/s*m;
        PJT[1][1]=0.5/s*m;
        PJT[2][2]=0;
        PJT[3][3]=0;
      }
    }
    

    PVector PJD = matmul(PJT, Rotated); // v4
    PJD.mult(s);
    PJT3D[i]=PJD;

    point(PJD.x, PJD.y+(float)d, PJD.z);
  }

  //Connecting Edges X -> Y -> Z -> W
  for (int i=0; i<4; ++i) {
    
    stroke(col[0]); connect3(i, (i+1)%4, PJT3D);
    stroke(col[1]); connect3(i+4, (i+1)%4+4, PJT3D);
    stroke(col[2]); connect3(i, i+4, PJT3D);
    stroke(col[3]); connect3(i, i+8, PJT3D);
    stroke(col[4]); connect3(i+8, (i+1)%4+8, PJT3D);
    stroke(col[5]); connect3(i+12, (i+1)%4+12, PJT3D);
    stroke(col[6]); connect3(i+8, i+12, PJT3D);
    stroke(col[7]); connect3(i+4, i+12, PJT3D);
  }
  
  boolean fil = true;

  int[][] fptr = {
    
    { 0, 1, 2, 3},
    { 4, 5, 6, 7},
    { 0, 1, 5, 4},
    { 2, 3, 7, 6},
    
    { 0, 3, 7, 4},
    { 1, 2, 6, 5},
    { 8, 9,10,11},
    {12,13,14,15},
    
    { 8, 9,13,12},
    {10,11,15,14},
    { 8,11,15,12},
    { 9,10,14,13},
    
    { 0, 1, 9, 8},
    { 2, 3,11,10},
    { 4, 5,13,12},
    { 6, 7,15,14},
    
    { 0, 3,11, 8},
    { 1, 2,10, 9},
    { 4, 7,15,12},
    { 5, 6,14,13},
    
    { 0, 4,12, 8},
    { 1, 5,13, 9},
    { 2, 6,14,10},
    { 3, 7,15,11},
  };
  
  if(fil){
    noStroke();
    for(int i=0; i<fptr.length; i++){
      fill(col[i%8+8]); //fillquad(fptr[i][0], fptr[i][1], fptr[i][2], fptr[i][3], PJT3D);
    }
  }
  
  translate(-X, -Y, -Z);
  popMatrix();
}
