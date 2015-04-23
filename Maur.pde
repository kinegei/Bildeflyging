class Maur{
  int x;
  int y;
  
  int width;
  int height;
  
  PImage rodmaur;
  PImage dodmaur;
  
  Boolean alive = true;
  
  Maur(){
    y = 700+5;
    x = (int)random(200,990);
    width = 25;
    height = 40;
    rodmaur = loadImage("rodmaur.png");
    dodmaur = loadImage("dodmaur.png");
    
  }

  void draw(){
    if(alive){
      image(rodmaur,x,y, width, height);
      y--;
    } else{
      image(dodmaur,x,y, width, height);
    }
  }   
}


