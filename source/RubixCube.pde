/*
rahmant3

  Main class, handles UI
  
  github: https://github.com/rahmant3/LOOP

  Requires Cube.java and Face.java
  Simulates a 3D 3x3 Rubix Cube in Processing
  
  Controls are: 
  Up/Down/Left/Right arrows to move the view of the cube.
  G(reen)/O(range)/B(lue)/R(ed)/W(hite)/Y(ellow) to turn that face CLOCKWISE
  Capital N (Shift + N) to randomize the cube
  Space to restart to solved position
  U to undo a move

*/

ArrayList<Integer> moves; //FIFO containing the faces that have moved
private final int MAX_MOVES = 254;

private final int RANDOM_NUMBER_OF_MOVES = 60;

boolean showText;

float tileLen;
Cube cube;

float xOffset;
float yOffset;
float yChange;
float xChange;

private final String welcome = "Welcome to the Rubix Cube simulation!\n\nThe controls are as follows: \n" +
"-Left/Right arrow keys moves the cube about the central vertical axis\n" +
"-Up/Down arrow keys moves the cube about the central horizontal axis\n" +
"-Capital N randomizes the cube\n" + 
"-Space Bar resets cube to solved\n" + 
"-Press the letter corresponding to the color of the face to turn that face\n" +
"CLOCKWISE, e.g.:\n\n" +
"G for green\n" +
"O for orange\n" +
"R for red\n" +
"B for blue\n" +
"W for white\n" +
"Y for yellow\n" +
"(The color of a face is the color of its center)\n\n" +
"-Press U to undo a move\n" +
"-Press H to hide this and show the cube!" +
"\n\n\n\n\n\nThis program is written in Processing (Java)";

private final char COLOR_GREEN  = 'G';
private final char COLOR_ORANGE = 'O';
private final char COLOR_BLUE   = 'B';
private final char COLOR_RED    = 'R';
private final char COLOR_WHITE  = 'W';
private final char COLOR_YELLOW = 'Y';

private final int HUE_GREEN  = 80;
private final int HUE_ORANGE = 20;
private final int HUE_BLUE   = 180;
private final int HUE_RED    = 0;
private final int HUE_WHITE  = -1;
private final int HUE_YELLOW = 50;

private final int FACE_FRONT  = 0;
private final int FACE_LEFT   = 1;
private final int FACE_BACK   = 2;
private final int FACE_RIGHT  = 3;
private final int FACE_TOP    = 4;
private final int FACE_BOTTOM = 5;  

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
  stroke(0);
  
  if (showText) {
    fill(255);
    textSize(14);
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
    
 
    if (abs(xOffset) > PI*0.5 && abs(xOffset) < 1.5*PI) {
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
        
        char tile = cube.getTile(i, j, k);
        int colour = 0;
        
        switch(tile) {
          case(COLOR_RED):
            colour = HUE_RED;
            break;
          case(COLOR_BLUE):
            colour = HUE_BLUE;
            break;
          case(COLOR_GREEN):
            colour = HUE_GREEN;
            break;
          case(COLOR_ORANGE):
            colour = HUE_ORANGE;
            break;
          case(COLOR_YELLOW):
            colour = HUE_YELLOW;
            break;
          case(COLOR_WHITE):
            colour = HUE_WHITE;
            break;
        }
        
        switch(i) {
          case(FACE_FRONT):
            makeTile(k*tileLen, (j)*tileLen, 0, (k+1)*tileLen, (j+1)*tileLen, 0, colour);
            break;
          case(FACE_LEFT):
            makeTile(0, j*tileLen, (k - 3)*tileLen, 0, (j+1)*tileLen, (k - 2)*tileLen, colour);
            break;
          case(FACE_BACK):
            makeTile((3-k)*tileLen, (j)*tileLen, -3*tileLen, (2-k)*tileLen, (j+1)*tileLen, -3*tileLen, colour);
            break;
          case(FACE_RIGHT):
            makeTile(3*tileLen, j*tileLen, (-k)*tileLen, 3*tileLen, (j+1)*tileLen, (-1-k)*tileLen, colour);
            break;
          case(FACE_TOP):
            makeTile((k)*tileLen, 0, (j-3)*tileLen, (k+1)*tileLen, 0, (j-2)*tileLen, colour);
            break;
          case(FACE_BOTTOM):
            makeTile(k*tileLen, 3*tileLen, (-j)*tileLen, (k+1)*tileLen, 3*tileLen, (-1-j)*tileLen, colour);
            break;
        }
      }
    }
  }
}

void makeTile(float xS, float yS, float zS, float xE, float yE, float zE, int colour) {
  if (colour != HUE_WHITE) {
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
  if (moves.size() > MAX_MOVES) {
    moves.remove(0);
  }
  
  if (key == 'G' || key == 'g') {
    cube.rotateFace(FACE_FRONT);
    moves.add(FACE_FRONT);
  } 
  if (key == 'O' || key == 'o') {
    cube.rotateFace(FACE_LEFT);
    moves.add(FACE_LEFT);
  } 
  if (key == 'B' || key == 'b') {
    cube.rotateFace(FACE_BACK);
    moves.add(FACE_BACK);
  }
  if (key == 'R' || key == 'r') {
    cube.rotateFace(FACE_RIGHT);
    moves.add(FACE_RIGHT);
  }
  if (key == 'W' || key == 'w') {
    cube.rotateFace(FACE_TOP);
    moves.add(FACE_TOP);
  } 
  if (key == 'Y' || key == 'y') {
    cube.rotateFace(FACE_BOTTOM);
    moves.add(FACE_BOTTOM);
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
  for (int i = 0; i < RANDOM_NUMBER_OF_MOVES; i++) {
    double r = Math.random();
    
    cube.rotateFace((int) Math.floor(r*6));
  }
}