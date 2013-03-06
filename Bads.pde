class Bads{
  private float radius = 30;
  public PVector position;
  public boolean isCollected = false;
  private Boat ref;
  
  Bads(Boat reference) {
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
        fill(255,0,0);
        ellipse(0,0,radius,radius);
        popMatrix();
     }else{
       ref.isDead = true; 
     }
  }
}
