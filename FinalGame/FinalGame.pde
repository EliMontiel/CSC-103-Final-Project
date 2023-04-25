
//player is able to move around and jump on platforms and ground floor.
//when player and enemy collide and 'p' is pressed, the enemy is removed.
//when player and item collide and 'o' is pressed, the player passes onto the next level.
//player has to be careful of bullets from enemy that shoot every 5sec, when all enemies are killed, bullets stop shooting.
//if all 3 items are collected, player has won the game.
//if player gets hit by a bullet, player must restart at level one. 



//declaring my vars//
Player p1;

Enemy eA1;
Enemy eA2;
Enemy eA3;

Enemy eB1;
Enemy eB2;
Enemy eB3;
Enemy eB4;
Enemy eB5;


Enemy eC1;
Enemy eC2;
Enemy eC3;
Enemy eC4;
Enemy eC5;
Enemy eC6;
Enemy eC7;

Platform platA1;
Platform platA2;
Platform platA3;
Platform platA4;
Platform platA5;

Platform platB1;
Platform platB2;
Platform platB3;
Platform platB4;
Platform platB5;

Platform platC1;
Platform platC2;
Platform platC3;
Platform platC4;
Platform platC5;
Platform platC6;

Pickup iA1;
Pickup iB1;
Pickup iC1;

ArrayList<Platform>platformList;

ArrayList<Enemy>enemyList;

ArrayList<Bullet>bulletList;

ArrayList<Pickup>itemList;

Animation bmoAnimation;
PImage[] bmoImages=new PImage[2];

Animation enemyAnimation;
PImage[] enemyImages=new PImage[2];

Animation itemAnimation;
PImage[] appleImages=new PImage[3];

PImage startImage;
PImage gridImage;
PImage winImage;
PImage looseImage;
PImage lightImage;
PImage blueImage;

PFont font;

//sound//
import processing.sound.*;

SoundFile introMusic;
SoundFile bgmMusic;
SoundFile jumpMusic;
SoundFile winMusic;
SoundFile looseMusic;
SoundFile collectMusic;
SoundFile hitMusic;

//var representing what state were in//
int state=0;

//boolean to run "setup" once//
boolean ready = false;

// player health positions//
int pHealthX;
int pHealthY;

//key amount positions//
int keyX;
int keyY;

// scores//
int pScore=0;
int pHealth=1;
int winScore=3;

color textColor=color(0,255,0);

// time stopwatch starts//
int startTime;

// time lap button is pressed//
int currentTime;

// time between timer triggers//
int interval=4000;

void setup(){
  size(1000,600);
  imageMode(CENTER);
  textAlign(CENTER);
  textSize(50);
  font=loadFont("Impact-48.vlw");
  textFont(font);

  //start stopwatch//
  startTime=millis();

  //initialize my vars//
  p1=new Player(50,550,50,50);

  eA1=new Enemy(int(random(30,200)),int(random(0,600)),enemyAnimation);  //,int(random(20,80)),int(random(20,80))
  eA2=new Enemy(int(random(300,600)),int(random(0,600)),enemyAnimation); //,int(random(20,80)),int(random(20,80))
  eA3=new Enemy(int(random(700,930)),int(random(0,600)),enemyAnimation); //,int(random(20,80)),int(random(20,80))
  
  enemyList=new ArrayList<Enemy>();
  enemyList.add(eA1);
  enemyList.add(eA2);
  enemyList.add(eA3);

  bulletList=new ArrayList<Bullet>();
  
  iA1=new Pickup(100,165,itemAnimation);

  itemList=new ArrayList<Pickup>();
  itemList.add(iA1);

  platA1=new Platform(width/2,500,color(random(10,40),random(20,120),random(10,40)));
  platA2=new Platform(width/2+200,400,color(random(10,40),random(20,120),random(10,40)));
  platA3=new Platform(200,550,color(random(10,40),random(20,120),random(10,40)));
  platA4=new Platform(100,200,color(random(10,40),random(20,120),random(10,40)));
  platA5=new Platform(400,300,color(random(10,40),random(20,120),random(10,40)));

  platformList=new ArrayList<Platform>();
  platformList.add(platA1);
  platformList.add(platA2);
  platformList.add(platA3);
  platformList.add(platA4);
  platformList.add(platA5);

    //bmo animations//  
    for(int index=0; index<2; index++){
    bmoImages[index]=loadImage("bmo"+index+".png");
  }
    bmoAnimation=new Animation(bmoImages,0.1,2);
    
    //enemy animations//  
    for(int index=0; index<enemyImages.length; index++){
    enemyImages[index]=loadImage("enemy"+index+".png");
  }
    enemyAnimation=new Animation(enemyImages,0.1,3);
    
    //item animations//  
    for(int index=0; index<appleImages.length; index++){
    appleImages[index]=loadImage("apple"+index+".png");
  }
    itemAnimation=new Animation(appleImages,0.1,4);
      
    //setting the background images//
    startImage=loadImage("StartCover.png");
    startImage.resize(width,height);
    
    gridImage=loadImage("grid.jpg");
    gridImage.resize(width,height);
    
    winImage=loadImage("win.png");
    winImage.resize(width,height);
    
    looseImage=loadImage("loose.jpg");
    looseImage.resize(width,height);
    
    lightImage=loadImage("light.png");
    lightImage.resize(width,height);
    
    blueImage=loadImage("blue.png");
    blueImage.resize(width,height);
    
    //sound//
    introMusic=new SoundFile(this,"intro.mp3");
    bgmMusic=new SoundFile(this,"bgm.mp3");
    jumpMusic=new SoundFile(this,"jump.wav");
    winMusic=new SoundFile(this,"win.mp3");
    looseMusic=new SoundFile(this,"loose.mp3");
    collectMusic=new SoundFile(this,"collect.wav");
    hitMusic=new SoundFile(this,"hit.wav");
    
    //player health//
    pHealthX=width-65;
    pHealthY=50;
    
    //number of keys collected//
    keyX=width-600;
    keyY=50;    
}

void draw(){
  switch(state){
    case 0:
      titleScreen();
      break;

    case 1:
      levelOne();
      break;  

    case 2:
      levelTwo();
      break;

    case 3:   
      levelThree();
      break;

    case 4:
      playerWinScreen();
      break;

    case 5:
      playerLooseScreen();
      break;
  }  
}

void keyPressed(){
  //if a/d is pressed move player left/right//
  if(key=='a'){
    p1.ismovingLeft=true;
    bmoAnimation.isAnimating=true;
  }
  
  if(key=='d'){
    p1.ismovingRight=true;
    bmoAnimation.isAnimating=true;
  }

  //if w is pressed allow player to jump/fall//
  if(key=='w' && p1.isJumping==false && p1.isFalling==false){
    p1.isJumping=true; //start a new jump//
    p1.topY=p1.y-p1.jumpHeight;
    jumpMusic.play();   
  }
 
  //if spacebar is pressed reset to level one//
  if(key==' '){
    bgmMusic.stop();
    introMusic.stop();
    winMusic.stop();
    looseMusic.stop();
    
    setup();
    state=1;
    pScore=0;
    pHealth=1;
  }
}

void keyReleased(){
  if(key=='a'){
    p1.ismovingLeft=false;
  }
  
  if(key=='d'){
    p1.ismovingRight=false;
  }
}

void drawHealth(int health,int x,int y,color c){
  fill(c);
  text("Health",width-180,50);
  text(health,x,y);
}

void drawkeyAmount(int keyNumber,int x,int y,color c){
  fill(c);
  text("Apple's Collected",width-800,50);
  text(keyNumber,x,y);
}

void titleScreen(){
  background(startImage);
  
     //if the music is not playing then play it//
    if(introMusic.isPlaying()==false){
      introMusic.play();
    } 

  fill(25,82,32);
  rect(200,510,600,80);
  fill(textColor);
  text("Press the Space Bar to Start", 500, 565); 
}

void levelOne(){
    background(gridImage);
    
    p1.render();
    p1.move();
    p1.jump();
    p1.fall();
    p1.topJump();
    p1.land();
    p1.fallPlatform(platformList);
    
    bmoAnimation.display(p1.x,p1.y);
    iA1.aAnimation.isAnimating=true;
    
    //forloop to go through all enemies//  
    for(Enemy anEnemy:enemyList){
      anEnemy.render();
      anEnemy.playerEnemyCollisions(p1);
      
      anEnemy.jump();
      anEnemy.fall();
      anEnemy.land();
      anEnemy.fallPlatformEnemy(platformList);
      
      //make enemy bounce off of eachother
      for(Enemy anotherEnemy:enemyList){
        if(anEnemy!=anotherEnemy){
          anEnemy.EnemyenemyCollision(anotherEnemy);
        }
      }
    }
    
    //for loop to go through all bullets//
    for(Bullet aBullet:bulletList){
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      aBullet.shootPlayer(p1);
    }
    
    //forloop that removes unwanted bullets//
    for(int i=bulletList.size()-1;i>=0;i=i-1){
      Bullet aBullet=bulletList.get(i);
      
      if(aBullet.shouldRemove==true){
        bulletList.remove(aBullet);
      }
    }
    
    //update current time
    currentTime=millis();
    
      // if time passed is more than 
      //4sec print something
      if(currentTime-startTime>interval && enemyList.size()>=1){
          bulletList.add(new Bullet(eA1.x,eA1.y));
          bulletList.add(new Bullet(eA2.x,eA2.y));
          bulletList.add(new Bullet(eA3.x,eA3.y));
          eA1.eAnimation.isAnimating=true;
         
          //reset timer
          startTime=millis();   
      }
      
    //forloop that removes killed enemies//
    for(int i=enemyList.size()-1;i>=0;i=i-1){
      Enemy anEnemy=enemyList.get(i);
      
        if(anEnemy.shouldDie==true){
          enemyList.remove(anEnemy); 
        }    
      }
      
    //for loop to go through all items//
    for(Pickup aItem:itemList){
      aItem.render();
      aItem.pickupItem(p1);
    }
    //forloop that removes obtained items//
    for(int i=itemList.size()-1;i>=0;i=i-1){
      Pickup aItem=itemList.get(i);
      
        if(aItem.shouldgo==true){
          itemList.remove(aItem); 
        }    
      }
      
    //forloop to go through all platforms//  
    for(Platform aPlatform:platformList){
      aPlatform.render();
      aPlatform.collision(p1);
      aPlatform.enemyCollision(eA1);
      aPlatform.enemyCollision(eA2);
      aPlatform.enemyCollision(eA3);
    }
      
      drawHealth(pHealth,pHealthX,pHealthY,textColor);
      drawkeyAmount(pScore,keyX,keyY,textColor);
      
      playerWinScreen();
      playerLooseScreen();
      
      if(pScore==1){
        state = 2; // go to level 2
        ready = true;
      }
}

void levelTwo(){
  if(ready == true){
    number2();
  }
    background(lightImage);
     
    p1.render();
    p1.move();
    p1.jump();
    p1.fall();
    p1.topJump();
    p1.land();
    p1.fallPlatform(platformList);
    
    bmoAnimation.display(p1.x,p1.y);
    iB1.aAnimation.isAnimating=true;
        
    //forloop to go through all enemies//  
    for(Enemy anEnemy:enemyList){
      anEnemy.render();
      anEnemy.playerEnemyCollisions(p1);
      
      anEnemy.jump();
      anEnemy.fall();
      anEnemy.land();
      anEnemy.fallPlatformEnemy(platformList);
      
      //make enemy bounce off of eachother//
      for(Enemy anotherEnemy:enemyList){
        if(anEnemy!=anotherEnemy){
          anEnemy.EnemyenemyCollision(anotherEnemy);
        }
      }
    }
    
    //forloop that removes killed enemies//
    for(int i=enemyList.size()-1;i>=0;i=i-1){
      Enemy anEnemy=enemyList.get(i);
      
        if(anEnemy.shouldDie==true){
          enemyList.remove(anEnemy); 
        }    
      }
    
    //for loop to go through all bullets//
    for(Bullet aBullet:bulletList){
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      aBullet.shootPlayer(p1);
    }
    
    //forloop that removes unwanted bullets//
    for(int i=bulletList.size()-1;i>=0;i=i-1){
      Bullet aBullet=bulletList.get(i);
      
      if(aBullet.shouldRemove==true){
        bulletList.remove(aBullet);
      }
    }
    
    //update current time//
    currentTime=millis();
    
      // if time passed is more than 
      //4sec print something
      if(currentTime-startTime>interval && enemyList.size()>=1){
          bulletList.add(new Bullet(eB1.x,eB1.y));
          bulletList.add(new Bullet(eB2.x,eB2.y));
          bulletList.add(new Bullet(eB3.x,eB3.y));
          bulletList.add(new Bullet(eB4.x,eB4.y));
          bulletList.add(new Bullet(eB5.x,eB5.y));   
          eB1.eAnimation.isAnimating=true;
    
          //reset timer//
          startTime=millis();   
      }
         
    //for loop to go through all items//
    for(Pickup aItem:itemList){
      aItem.render();
      aItem.pickupItem(p1);
    }
    
    //forloop that removes obtained items//
    for(int i=itemList.size()-1;i>=0;i=i-1){
      Pickup aItem=itemList.get(i);
      
        if(aItem.shouldgo==true){
          itemList.remove(aItem); 
        }    
      }
      
    //forloop to go through all platforms//  
    for(Platform aPlatform:platformList){
      aPlatform.render();
      aPlatform.collision(p1);
      aPlatform.enemyCollision(eB1);
      aPlatform.enemyCollision(eB2);
      aPlatform.enemyCollision(eB3);
      aPlatform.enemyCollision(eB4);
      aPlatform.enemyCollision(eB5);    
    }
    
     drawHealth(pHealth,pHealthX,pHealthY,textColor);
     drawkeyAmount(pScore,keyX,keyY,textColor);
     playerWinScreen();
     playerLooseScreen();
     
     if(pScore==2){
        state = 3; // go to level 3
        ready = true;
      }
}

void levelThree(){
    if(ready == true){
      number3();
  }
  background(blueImage);
    
    p1.render();
    p1.move();
    p1.jump();
    p1.fall();
    p1.topJump();
    p1.land();
    p1.fallPlatform(platformList);
    
    bmoAnimation.display(p1.x,p1.y);
    iC1.aAnimation.isAnimating=true;
        
    //forloop to go through all enemies//  
    for(Enemy anEnemy:enemyList){
      anEnemy.render();
      anEnemy.playerEnemyCollisions(p1);
      
      anEnemy.jump();
      anEnemy.fall();
      anEnemy.land();
      anEnemy.fallPlatformEnemy(platformList);
      
      //make enemy bounce off of eachother
      for(Enemy anotherEnemy:enemyList){
        if(anEnemy!=anotherEnemy){
          anEnemy.EnemyenemyCollision(anotherEnemy);
        }
      }
    }
    
    //forloop that removes killed enemies//
    for(int i=enemyList.size()-1;i>=0;i=i-1){
      Enemy anEnemy=enemyList.get(i);
      
        if(anEnemy.shouldDie==true){
          enemyList.remove(anEnemy); 
        }    
      }
    
    //for loop to go through all bullets//
    for(Bullet aBullet:bulletList){
      aBullet.render();
      aBullet.move();
      aBullet.checkRemove();
      aBullet.shootPlayer(p1);
    }
    
    //forloop that removes unwanted bullets//
    for(int i=bulletList.size()-1;i>=0;i=i-1){
      Bullet aBullet=bulletList.get(i);
      
      if(aBullet.shouldRemove==true){
        bulletList.remove(aBullet);
      }
    }
    
    //update current time
    currentTime=millis();
    
      // if time passed is more than 
      //4sec print something
      if(currentTime-startTime>interval && enemyList.size()>=1){
          bulletList.add(new Bullet(eC1.x,eC1.y));
          bulletList.add(new Bullet(eC2.x,eC2.y));
          bulletList.add(new Bullet(eC3.x,eC3.y));
          bulletList.add(new Bullet(eC4.x,eC4.y));
          bulletList.add(new Bullet(eC5.x,eC5.y));
          bulletList.add(new Bullet(eC6.x,eC6.y));    
          bulletList.add(new Bullet(eC7.x,eC7.y));
          eC1.eAnimation.isAnimating=true;
    
          //reset timer
          startTime=millis();   
      }
         
    //for loop to go through all items//
    for(Pickup aItem:itemList){
      aItem.render();
      aItem.pickupItem(p1);
    }
    
    //forloop that removes obtained items//
    for(int i=itemList.size()-1;i>=0;i=i-1){
      Pickup aItem=itemList.get(i);
      
        if(aItem.shouldgo==true){
          itemList.remove(aItem); 
        }    
      }
      
    //forloop to go through all platforms//  
    for(Platform aPlatform:platformList){
      aPlatform.render();
      aPlatform.collision(p1);
      aPlatform.enemyCollision(eC1);
      aPlatform.enemyCollision(eC2);
      aPlatform.enemyCollision(eC3);
      aPlatform.enemyCollision(eC4);
      aPlatform.enemyCollision(eC5);
      aPlatform.enemyCollision(eC6);
      aPlatform.enemyCollision(eC7);      
    }
    
     drawHealth(pHealth,pHealthX,pHealthY,textColor);
     drawkeyAmount(pScore,keyX,keyY,textColor);
     playerWinScreen();
     playerLooseScreen();            
}

void playerWinScreen() {
  if (pScore >= winScore) {
    bgmMusic.stop();
    
     //if the music is not playing then play it//
    if(winMusic.isPlaying()==false && pScore==3){
      winMusic.play();
    } 
      
    background(winImage);
    fill(0);
    
    text("YAY! YOU SAVED FINN AND JAKE!", width/2, 580);
    
    enemyList.remove(eC1);
    enemyList.remove(eC2);
    enemyList.remove(eC3);
    enemyList.remove(eC4);
    enemyList.remove(eC5);
    enemyList.remove(eC6);
    enemyList.remove(eC7);
  }
}

void playerLooseScreen() {
  if (pHealth<= 0) {
    
      winMusic.stop();
      bgmMusic.stop();
    
     //if the music is not playing then play it//
    if(looseMusic.isPlaying()==false){
      looseMusic.play();
    } 
    
    background(looseImage);
    fill(0);
    
    text("you FAILED to save them.....", width/2, 580);
  }
}

void number2(){
  
  //start stopwatch//
  startTime=millis();
    
  eB1=new Enemy(int(random(30,170)),int(random(0,600)),enemyAnimation); 
  eB2=new Enemy(int(random(200,470)),int(random(0,600)),enemyAnimation); 
  eB3=new Enemy(int(random(500,670)),int(random(0,600)),enemyAnimation); 
  eB4=new Enemy(int(random(700,800)),int(random(0,600)),enemyAnimation); 
  eB5=new Enemy(int(random(830,930)),int(random(0,600)),enemyAnimation); 
  
  enemyList=new ArrayList<Enemy>();
  enemyList.add(eB1);
  enemyList.add(eB2);
  enemyList.add(eB3);
  enemyList.add(eB4);
  enemyList.add(eB5);
  
  platB1=new Platform(300,500,color(38,89,33));
  platB2=new Platform(width/2,350,color(40,70,30));
  platB3=new Platform(700,500,color(30,40,30));
  platB4=new Platform(300,200,color(10,80,24));
  platB5=new Platform(700,200,color(10,20,30));
  
  platformList=new ArrayList<Platform>();
  platformList.add(platB1);
  platformList.add(platB2);
  platformList.add(platB3);
  platformList.add(platB4);
  platformList.add(platB5);
  
  bulletList=new ArrayList<Bullet>();
  iB1=new Pickup(300,165,itemAnimation);

  itemList=new ArrayList<Pickup>();
  itemList.add(iB1);
  
  ready = false;
}

void number3(){
    
  //start stopwatch//
  startTime=millis();

  eC1=new Enemy(int(random(30,100)),int(random(0,600)),enemyAnimation); 
  eC2=new Enemy(int(random(130,300)),int(random(0,600)),enemyAnimation); 
  eC3=new Enemy(int(random(430,500)),int(random(0,600)),enemyAnimation); 
  eC4=new Enemy(int(random(530,600)),int(random(0,600)),enemyAnimation); 
  eC5=new Enemy(int(random(630,700)),int(random(0,600)),enemyAnimation); 
  eC6=new Enemy(int(random(730,800)),int(random(0,600)),enemyAnimation); 
  eC7=new Enemy(int(random(830,930)),int(random(0,600)),enemyAnimation); 
  
  enemyList=new ArrayList<Enemy>();
  enemyList.add(eC1);
  enemyList.add(eC2);
  enemyList.add(eC3);
  enemyList.add(eC4);
  enemyList.add(eC5);
  enemyList.add(eC6);
  enemyList.add(eC7);
  
  platC1=new Platform(550,550,color(10,110,30));
  platC2=new Platform(700,400,color(40,120,10));
  platC3=new Platform(500,300,color(30,40,30));
  platC4=new Platform(170,200,color(15,100,30));
  platC5=new Platform(80,400,color(28,50,30));
  platC6=new Platform(850,550,color(26,34,30));
  
  platformList=new ArrayList<Platform>();
  platformList.add(platC1);
  platformList.add(platC2);
  platformList.add(platC3);
  platformList.add(platC4);
  platformList.add(platC5);
  platformList.add(platC6);
  
  bulletList=new ArrayList<Bullet>();
  iC1=new Pickup(75,365,itemAnimation);

  itemList=new ArrayList<Pickup>();
  itemList.add(iC1);
  
  ready = false;
}
