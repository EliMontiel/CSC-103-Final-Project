class Bullet{
  
  //variables//
  int x;
  int y;
  int d;
  
  int speed;
  
  color c1;
  
  boolean shouldRemove;
  
  //hitbox vars//  
  int left;
  int right;
  int top;
  int bottom;
  
  //constuctor//
  Bullet(int x1,int y1){
    x=x1;
    y=y1;
    d=10;
    
    speed=10;
    
    c1=color(255,0,0);
    
    shouldRemove=false;
    
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2;  
  }
  
  //display bullet//
  void render(){
    fill(c1);
    circle(x,y,d);
  }
  
  //allow bullet to move toward left//
  void move(){
    x-=speed;
    
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2; 
  }
  
  //remove bullet after it goes past screen//
  void checkRemove(){
    if(x<0){
      shouldRemove=true;
    }
  }
  
  //collision of bullet with player//
  void shootPlayer(Player aPlayer){
    if(top<=aPlayer.bottom &&     
       bottom>=aPlayer.top &&
       left<=aPlayer.right &&
       right>=aPlayer.left){
         
         println("hit");
         pHealth-=1;  
    }
  }
}
