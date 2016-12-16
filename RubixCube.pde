//rahmant3
//Requires Cube.java and Face.java
//Simulates a 3D 3x3 Rubix Cube in Processing

float tileLen;
Cube cube;

float xOffset;
float yOffset;
float yChange;
float xChange;

ArrayList<Integer> moves;
int maxMoves = 254;

String welcome = "Welcome to the Rubix Cube simulation!\n\nThe controls are as follows: \n" +
//"-Mouse movement from side to side moves the cube about the central vertical axis\n" +
"-Left/Right arrow keys moves the cube about the central vertical axis\n" +
//"-Mouse movement above or below the middle half of this window moves the cube about the \n" +
//"central horizontal axis (keeping your mouse in the middle half of the window means the cube won't move \n" +
"-Up/Down arrow keys moves the cube about the central horizontal axis\n" +
"-Capital N randomizes the cube\n" + 
"-Space Bar resets cube to solved\n" + 
"-Press the letter corresponding to the color of the face to turn that face CLOCKWISE, e.g.:\n\n" +
"G for green\n" +
"O for orange\n" +
"R for red\n" +
"B for blue\n" +
"W for white\n" +
"Y fo yellow\n" +
"(The color of a face is the color of its center)\n\n" +
"-Press U to undo a move\n" +
"-Press H to hide this and show the cube!" +
"\n\n\n\n\n\n\nThis program is written in Processing (Java)";

boolean showText;

void setup() {
  size(600, 600, P3D);
  colorMode(HSB);
  
  cube = new Cube();
  tileLen = 75;
  xOffset = 0;
  yOffset = 0;
  xOffset = 0;
  
  moves = new ArrayList<Integer>();
  showText = false;
}

void draw() {
  background(0);
  //lights();
  
  stroke(0);
  //strokeWeight(2);
  
  if (showText) {
    fill(255);
    textSize(12);
    text(welcome, 50, 50);
  } else {
    fill(255);
    textSize(12);
    text("Press H for help!", 20, 20);
    
    xOffset += xChange;
    
    if (xOffset > 2*PI) {
      xOffset -= 2*PI;
    } else if (xOffset < -2*PI) {
      xOffset += 2*PI;
    }
    
    //xOffset = map(mouseX, 0, width, -2*PI, 2*PI);
    //yChange = map(mouseY, 0, height, 0.1, -0.1);
    
    //if (yChange < 0.05 && yChange > -0.05) {
    //  yChange = 0;
    //} else {
    //  if (mouseY < height/2) {
    //    yChange = map(mouseY, 0, height*0.25, 0.1, 0);
    //  } else {
    //    yChange = map(mouseY, height*0.75, height, 0, -0.1);
    //  }
    //}
    
    
    if (abs(xOffset) > PI/2 && abs(xOffset) < 1.5*PI) {
      yOffset -= yChange;
    } else {
      yOffset += yChange;
    }
    
    translate((width/2), (height/2));
    rotateY(xOffset);
    rotateX(yOffset);
    translate(-tileLen*3/2, -tileLen*3/2, tileLen*3/2);
    
    drawCube();
  }
}

void drawCube() {
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
        } else if (i == 2) {
          makeTile((3-k)*tileLen, (j)*tileLen, -3*tileLen, (2-k)*tileLen, (j+1)*tileLen, -3*tileLen, colour);
        } else if (i == 3) {
          makeTile(3*tileLen, j*tileLen, (-k)*tileLen, 3*tileLen, (j+1)*tileLen, (-1-k)*tileLen, colour);
        } else if (i == 4) {
          makeTile((k)*tileLen, 0, (j-3)*tileLen, (k+1)*tileLen, 0, (j-2)*tileLen, colour);
        } else if (i == 5) {
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
  if (key == 'G' || key == 'g') {
    cube.rotateFace(0);
    moves.add(0);
  } 
  if (key == 'O' || key == 'o') {
    cube.rotateFace(1);
    moves.add(1);
  } 
  if (key == 'B' || key == 'b') {
    cube.rotateFace(2);
    moves.add(2);
  }
  if (key == 'R' || key == 'r') {
    cube.rotateFace(3);
    moves.add(3);
  }
  if (key == 'W' || key == 'w') {
    cube.rotateFace(4);
    moves.add(4);
  } 
  if (key == 'Y' || key == 'y') {
    cube.rotateFace(5);
    moves.add(5);
  }
  
  if (key == 'u' || key == 'U') {
    if (!moves.isEmpty()) {
      int index = moves.size() - 1;
      int face = moves.get(index);
      cube.rotateFace(face);
      cube.rotateFace(face);
      cube.rotateFace(face);
      moves.remove(index);
    }
  }
  if (key == ' ') {
    cube.reset();
    moves = new ArrayList<Integer>();
  }
  if (key == 'N') {
    randomize();
    moves = new ArrayList<Integer>();
  }
  if (key == 'H' || key == 'h') {
    showText = !showText;
  } 
  if (key == CODED) {
    if (keyCode == UP) {
      yChange = 0.1;
    } else if (keyCode == DOWN) {
      yChange = -0.1;
    } else if (keyCode == RIGHT) {
      xChange = 0.1;
    } else if (keyCode == LEFT) {
      xChange = -0.1;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP || keyCode == DOWN) {
      yChange = 0;
    } else if (keyCode == RIGHT || keyCode == LEFT) {
      xChange = 0;
    }
  }
}
  

void randomize() {
  for (int i = 0; i < 60; i++) {
    double r = Math.random();
    
    cube.rotateFace((int) Math.floor(r*100) % 6);
    
  }
}
