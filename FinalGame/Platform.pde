class Platform{
  
  //variables//
  int x;
  int y;
  int w;
  int h;
  color platColor;  
  
  //hitbox vars//  
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor//
  Platform(int x1,int y1, color c1){
    x=x1;
    y=y1;
    w=150;
    h=10;
    platColor=c1; 
    
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }
  
  //display platforms//
  void render(){
    rectMode(CENTER);
    fill(platColor);
    rect(x,y,w,h);
  }
  
  void collision(Player aPlayer){
    
  //if player collides with a platform//    
    if(left<=aPlayer.right &&
    right>=aPlayer.left && 
    top<=aPlayer.bottom && 
    bottom>=aPlayer.top ){
      
      aPlayer.isFalling=false; //stop falling//
      aPlayer.y=y-h/2-aPlayer.h/2;
    }
  }
  
  void enemyCollision(Enemy aEnemy){
    
  //if enemy collides with a platform//    
    if(left<=aEnemy.right &&
    right>=aEnemy.left && 
    top<=aEnemy.bottom && 
    bottom>=aEnemy.top ){
      
      aEnemy.isFalling=false; //stop falling//
      aEnemy.y=y-h/2-aEnemy.d/2; 
    }
  } 
}
