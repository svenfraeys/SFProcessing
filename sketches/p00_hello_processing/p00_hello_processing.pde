int cellSize = 25;

color alive = color(0, 255, 255);
color bg = color(0, 0, 0);
PVector screenDiagonal = new PVector(300, 300);

public void setup(){
  size(300, 300);
  noSmooth();

  background(0);
}

public void draw(){
  float tx = (cos(frameCount / 50.0) ) * width;
  float ty = (sin(frameCount / 50.0) ) * height;
  
  // ellipse(width / 2.0, height / 2.0, width, height);
  for (int y = 0; y < height / cellSize; y++){
    for (int x = 0; x < width / cellSize; x++){
      PVector v = new PVector(x * cellSize + cellSize / 2, y * cellSize + cellSize / 2);
      PVector mouseVec = new PVector(tx, ty);    
      float distance = mouseVec.sub(v).mag() / screenDiagonal.mag();
      
      color c = color(distance * 150, 180 - distance * 180, 160 - distance * abs(cos(frameCount / 100.0)) * 160);
      fill(c);
      stroke(c);
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }

}
