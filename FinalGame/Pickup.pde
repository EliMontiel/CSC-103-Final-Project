class Pickup{
  //variables//
  int x;
  int y;
  int d;
  color itemColor;
  
  //hitbox vars//
  int left;
  int right;
  int top;
  int bottom;
  
  boolean isPickingUp;
  
  boolean shouldgo;
  
  Animation aAnimation;
  
  Pickup(int x1,int y1,Animation sAnimation){
    
    //initializing vars//
    x=x1;
    y=y1;
    d=20;
    itemColor=color(255,255,0);
    aAnimation=sAnimation;
    
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2;
    
    isPickingUp=false;
    shouldgo=false;
  }
  
  void render(){
    fill(itemColor);
    aAnimation.display(x,y);
  }

   //if item and player collide return true//
  void pickupItem(Player aPlayer){
    if(aPlayer.top<=bottom &&
    aPlayer.bottom>=top &&
    aPlayer.left<=right &&
    aPlayer.right>=left && key=='o'){
      
      isPickingUp=true;
      shouldgo=true;
      pScore+=1;
      collectMusic.play(); 
    } 
  }
}
