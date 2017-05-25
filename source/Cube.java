/* rahmant3

  Cube class, handles cubing behaviors

  github: https://github.com/rahmant3/LOOP
  Requires Face.java class
  
  Contains 6 face objects (a 3x3 array containing 1 face of the cube) to simulate a rubix cube.
  Allows the user only to rotate the face of a cube, to reset the cube to starting position, or
  to get a tile from the cube.
  
  The order of faces is indexed from 0 to 5, with the colors as follows:
  front (green), left (orange), back (blue), right (red), top (white), bottom (yellow)
 
*/

public class Cube {
	
  private static Face[] sides;
  
  private final char[] colors   = {'G', 'O', 'B', 'R', 'W', 'Y', 'Z', 'A', 'C'};
  
  private final int FACE_FRONT  = 0;
  private final int FACE_LEFT   = 1;
  private final int FACE_BACK   = 2;
  private final int FACE_RIGHT  = 3;
  private final int FACE_TOP    = 4;
  private final int FACE_BOTTOM = 5;	


  public Cube() {
    sides = new Face[6];
    for (int i = 0; i < sides.length; i++) {
      sides[i] = new Face();
    }
    this.reset();
  }
	
  public char getTile(int face, int row, int col) {
    return sides[face].getTile(row, col);
  }
    

  public void reset() {
    for (int k = 0; k < 6; k++) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          sides[k].setTile(i, j, colors[k]);
        }
      }
    }
  }
	
	//CW turn of any face on the cube
  public void rotateFace(int pos) {
    //Rotate the target face CW
    sides[pos] = rotateMatrixCW(sides[pos]);
		char[] temp;
    switch(pos){
      
      case(FACE_FRONT):
        temp = (sides[FACE_TOP].getRow(2));
        sides[FACE_TOP].setRow(2, reverseLine(sides[FACE_LEFT].getCol(2)));
        sides[FACE_LEFT].setCol(2, sides[FACE_BOTTOM].getRow(0));
        sides[FACE_BOTTOM].setRow(0, reverseLine(sides[FACE_RIGHT].getCol(0)));
        sides[FACE_RIGHT].setCol(0,  temp);
        break;
      case(FACE_LEFT):
        temp = (sides[FACE_TOP].getCol(0));
        sides[FACE_TOP].setCol(0, reverseLine(sides[FACE_BACK].getCol(2)));
        sides[FACE_BACK].setCol(2, reverseLine(sides[FACE_BOTTOM].getCol(0)));
        sides[FACE_BOTTOM].setCol(0, sides[FACE_FRONT].getCol(0));
        sides[FACE_FRONT].setCol(0, temp);
        break;
      case(FACE_BACK):
        temp = (sides[FACE_TOP].getRow(0));
        sides[FACE_TOP].setRow(0, (sides[FACE_RIGHT].getCol(2)));
        sides[FACE_RIGHT].setCol(2, reverseLine(sides[FACE_BOTTOM].getRow(2)));
        sides[FACE_BOTTOM].setRow(2, (sides[FACE_LEFT].getCol(0)));
        sides[FACE_LEFT].setCol(0, reverseLine(temp));
        break;
      case(FACE_RIGHT):
        temp = (sides[FACE_FRONT].getCol(2));
        sides[FACE_FRONT].setCol(2, sides[FACE_BOTTOM].getCol(2));
        sides[FACE_BOTTOM].setCol(2, reverseLine(sides[FACE_BACK].getCol(0)));
        sides[FACE_BACK].setCol(0, reverseLine(sides[FACE_TOP].getCol(2)));
        sides[FACE_TOP].setCol(2, (temp));
        break;
      case(FACE_TOP):
        temp = (sides[FACE_FRONT].getRow(0));
        sides[FACE_FRONT].setRow(0, sides[FACE_RIGHT].getRow(0));
        sides[FACE_RIGHT].setRow(0, sides[FACE_BACK].getRow(0));
        sides[FACE_BACK].setRow(0, sides[FACE_LEFT].getRow(0));
        sides[FACE_LEFT].setRow(0, temp);
        break;
      case(FACE_BOTTOM):
        temp = (sides[FACE_FRONT].getRow(2));
        sides[FACE_FRONT].setRow(2, sides[FACE_LEFT].getRow(2));
        sides[FACE_LEFT].setRow(2, sides[FACE_BACK].getRow(2));
        sides[FACE_BACK].setRow(2, sides[FACE_RIGHT].getRow(2));
        sides[FACE_RIGHT].setRow(2,  temp);
        break;
    }
  }
	
  //Reverse a vector of characters
  private static char[] reverseLine (char[] line) {
    char[] result = new char[line.length];
    for (int i = 0; i < line.length/2; i++) {
      result[i] = line[line.length - 1 - i];
      result[line.length - 1 - i] = line[i];
    }
    if (line.length % 2 != 0) {
      result[line.length/2] = line[line.length/2];
    }
    return result;
  }
	
  //Rotate matrix clockwise
  //Transpose matrix, then reverse the columns
  private static Face rotateMatrixCW (Face input) {
    Face transpose = new Face();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        transpose.setTile(i, j, input.getTile(j, i));
      }
    }
		
    for (int i = 0; i < input.getSIZE()/2; i++) {
      input.setCol(i, transpose.getCol(input.getSIZE() - i - 1));
      input.setCol(input.getSIZE() - i - 1, transpose.getCol(i));
    }
		
    if (input.getSIZE() % 2 != 0) {
      input.setCol(input.getSIZE()/2, transpose.getCol(input.getSIZE()/2));
    }
    return input;
  }
	
  public String cubeToString() {
    String result = "";
    for (int i = 0; i < 3; i++) {;
      result += sides[FACE_TOP].lineToString(i) + "\n";
    }
    int[] order = {0, 3, 2, 1};
    for (int i = 0; i < 3; i++) {
      for (int k = 0; k < 4; k++) {
        result+= sides[order[k]].lineToString(i) + " ";
      }
      result += "\n";
    }
    for (int i = 0; i < 3; i++) {
      result += sides[FACE_BOTTOM].lineToString(i) + "\n";
    }
    return result;
  }
}