Integer mCount = 0;
void setup(){
  noCursor();
  size(300,300);
  colorMode(HSB);
}

void mousePressed(){
  mCount = 0;
}

void draw(){
  background(0);
  Integer total = mCount;
  for(int n = -total; n < total; n++){
      
      Float c = 0.01f * n;
      c = 4.f;
      Float a = n * ((2.f * PI) / 360.f) * 137.5f;
      a += (float)frameCount / 100.f;
      // a = n * 137.5f;
      Float r = c * sqrt(n);
      
      float x = cos(a) * r + width / 2.f;
      float y = sin(a) * r + height / 2.f;
      fill(a % 256, 150,255);
      noStroke();
      ellipse(x, y, c, c);
      
      // ((float)PI / 360.f) * 137.f;
  }
  mCount += 1;
    
  
      
}
