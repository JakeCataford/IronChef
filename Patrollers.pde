class Patrollers{
  private float radius = 20;
  public PVector position;
  public boolean isCollected = false;
  private Boat ref;
  
  Patrollers(Boat reference) {
     position = new PVector(random(0,width),random(0,height));
     ref = reference;
  }
  
  void update() {
    
    PVector v = new PVector(position.x + sin((float)frameCount/100)*100, position.y);
    if(ref.position.dist(v) < radius){
        isCollected = true; 
     } 
     
   
  } 
  
  void render() {
     if(!isCollected) {
        pushMatrix();
        translate(position.x + sin((float)frameCount/100)*100,position.y);
        fill(0,255,0);
        ellipse(0,0,radius,radius);
        popMatrix();
     }else{
       boat.isDead = true;
     }
  }
}
