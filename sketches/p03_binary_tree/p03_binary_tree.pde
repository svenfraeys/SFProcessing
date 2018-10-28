Boolean mInsertValues = false;
class Node{
  Integer mValue;
  Node mLeft;
  Node mRight;
  
  Node(Integer value){
    mValue = value;
  }
  Integer value(){
    return mValue;
  }
  
  void addNode(Node node){
    if (node.value() < mValue) {
      if (mLeft != null) {
        if (mInsertValues && node.value() > mLeft.value()) {
          if (mLeft.mRight != null){
            node.mRight = mLeft.mRight;
          }
          node.mLeft = mLeft;
          
          mLeft = node;
        } else{
          mLeft.addNode(node);          
        }
      } else{
        mLeft = node;
      }
      
    } else if (node.value() > mValue) {
      if (mRight != null) {
        if (mInsertValues && node.value() < mRight.value()) {
          if (mRight.mLeft != null){
            node.mLeft = mRight.mLeft;
          }
          node.mRight = mRight;
          
          mRight = node;
        } else{
          mRight.addNode(node);          
        }
      }else{
        mRight = node;
      }
    }
  }
  
  void visit(){
    if (mLeft != null){
      mLeft.visit();
    }
    print(mValue);
    
    if (mRight != null){
      mRight.visit();
    }
  }
  
  void draw(Integer x, Integer y, Integer depth){
    Integer offset = 60 / (depth + 1);
    if (mLeft != null) {
      line(x, y, x - offset, y + 30);
      mLeft.draw(x -offset, y + 30, depth+1);
    }
    
    if (mRight != null) {
      line(x, y, x + offset, y + 30);
      mRight.draw(x + offset, y + 30, depth+1);
    }
    fill(mValue, mValue, mValue);
    ellipse(x, y, 10, 10);
    textAlign(CENTER);
    fill(255,255,255);
    // text(mValue, x, y - 5);
  }
  
}

class Tree{
  Node mRoot;
  void addNode(Node n){
    if (mRoot == null){
      mRoot = n;
    } else{
      mRoot.addNode(n);
    }
  }
  void draw(Integer x, Integer y){
     if (mRoot != null)
        mRoot.draw(x, y, 0);
  }
  
  void traverse(){
    if (mRoot != null){
      mRoot.visit();
    }
  }
  
  void clear(){
    mRoot = null;
  }
  
  

}

Tree mTree;

void generate(){
  // mTree.clear();
  Node n;
  for (int i = 0; i < 1; i++){
    n = new Node((int)random(1,255));
    mTree.addNode(n);
  }
}

void keyPressed(){
  mTree.clear();
}

void mousePressed(){
  generate();
}

void setup(){
  noCursor();
  size(300, 300);
  mTree = new Tree();
}
  
void draw(){
  background(120);
  mTree.draw(width / 2, 20);
}
