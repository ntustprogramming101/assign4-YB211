final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

int soilX=0,soilY=0;
int cameraMove=0;
int lifeX=0,lifeY=10;
int stone1X=0,stone1Y=0;
int stone2X=0,stone2Y=0;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24,soil0,soil1,soil2,soil3,soil4,soil5,stone1,stone2;
PImage life,groundHog,soldier,cabbage;
PImage groundhogDown,groundhogLeft,groundhogRight;

float groundHogX=320;
float groundHogY=80;
float groundSpeed=80/16;

float groundhogMove=0;

float groundhogMovingDown=0;
float groundhogMovingRight=0;
float groundhogMovingLeft=0;

final int key_Right = 1;
final int key_Left = 2;
final int key_Down = 3;
final int noKey = 0;

int keyNow = noKey;

float soldierX=0;
float soldierY;
float cabbageX;
float cabbageY;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  life = loadImage("img/life.png");

  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  groundHog = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  soldierY = (int)random(2,26); 
  cabbageX = (int)random(0,8);
  cabbageY = (int)random(2,26);
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT+cameraMove, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		
      for(int i=0;i<=7;i++){
        for(int j=1;j<=24;j++){
          soilY = 80+j*80;
          soilX = i*80;
            if(j<5)image(soil0, soilX, soilY+cameraMove);
            if(j<9 && j>4)image(soil1, soilX, soilY+cameraMove);
            if(j<13 && j>8)image(soil2, soilX, soilY+cameraMove);
            if(j<17 && j>12)image(soil3, soilX, soilY+cameraMove);
            if(j<21 && j>16)image(soil4, soilX, soilY+cameraMove);
            if(j<25 && j>20)image(soil5, soilX, soilY+cameraMove);
          }
        }
      
    //Stone1(1-8)
     for(int k=0;k<=23;k++){
        for(int l=0;l<=7;l++){
           stone1X=l*80;
           stone1Y=160+k*80;
          if(l==k && k<=7)image(stone1, stone1X,stone1Y+cameraMove);
          if((k==8 || k==11 || k==12 || k==15) && (l==1 || l==2 || l==5 || l==6))image(stone1, stone1X,stone1Y+cameraMove);
          if((k==9 || k==10 || k==13 || k==14) && (l==0 || l==3 || l==4 || l==7))image(stone1, stone1X,stone1Y+cameraMove);
          if((k==16 || k==19 || k==22) && (l==1 || l==2 || l==4 || l==5 || l==7))image(stone1, stone1X,stone1Y+cameraMove);
          if((k==17 || k==20 || k==23) && (l==0 || l==1 || l==3 || l==4 || l==6 || l==7))image(stone1, stone1X,stone1Y+cameraMove);
          if((k==18 || k==21 ) && (l==0 || l==2 || l==3 || l==5 || l==6))image(stone1, stone1X,stone1Y+cameraMove);
        }
      }
    //Stone2
    for(int k=0;k<=7;k++){
        for(int l=0;l<=7;l+=3){
           stone2X=l*80;
           stone2Y=1440+k*80;
          if(k%3==0){
            stone2X+=160;
            image(stone2, stone2X,stone2Y+cameraMove);
          }
          if(k%3==1){
            stone2X+=80;
            image(stone2, stone2X,stone2Y+cameraMove);
          }
          if(k%3==2){
            image(stone2, stone2X,stone2Y+cameraMove);
          }

        }
      }
    
    //soldier
     image(soldier,soldierX, soldierY*80+cameraMove); 
     soldierX = soldierX +2; 
     if (soldierX>640) soldierX = -80;
    
    //cabbage
     image(cabbage,cabbageX*80, cabbageY*80+cameraMove);
     

    // AABB collision with cabbage
    if(groundHogX<cabbageX*80+80 && groundHogY+80>cabbageY*80+cameraMove && groundHogX+80>cabbageX*80 && groundHogY<cabbageY*80+80+cameraMove){
        cabbageX=-80;//disappear
        if(playerHealth < 5) playerHealth ++;
         }  
    
    // Health UI
    for(int i=1;i<=playerHealth;i++){
      lifeX = i*70 - 60;
      image(life, lifeX, lifeY);
    }
    if(playerHealth<=0){
            gameState = GAME_OVER;
    }
    
    //groundhog
    image(groundHog,groundHogX,groundHogY);

    //GroundHogMove
      switch(keyNow){
      
        //GroundHogMoveRight
        case (key_Right):
        groundhogMovingRight=1;
        groundhogMove+=1;
        groundSpeed=80/16;
        groundHogX+=groundSpeed;
        groundHog = loadImage("img/groundhogRight.png");
              if(groundhogMove==16){
                groundHog = loadImage("img/groundhogIdle.png");
                groundSpeed=0;
                groundhogMove=0;
                groundhogMovingRight=0;
                keyNow=noKey;
               }
               break;
      
       //GroundHogMoveLeft
        case (key_Left):
        groundhogMovingLeft=1;
        groundhogMove+=1;
        groundSpeed=-80/16;
        groundHogX+=groundSpeed;
        groundHog = loadImage("img/groundhogLeft.png");
              if(groundhogMove==16){
                groundHog = loadImage("img/groundhogIdle.png");
                groundSpeed=0;
                groundhogMove=0;
                groundhogMovingLeft=0;
                keyNow=noKey;
               }
               break;
               
       //GroundHogMoveDown
        case (key_Down):
        
        groundhogMovingDown=1;
        groundhogMove+=1;
        groundSpeed=80/16;
        if(cameraMove>-1600){cameraMove-=groundSpeed;}
        else{groundHogY+=groundSpeed;}
        groundHog = loadImage("img/groundhogDown.png");
              if(groundhogMove==16){
                groundHog = loadImage("img/groundhogIdle.png");
                groundSpeed=0;
                groundhogMove=0;
                groundhogMovingDown=0;
                keyNow=noKey;
               }
               break;
               
        case (noKey):
               break;
      }


		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
          groundHog = loadImage("img/groundhogIdle.png");
          groundSpeed=0;
          groundhogMove=0;
          groundhogMovingDown=0;
          groundhogMovingRight=0;
          groundhogMovingLeft=0;
          keyNow=noKey;
          groundHogX=320;
          groundHogY=80;
          playerHealth = 2;
          cameraMove = 0;
          soldierX=0;
          soldierY = (int)random(2,26); 
          cabbageX = (int)random(0,8);
          cabbageY = (int)random(2,26);
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
    if(keyCode==DOWN && groundhogMovingLeft==0 && groundhogMovingRight==0 && gameState==GAME_RUN){
    if(groundHogY + 80 < height)keyNow=key_Down;
    }
    else if(keyCode==LEFT && groundhogMovingDown==0 && groundhogMovingRight==0 && gameState==GAME_RUN){
    if(groundHogX > 0)keyNow=key_Left;
    }
    else if(keyCode==RIGHT && groundhogMovingDown==0 && groundhogMovingLeft==0 && gameState==GAME_RUN){
    if(groundHogX + 80 < width)keyNow=key_Right;
    }
	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
