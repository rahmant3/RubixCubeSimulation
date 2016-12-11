import peasy.*;

PeasyCam p;
float tileLen;
Cube cube;

void setup() {
  size(600, 600, P3D);
  colorMode(HSB);
  p = new PeasyCam(this, 1200);
  cube = new Cube();
  tileLen = 200;
}

void draw() {
  background(0);
  //lights();
  fill(255);
  stroke(255);
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 3; j++) {
      for (int k = 0; k < 3; k++) {
        char tile = cube.sides[i].tiles[j][k]; 
        int colour = 0;
        if (tile == 'R') {
          colour = 0;
        } else if (tile == 'B') {
          colour = 180;
        } else if (tile == 'G') {
          colour = 80;
        } else if (tile == 'O') {
          colour = 20;
        } else if (tile == 'Y') {
          colour = 50;
        } else if (tile == 'W') {
          colour = -1;
        }
        
        if (i == 0) {
          makeTile(k*tileLen, (j)*tileLen, 0, (k+1)*tileLen, (j+1)*tileLen, 0, colour);
        } else if (i == 1) {
          makeTile(0, j*tileLen, (k - 3)*tileLen, 0, (j+1)*tileLen, (k - 2)*tileLen, colour);
          //makeTile(0, (k-3)*tileLen, (j)*tileLen, 0, (k-2)*tileLen, (j+1)*tileLen, colour);
        } else if (i == 2) {
          makeTile((3-k)*tileLen, (j)*tileLen, -3*tileLen, (2-k)*tileLen, (j+1)*tileLen, -3*tileLen, colour);
        } else if (i == 3) {
          makeTile(3*tileLen, j*tileLen, (-k)*tileLen, 3*tileLen, (j+1)*tileLen, (-1-k)*tileLen, colour);
        } else if (i == 4) {
          //makeTile(j*tileLen, 0, (k-3)*tileLen, (j+1)*tileLen, 0, (k-2)*tileLen, colour);
          makeTile((k)*tileLen, 0, (j-3)*tileLen, (k+1)*tileLen, 0, (j-2)*tileLen, colour);
        } else if (i == 5) {
          //makeTile(j*tileLen, 3*tileLen, (-k)*tileLen, (j+1)*tileLen, 3*tileLen, (-1-k)*tileLen, colour);
          makeTile(k*tileLen, 3*tileLen, (-j)*tileLen, (k+1)*tileLen, 3*tileLen, (-1-j)*tileLen, colour);
        }
      }
    }
  }
}

void makeTile(float xS, float yS, float zS, float xE, float yE, float zE, int colour) {
  if (colour != -1) {
    fill(colour, 255, 255);
  } else {
    fill(255, 0, 255);
  }
  beginShape();
  if (zS == zE) {
    vertex(xS, yS, zS);
    vertex(xE, yS, zS);
    vertex(xE, yE, zE);
    vertex(xS, yE, zE);
  } else if (yS == yE) {
    vertex(xS, yS, zS);
    vertex(xE, yS, zS);
    vertex(xE, yE, zE);
    vertex(xS, yE, zE);
  } else if (xS == xE) {
    vertex(xS, yS, zS);
    vertex(xE, yE, zS);
    vertex(xE, yE, zE);
    vertex(xS, yS, zE);
  }
  endShape(CLOSE);
}

void keyPressed() {
  if (key == 'F') {
    cube.rotateFace(0);
  } 
  if (key == 'L') {
    cube.rotateFace(1);
  } 
  if (key == 'B') {
    cube.rotateFace(2);
  }
  if (key == 'R') {
    cube.rotateFace(3);
  }
  if (key == 'U') {
    cube.rotateFace(4);
  } 
  if (key == 'D') {
    cube.rotateFace(5);
  }
  
  if (key == ' ') {
    cube.reset();
  }
}