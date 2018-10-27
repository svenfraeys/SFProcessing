Float mLearningRate = 0.01f;

Float sigmoid(Float x){
  return 2.f / (1.f + exp(-2.f * x)) - 1.f;
}

class Neuron{
  ArrayList<Neuron> mInputs = new ArrayList<Neuron>();
  ArrayList<Float> mWeights = new ArrayList<Float>();
  Float mOutput;
  Float mError = 0.f;
  
  Neuron(){};
  Neuron(ArrayList<Neuron> previousLayer){
    for (int i = 0; i < previousLayer.size() ; i++){
      mInputs.add(previousLayer.get(i));
      mWeights.add(random(-1.f,1.f));
    }
  }
  
  void setError(Float desired) {
    mError = desired - mOutput;
  }
  
  Float output(){
    return mOutput;
  }
  
  void setOutput(Float value){
    mOutput = value;
  }
  
  void respond(){
    Float sumInput = 0.f;
    for (int i = 0; i < mInputs.size() ; i++){
      sumInput += mInputs.get(i).output() * mWeights.get(i);
    }
    mOutput = sigmoid(sumInput);
    
  }
  
  void train(){
    
    float delta = (1.f - mOutput) * (1.f + mOutput) * mError * mLearningRate;
    for (int i = 0; i < mInputs.size(); i++){
      mInputs.get(i).mError += mWeights.get(i) * mError;
      Float w = mWeights.get(i) + mInputs.get(i).mOutput * delta;
      // print(mWeights.get(i) + " > " + w + "\n");
      mWeights.set(i, w);
    }
  }
  
}

class NeuralNetwork{
  int mInputs;
  int mOutputs;
  int mTotalHiddenNeurons;
  ArrayList<Neuron> mInputLayer = new ArrayList<Neuron>();
  ArrayList<Neuron> mOutputLayer = new ArrayList<Neuron>();
  ArrayList<Neuron> mHiddenLayer = new ArrayList<Neuron>();
  
  NeuralNetwork(int inputs, int totalHiddenNeurons, int outputs){
    mInputs = inputs;
    mOutputs = outputs;
    mTotalHiddenNeurons = totalHiddenNeurons;
    
    for(int i = 0; i < mInputs; i++){
      Neuron n = new Neuron();
      mInputLayer.add(n);
    }
    
    for(int i = 0; i < mTotalHiddenNeurons; i++){
      Neuron n = new Neuron(mInputLayer);
      mHiddenLayer.add(n);
    }
    
    for(int i = 0; i < mOutputs; i++){
      Neuron n = new Neuron(mHiddenLayer);
      mOutputLayer.add(n);
    }
  }
  
  void respond(ArrayList<Float> data){
    for(int i = 0; i < mInputs; i++){
      Neuron n = mInputLayer.get(i);
      Float v = data.get(i);
      n.setOutput(v);
    }
    
    for(int i = 0; i < mTotalHiddenNeurons; i++){
      mHiddenLayer.get(i).respond();
    }
    
    for(int i = 0; i < mOutputs; i++){
      mOutputLayer.get(i).respond();
    }
  }
  
  ArrayList<Neuron> outputLayer(){
    return mOutputLayer;
  }
  
  void train(ArrayList<Float> inputs, ArrayList<Float> targets){
    ArrayList<Float> error = new ArrayList<Float>();
    for(int i = 0; i < mOutputs; i++){
      mOutputLayer.get(i).setError(targets.get(i));
      mOutputLayer.get(i).train();
      error.add(targets.get(i) - mOutputLayer.get(i).output());
    }
    
    for (int j = 0; j < mTotalHiddenNeurons; j++){
      mHiddenLayer.get(j).train();
    }
    
  }
}

void pickColor(){
  mR = (int)(random(0, 1) * 255.f);
  mG = (int)(random(0, 1) * 255.f);
  mB = (int)(random(0, 1) * 255.f);
};

Integer mR = 0;
Integer mG = 0;
Integer mB = 0;
Integer mBrainWhitePercentage = 0;
Integer mBrainBlackPercentage = 0;
String mPrediction = "white";
NeuralNetwork mNetwork;

void respondColor(){
  ArrayList<Float> d = new ArrayList<Float>() {{
    add((float)mR / 255.0);
    add((float)mG / 255.0);
    add((float)mB / 255.0);
  }};
  mNetwork.respond(d);
  Neuron blackOutput = mNetwork.outputLayer().get(0);
  Neuron whiteOutput = mNetwork.outputLayer().get(1);
  
  Float b = (blackOutput.output() + 1.f);
  Float w = (whiteOutput.output() + 1.f);
  mBrainBlackPercentage = (int)((b / (b + w)) * 100.f);
  mBrainWhitePercentage = (int)((w / (b + w)) * 100.f);
  
  if (blackOutput.output() > whiteOutput.output()){
    mPrediction = "black";
  }else {
    mPrediction = "white";
  }
  
}

void setup(){
  size(300, 300);
  mNetwork = new NeuralNetwork(3, 3, 2);
  ArrayList<Float> d = new ArrayList<Float>() {{
    add(1.f);
    add(1.f);
    add(1.f);
  }};
  mNetwork.respond(d);
  Float a = mNetwork.mOutputLayer.get(0).mOutput;
  pickColor();
  noLoop();
}

void mousePressed(){
  ArrayList<Float> targets = new ArrayList<Float>();
  
  ArrayList<Float> inputs = new ArrayList<Float>() {{
    add((float)mR / 255.0);
    add((float)mG / 255.0);
    add((float)mB / 255.0);
  }};
  
  if (mouseY > height / 2){
    targets.add(0.f);
    targets.add(1.f);
    
  }else{
    targets.add(1.f);
    targets.add(0.f);
  }
  
  
  mNetwork.train(inputs, targets);
  
  pickColor();
  respondColor();
  redraw();
}

void draw(){
  background(mR, mG, mB);
  
  stroke(20);
  strokeWeight(5);
  line(0, height/2, width, height/2);
  
  textSize(52);
  noStroke();
  fill(0);
  textAlign(CENTER);
  text("black " + mBrainBlackPercentage, 150, 100);
  fill(255);
  text("white " + mBrainWhitePercentage, 150, 250);
  if (mPrediction == "white"){
    noStroke();
    fill(255);
    ellipse(25, 235, 20, 20);
  }
  if (mPrediction == "black"){
    noStroke();
    fill(0);
    ellipse(25, 85, 20, 20);
  }
}
