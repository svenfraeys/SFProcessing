
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
        mLeft.addNode(node);
      } else{
        mLeft = node;
      }
      
    } else if (node.value() > mValue) {
      if (mRight != null) {
        mRight.addNode(node);
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
  
  void draw(Integer x, Integer y){
    
    if (mLeft != null) {
      line(x, y, x - 20, y + 30);
      mLeft.draw(x - 20, y + 30);
    }
    
    if (mRight != null) {
      line(x, y, x + 20, y + 30);
      mRight.draw(x + 20, y + 30);
    }
    
    ellipse(x, y, 10, 10);
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
      mRoot.draw(x, y);
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

void mousePressed(){
  mTree.clear();
  Node n;
  for (int i = 0; i < 50; i++){
    n = new Node((int)random(1,200));
    mTree.addNode(n);
  }
}

void setup(){
  noCursor();
  size(300, 300);
  mTree = new Tree();
  Node n = new Node(5);
  mTree.addNode(n);
  
  n = new Node(1);
  mTree.addNode(n);
  
  n = new Node(8);
  mTree.addNode(n);
  
  n = new Node(15);
  mTree.addNode(n);
  
  n = new Node(3);
  mTree.addNode(n);
  
  n = new Node(40);
  mTree.addNode(n);
  
  for (int i = 0; i < 500; i++){
    n = new Node((int)random(1,200));
    mTree.addNode(n);
  }
}
  
void draw(){
  background(120);
  mTree.draw(width / 2, 20);
}
