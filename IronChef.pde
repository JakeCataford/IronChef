import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

int sensorPin1 = 0;
int sensorPin2 = 1;

float prevRowR = 0;

float prevRowL = 0;
float rowR = 0;
float rowL = 0;

ArrayList <Goods> goods;
ArrayList <Bads> bads;
ArrayList <Patrollers> patrollers;

color off = color(4, 79, 111);
color on = color(84, 145, 158);
Boat boat;

float countDown = 200;

void setup() {
  size(800,800);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  goods = new ArrayList();
  bads = new ArrayList();
  patrollers = new ArrayList();
  
  boat = new Boat();
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
  
  arduino();
  if(rowL - prevRowL > 0) {
     float rowamt = rowL - prevRowL;
     boat.row(rowamt,0);
  }
  
   if(rowR - prevRowR > 0) {
     float rowamt = rowR - prevRowR;
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
  prevRowL = rowL;
  prevRowR = rowR;
  
  
  
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

void arduino() {
  float val1 = arduino.analogRead( sensorPin1 );
  float val2 = arduino.analogRead( sensorPin2 );
  
  val1 = map(val1, 450, 380, 10, 0);
  val1 = constrain(val1, 0, 10);
  
  val2 = map( val2, 500, 300, 10, 0 );
  val2 = constrain( val2, 0, 10 );
  
  println( "mapped flex sensor 1: " + val1 );
  println( "mapped flex sensor 2: " + val2 );
  
  rowR = val1;
  rowL = val2;
  
  
}

