class Boat{
  
  private float DRAG = 0.96;
  private float PADDLE_INFLUENCE = 1;
  private PVector BOAT_SIZE = new PVector(40,20);
  private float MAX_SPEED;
  
  
  private boolean isDead = false;
  
  private float lastFlexPosition;
  
  private float speed = 0;
  private PVector direction;
  public PVector position;
  private float steering = 0;



  void Boat() {
  }
  
  void init() {
    direction = new PVector(0,1);
    position = new PVector(400,400);
  }
  
  void update() {
    
    direction.rotate(steering/100);
    direction.setMag(speed + 0.01);
    
    steering *= DRAG;
    
    speed *= DRAG;
    
    
    
    position.add(direction);
    
     if(position.x < 0 || position.x > width || position.y > height || position.y < 0) {
      isDead = true;
     }
  }
  
  void render() {
   
   if(isDead) {
      pushMatrix();
      translate(position.x,position.y);
      rotate(direction.heading());
      fill(255,0,0);
      rect(-(BOAT_SIZE.x/2),-(BOAT_SIZE.y/2),BOAT_SIZE.x,BOAT_SIZE.y);
      popMatrix();
    }else{
      pushMatrix();
      translate(position.x,position.y);
      rotate(direction.heading());
      fill(0,0,0);
      rect(-(BOAT_SIZE.x/2),-(BOAT_SIZE.y/2),BOAT_SIZE.x,BOAT_SIZE.y);
      popMatrix();
    }
  }
  
 void row(float left, float right) {
     
   left *= PADDLE_INFLUENCE;
   right *= PADDLE_INFLUENCE;
   
   steering += right;
   steering -= left;
   
   speed += (right + left)/2;
    
   
  }
    
  
  
}
