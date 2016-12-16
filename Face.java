//rahmant3
//To be used with Cube.java class
//Face objects (a 3x3 array containing 1 face of the cube) to be used in order to simulate a rubix cube.

public class Face {

	char[][] tiles;
	
	public Face () {
		tiles = new	char[3][3];
	}
	
	public char[] getRow (int row) {
    char[] result = new char[3];
    for (int i = 0; i < 3; i++) {
      result[i] = tiles[row][i];
    }
		return result;
	}
	
	public char[] getCol (int col) {
		char[] result = new char[3];
		result[0] = tiles[0][col];
		result[1] = tiles[1][col];
		result[2] = tiles[2][col];
		return result;
	}
	
	public char[][] getFace () {
    char[][] result = new char[3][3];
    
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
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
