class Player{
  
  //player variables//
  int x;
  int y;
  int w;
  int h;

  boolean ismovingLeft;
  boolean ismovingRight;
  
  boolean isJumping;
  boolean isFalling;
  
  int speed;
  
  int jumpHeight;
  int topY;
  
  //hitbox vars//  
  int left;
  int right;
  int top;
  int bottom;
  
  
  //constructor//
  Player(int x1,int y1,int w1,int h1){
    x=x1;
    y=y1;
    w=w1;
    h=h1;   
    
    ismovingLeft=false;
    ismovingRight=false;
    
    isJumping=false;
    isFalling=false;
    
    speed=10;
    
    jumpHeight=100; //distance player allowed to jump upwards//
    topY=y-jumpHeight; //hightest y value of jump//
    
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }
  
  //functions//
  void render(){
    rectMode(CENTER);
    imageMode(CENTER);
    image(bmoImages[1],x,y,w,h);
    
    //if the music is not playing then play it//
    if(bgmMusic.isPlaying()==false){
      bgmMusic.play();
    } 
  }
  
  //allow player to move left/right//
  void move(){
    if(ismovingLeft==true){
      x=x-speed;
    }
    
    if(ismovingRight==true){
      x=x+speed;
    }
  }
  
  //allow player to jump//
  void jump(){
    if(isJumping==true){
      y=y-speed;
    }

  //update player bounds//    
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }
  
  //allow player to fall after jump//
  void fall(){
    if(isFalling==true){
      y=y+speed;
    }
  }
  
  void topJump(){
    if(y<=topY){
      isJumping=false; //stop jumping//
      isFalling=true; //start falling//
    }
  }
  
  void land(){
    if(y>=height-h/2){
      isFalling=false; //stop falling//
      y=height-h/2; //player stands on bottom of screen
    }
  }

//check if player is colliding with platform//
//if player is not colliding, start falling//
void fallPlatform(ArrayList<Platform>aPlatformList){
  
  //check player is not mid jump and not on ground//
  if(isJumping==false && y<height-h/2){
    boolean onPlatform=false;
    
    for(Platform aPlatform:aPlatformList){
      
      //if player is colliding with platform//
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
