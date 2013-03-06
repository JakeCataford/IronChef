class Goods{
  private float radius = 10;
  public PVector position;
  public boolean isCollected = false;
  private Boat ref;
  
  Goods(Boat reference) {
     position = new PVector(random(0,width),random(0,height));
     ref = reference;
  }
  
  void update() {
     if(ref.position.dist(position) < radius){
        isCollected = true; 
     } 
  } 
  
  void render() {
     if(!isCollected) {
        pushMatrix();
        translate(position.x,position.y);
        fill(255);
        ellipse(0,0,radius,radius);
        popMatrix();
     }else{
       position.set(random(0,width),random(0,height),0);
       isCollected = false; 
     }
  }
}
