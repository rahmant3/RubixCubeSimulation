/*
rahmant3
   
  github: https://github.com/rahmant3/LOOP
   
  To be used with Cube.java class
   
  Face objects (a 3x3 array containing 1 face of the cube) to be used in order to simulate a rubix cube.
  Contains getters and setters in order to get a row, column, or tile, allowing Cube.java to manipulate
  the faces to simulate a cube.
*/
 
public class Face {

  private char[][] tiles;
  private int SIZE = 3;
	
  public Face () {
    tiles = new	char[SIZE][SIZE];
  }

  public char getTile(int row, int col) {
    return tiles[row][col];
  }
  
  public void setTile(int row, int col, char val) {
    tiles[row][col] = val;
  }
  
  public int getSIZE() {
    return SIZE;
  }

  public char[] getRow (int row) {
    char[] result = new char[SIZE];
    for (int i = 0; i < SIZE; i++) {
      result[i] = tiles[row][i];
    }
    return result;
  }
	
  public char[] getCol (int col) {
    char[] result = new char[SIZE];
    for (int i = 0; i < SIZE; i++) {
      result[i] = tiles[i][col];
    }
    return result;
  }
	
  public char[][] getFace () {
    char[][] result = new char[SIZE][SIZE];
    
    for (int i = 0; i < SIZE; i++) {
      for (int j = 0; j < SIZE; j++) {
        result[i][j] = tiles[i][j];
      }
    }
    return result;
  }
	
  public void setFace (char[][] vals) {
    for (int i = 0; i < vals.length; i++) {
      for (int j = 0; j < vals[0].length; j++) {
        tiles[i][j] = vals[i][j];
      }
    }
  }
	
  public void setRow (int row, char[] input) {
    char[] vals = input;
    for (int i = 0; i < vals.length; i++) {
      tiles[row][i] = vals[i];
    }
  }
	
  public void setCol (int col, char[] input) {
    char[] vals = input;
    for (int i = 0; i < vals.length; i++) {
      tiles[i][col] = vals[i];
    }
  }
	
  public String faceToString() {
    String result = "";
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        result += tiles[i][j];
      }
    }
    return result;
  }
  public String lineToString(int row) {
    String result = "";
    for (int i = 0; i < tiles.length; i++) {
      result += tiles[row][i];
    }
    return result;
  }	
}