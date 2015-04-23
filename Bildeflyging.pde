import java.util.*;
import processing.serial.*;

Serial minport;
int x;
int y;

PImage bilde;
PImage bg;
HashMap<Maur,Maur> hmmaur = new HashMap<Maur,Maur>();
int spawnrate = 1000;
int lastSpawn = 0;
int killed = 0;

void setup(){
  size(1000,700);
  bilde = loadImage("Bille.png");
  bg = loadImage("earth.jpg");
  minport = new Serial(this, Serial.list()[0], 9600);
}



void draw(){
  String fraArduino = null;
  
  if(minport.available()>0){
    fraArduino = minport.readStringUntil('\n');
  }
  
  if(fraArduino != null){
    fraArduino = fraArduino.trim();
    int temp = -1;
    try{
      //println(fraArduino);
      if(fraArduino.charAt(0) == 'v'){
        temp = parseInt(fraArduino.substring(1));
        y = (int)map(temp, 0, 1023, 0, 800);
      } else if(fraArduino.charAt(0) == 'h'){
        temp = parseInt(fraArduino.substring(1)); 
        x = (int)map(temp, 0, 1023, 0, 1200);
      }
    }catch(Exception e){
    
    }//minport.clear();
  }
  
  background(0);
  //background(bg);
  fill(255,33,1);
  text("Killed: " +killed,850,50);
  noStroke();
  //maur kjem
    for(Maur m:hmmaur.values()){
    m.draw();
   // if(m.y+m.height<0){
     // hmmaur.remove(m);
  //  }
  } 
    if((millis()-spawnrate)>lastSpawn){
    Maur m1 = new Maur();
    hmmaur.put(m1,m1);
    lastSpawn = millis();
  }  
  
  //fill(255);
  //rect(mouseX,mouseY,10,10);
  //tissing!!
  if(mousePressed == true){
    fill(255,255,0);
    rect((x+50),(y+53), 1000, 4); // x-10 og y+13
    for(Maur r:hmmaur.values()){
      if((y+53)<(r.y+r.height)&&(y+57)>(r.y)&&r.x>(x+(bilde.width/2)-180)){
    //  if((mouseY+13)<(r.y+r.height)&&(mouseY+18)>(r.y)&&r.x>(mouseX+(bilde.width/3)-150)){ 
        if(r.alive){
          killed ++;
        }
        r.alive = false;
      }   
    }
  }
  
  //fill(0,255,0);
  //triangle(mouseX,mouseY,(mouseX+140),(mouseY+5),70,70);
  image(bilde,x,y, bilde.width/3, bilde.height/3);
  //image(bilde,mouseX-70,mouseY-40, bilde.width/3, bilde.height/3);  
}

