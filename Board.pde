import java.io.Serializable;

class Board {
  
  protected final int[][] NEIGHBOURS = { 
    {-1, -1}, {0, -1}, {+1, -1}, 
    {-1, 0},           {+1, 0}, 
    {-1, +1}, {0, +1}, {+1, +1}};

  protected boolean grid[][];
  protected int wid, hei;

  public Board(int wid, int hei) {
    this.wid = wid;
    this.hei = hei;

    grid = new boolean[wid][hei];

    for (int i = 0; i<wid; i++)
      for (int j = 0; j<hei; j++)
        grid[i][j] = false;
  }

  public Board(Board b) {
    this.wid = b.width();
    this.hei = b.height();

    grid = new boolean[wid][hei];
    for (int i = 0; i<wid; i++)
      for (int j = 0; j<hei; j++)
        grid[i][j] = b.getCell(i, j);
  }

  public int width() {
    return wid;
  }

  public int height() {
    return hei;
  }

  public boolean getCell(int i, int j) {
    if (i<0)
      return getCell(i+width(), j);
    
    if(i>=width())
      return getCell(i-width(), j);
      
    if(j<0)
      return getCell(i, j+height());
      
    if(j>=height())
      return getCell(i, j-height());

    return grid[i][j];
  }
  
  public void setCell(int i, int j, boolean value){
    if (i<0){
      setCell(i+width(), j, value);
      
      return;
    }
    
    if(i>=width()){
      setCell(i-width(), j, value);
      return;
    }
      
    if(j<0){
      setCell(i, j+height(), value);
      
      return;
    }
      
    if(j>=height()){
      setCell(i, j-height(), value);
      
      return;
    }
      
    grid[i][j] = value;
  }

  public int countNeighbours(int x, int y) {
    int cnt = 0;
    for (int[] offset : NEIGHBOURS) {
      if (this.getCell(x + offset[0], y + offset[1])) {
        cnt++;
      }
    }
    return cnt;
  }
  
  public int countNeighbours(int x, int y, Board b) {
    int cnt = 0;
    for (int[] offset : NEIGHBOURS) {
      if (b.getCell(x + offset[0], y + offset[1])) {
        cnt++;
      }
    }
    return cnt;
  }
  
  public void randomize(float probability){
    for (int i = 0; i<wid; i++)
      for (int j = 0; j<hei; j++)
        this.setCell(i, j, Math.random()<probability);
  }

  public Board clone() {
    return new Board(this);
  }
}
