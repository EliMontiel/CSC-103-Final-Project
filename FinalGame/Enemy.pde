class Enemy{
  //variables//
  int x;
  int y;
  int d;
  Animation eAnimation;
  
  //hitbox vars//  
  int left;
  int right;
  int top;
  int bottom;
  
  boolean isPunching;
  
  boolean isJumping;
  boolean isFalling;
  
  int xspeed;
  int yspeed;
  
  boolean shouldDie;
    
  Enemy(int x1,int y1,Animation sAnimation){   
       
    x=x1;
    y=y1;
    d=30;
    eAnimation=sAnimation;
    
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2; 
    
    isPunching=false;
    
    isJumping=false;
    isFalling=false;
    
    xspeed=20;
    yspeed=20;
    
    shouldDie=false;
  }
  
  //display enemies//
  void render(){
    rectMode(CENTER);
    imageMode(CENTER);
    eAnimation.display(x,y);      
  }

  //if enemy and player collide, prevent player from walking through enemy
  //and allow player to punch enemy//
  void playerEnemyCollisions(Player aPlayer){
    
    //colliding at left//
    if(aPlayer.top<=bottom &&
    aPlayer.bottom>=top &&
    aPlayer.left<=left &&
    aPlayer.right>=left){
      
      aPlayer.ismovingRight=false;
      aPlayer.x=left-aPlayer.w/2;
    }  

    //colliding at right//
    if(aPlayer.top<=bottom &&
    aPlayer.bottom>=top &&
    aPlayer.left<right &&
    aPlayer.right>=right){
      
      aPlayer.ismovingLeft=false;
      aPlayer.x=right+aPlayer.w/2;
    }
    
    //if player punches enemy, remove enemy//
    if(aPlayer.top<=bottom &&
    aPlayer.bottom>=top &&
    aPlayer.left<=right &&
    aPlayer.right>=left){
    
      isPunching=true; 
      
      if(key=='p'){
       shouldDie=true; 
       hitMusic.play();
      }
    }  
  } 
    
  void EnemyenemyCollision(Enemy otherEnemy) {
    if (top < otherEnemy.bottom) {
      if (bottom > otherEnemy.top) {
        if (left < otherEnemy.right) {
          if (right > otherEnemy.left) {
            
            // if the current enemy is to the left of otherenemy
            if (x < otherEnemy.x) {
              xspeed = -abs(xspeed); // make current enemy xSpeed negative
              otherEnemy.xspeed = abs(otherEnemy.xspeed); // make other enemy xSpeed positive
            } else if (x >= otherEnemy.x) { // if current enemy is to the right of otherenemy
              xspeed = abs(xspeed); // make current enemy xSpeed positive
              otherEnemy.xspeed = -abs(otherEnemy.xspeed); // make other enemy xSpeed negative

            }

            // if the current enemy is to the above the otherBall
            if (y < otherEnemy.y) {
              x=x+5;
            } else if (y >= otherEnemy.y) { // if current enemy is to the below of otherenemy
              x=x-5;
            }
          }
        }
      }
    }
  }

  //allow enemy to fall when spawn//
  void jump(){
    if(isJumping==true){
      y=y-yspeed;
    }

  //update enemy bounds//    
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2;
  }
  
  //allow enemy to fall after jump//
  void fall(){
    if(isFalling==true){
      y=y+yspeed;
    }
  }
  
  void land(){
    if(y>=height-d/2){
      isFalling=false; //stop falling//
      y=height-d/2; //enemy stands on bottom of screen
    }
  }
  
void fallPlatformEnemy(ArrayList<Platform>aPlatformList){
  
  //check enemy is not mid jump and not on ground//
  if(isJumping==false && y<height-d/2){ 
     boolean onPlatform=false;
    
    for(Platform aPlatform:aPlatformList){
      
      //if enemy is colliding with platform//
      if(top<=aPlatform.bottom && 
      bottom>=aPlatform.top &&
      left<=aPlatform.right && 
      right>=aPlatform.left){
        onPlatform=true;
      }
    }
    
    if(onPlatform==false){
      isFalling=true;
   }
  }
 }
}
