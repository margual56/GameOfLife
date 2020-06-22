int cs = 20;
int w = 50;
int h = 50;
int rate = 4;

Board grid;

boolean go = true;

PImage red_Alive, red_Dead;

void settings() {
  size(w*cs, h*cs);
}

void setup() {
  //Get images
  red_Alive = loadImage("red_Alive_dead.png");

  grid = new Board(w, h);

  frameRate(60);
}

void draw() { 
  background(0);
  
  rate = round(threesRule(60, 4, frameRate));
  rate = rate<1?1:rate;
  
  stroke(255, 100);
  drawGrid();
  drawCells();

  if (go && frameCount%rate==0) {
    updateCells();
  }

  textSize(40);
  textAlign(LEFT, CENTER);
  fill(255);
  text((!go?"NOT ":"") + "GO", 20, 20);
  
  noStroke();
}

void drawGrid() {
  for (int x = cs; x<width; x+=cs)
    line(x, 0, x, height);

  for (int y = cs; y<height; y+=cs)
    line(0, y, width, y);
}

void drawCells() {
  for (int i = 0; i<grid.width(); i++)
    for (int j = 0; j<grid.height(); j++) 
      if (grid.getCell(i, j))
        image(red_Alive, i*cs+1, j*cs+1, cs-1, cs-1);
}


void updateCells() {
  Board tmp = grid.clone();
  
  for (int i = 0; i<grid.width(); i++)
    for (int j = 0; j<grid.height(); j++) {
      int sum = tmp.countNeighbours(i, j, tmp);

      if (grid.getCell(i, j))
        grid.setCell(i, j, sum>=2 && sum<=3);
      else
        grid.setCell(i, j, sum==3);
    }
}

void mousePressed() {
  int x = (int)mouseX/cs;
  int y = (int)mouseY/cs;

  grid.setCell(x, y, !grid.getCell(x, y));
}

void keyPressed() {
  if (key==' ')
    go = !go;
    
  if(keyCode == ENTER)
    grid = new Board(w, h);
    
  if(key == 'r')
    grid.randomize(0.25);
}

float threesRule(float a1, float a2, float b1){
  return a2*b1/a1;
}
