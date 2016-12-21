/** rahmant3
 * Requires Face.java class
 *
 * Contains 6 face objects (a 3x3 array containing 1 face of the cube) to simulate a rubix cube.
 * Allows the user only to rotate the face of a cube, to reset the cube to starting position, or
 * to get a tile from the cube.
 *
 * The order of faces is indexed from 0 to 5, with the colors as follows:
 * front (green), left (orange), back (blue), right (red), top (white), bottom (yellow)
 * 
 */

public class Cube {
	
  private static Face[] sides;
  private char[] colors = {'G', 'O', 'B', 'R', 'W', 'Y', 'Z', 'A', 'C'};
	
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
		
    //Adjust the other faces accordingly
    if (pos == 0) { //front face
      char[] temp = (sides[4].getRow(2));
      sides[4].setRow(2, reverseLine(sides[1].getCol(2)));
      sides[1].setCol(2, sides[5].getRow(0));
      sides[5].setRow(0, reverseLine(sides[3].getCol(0)));
      sides[3].setCol(0,  temp);
    } else if (pos == 1) { // left face
      char[] temp = (sides[4].getCol(0));
      sides[4].setCol(0, reverseLine(sides[2].getCol(2)));
      sides[2].setCol(2, reverseLine(sides[5].getCol(0)));
      sides[5].setCol(0, sides[0].getCol(0));
      sides[0].setCol(0, temp);
    } else if (pos == 2) { //back face
      char[] temp = (sides[4].getRow(0));
      sides[4].setRow(0, (sides[3].getCol(2)));
      sides[3].setCol(2, reverseLine(sides[5].getRow(2)));
      sides[5].setRow(2, (sides[1].getCol(0)));
      sides[1].setCol(0, reverseLine(temp));
    } else if (pos == 3) { //right face
      char[] temp = (sides[0].getCol(2));
      sides[0].setCol(2, sides[5].getCol(2));
      sides[5].setCol(2, reverseLine(sides[2].getCol(0)));
      sides[2].setCol(0, reverseLine(sides[4].getCol(2)));
      sides[4].setCol(2, (temp));
    } else if (pos == 4) { //top
      char[] temp = (sides[0].getRow(0));
      sides[0].setRow(0, sides[3].getRow(0));
      sides[3].setRow(0, sides[2].getRow(0));
      sides[2].setRow(0, sides[1].getRow(0));
      sides[1].setRow(0, temp);
    } else if (pos == 5) { //bottom
      char[] temp = (sides[0].getRow(2));
      sides[0].setRow(2, sides[1].getRow(2));
      sides[1].setRow(2, sides[2].getRow(2));
      sides[2].setRow(2, sides[3].getRow(2));
      sides[3].setRow(2,  temp);
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
      result += sides[4].lineToString(i) + "\n";
    }
    int[] order = {0, 3, 2, 1};
    for (int i = 0; i < 3; i++) {
      for (int k = 0; k < 4; k++) {
        result+= sides[order[k]].lineToString(i) + " ";
      }
      result += "\n";
    }
    for (int i = 0; i < 3; i++) {
      result += sides[5].lineToString(i) + "\n";
    }
    return result;
  }
}
