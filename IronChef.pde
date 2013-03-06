import processing.serial.*;

///import cc.arduino.*;

//Arduino arduino;

float prevRowR = 0;

float prevRowL = 0;

ArrayList <Goods> goods;
ArrayList <Bads> bads;
ArrayList <Patrollers> patrollers;

color off = color(4, 79, 111);
color on = color(84, 145, 158);
Boat boat;

float countDown = 200;

void setup() {
  size(800,800);
  
  goods = new ArrayList();
   bads = new ArrayList();
   patrollers = new ArrayList();
  
  boat = new Boat();
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  boat.init();
  
  for(int i = 0; i < 3; i ++){
    goods.add(new Goods(boat)); 
  }
  for(int i = 0; i < 3; i ++){
    bads.add(new Bads(boat)); 
  }
  
  for(int i = 0; i < 4; i ++){
    patrollers.add(new Patrollers(boat)); 
  }
}

void reset() {
 countDown = 200;
 boat.position.set(400,400,0);
 boat.isDead = false; 
  
 goods.clear();
 bads.clear();
 patrollers.clear(); 
 
 for(int i = 0; i < 3; i ++){
    goods.add(new Goods(boat)); 
 }
 for(int i = 0; i < 3; i ++){
    bads.add(new Bads(boat)); 
 }
  
 for(int i = 0; i < 4; i ++){
    patrollers.add(new Patrollers(boat)); 
 }
  
}

void draw() {
  background(off);
  stroke(on);
  
  
  if(mouseX - prevRowL > 0) {
     float rowamt = mouseX - prevRowL;
     rowamt = map(rowamt,0,width,0,10);
     boat.row(rowamt,0);
  }
  
   if(mouseY - prevRowR > 0) {
     float rowamt = mouseY - prevRowR;
     rowamt = map(rowamt,0,height,0,10);
     boat.row(0,rowamt);
  }
  
  
  if(!boat.isDead) {
    boat.update();
    
  }else{
    countDown--; 
  }
  
  if(countDown <0) {
   reset(); 
  }
  
  
  
  
  boat.render();
  prevRowL = mouseX;
  prevRowR = mouseY;
  
  
  
  for(int i = 0; i < goods.size(); i ++){
    goods.get(i).update();
    if(goods.get(i).isCollected){
      
      //score++
       patrollers.clear();
       bads.clear();
      
       
    } 
    goods.get(i).render();
    
  }
  
   while(bads.size() < 10){
         bads.add(new Bads(boat)); 
   }
    while(patrollers.size() < 4){
         patrollers.add(new Patrollers(boat)); 
   }
  
  for(int j = 0; j < bads.size(); j ++){
    bads.get(j).update();
    bads.get(j).render();
  }
  
  for(int j = 0; j < patrollers.size(); j ++){
    patrollers.get(j).update();
    patrollers.get(j).render();
  }
}

void keyPressed() {
  if (key == 'a') {
   
  } else {
    boat.row(0,10);
  }
}

