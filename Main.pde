// Space Combat
// Player moves and auto fires. Enemies move toward player x,y, altered with noise().
// Kill enemies until limit reached, they reset off screen when 'dead' and come back.
// Game ends at max kills.
// P = pause/menu. Click player/enemy to change color.
// 1,2 alters projectile speed/visibility. k = cheat and increment kill count.

// Initialize class objects
PrintWriter output;
PImage level1, deathMarker; //bg img
Player p;
Enemy[] enemies;
Projectile [] proj; //player projectiles
GameInterface gi; // display timers/counter ui
int numProj = 5; //how many projectiles player shoots out
int numEnemies = 6; //how many enemies are in array
int numEnemiesToKill = 60; // number of enemies to kill to win
int numEnemiesKilled = 0; // counter for number of enemies killed
boolean isPaused = false; // pause checker
boolean gameStart = true; // start menu checker.

boolean loopExecuted = false;
float x_ = 0;
float y_ = 0;
float speed = 5;
int lastReset = 0;
PImage img, img2, img3, img4, Mimg,img5;
int corner;
boolean isImageVisible = true;

int playerhit = 0;
int playerhit2 = 0;



// SETUP *****************************
void setup() {
  frameRate(60);
  size(800, 800);
  level1 = loadImage(("levelAlternate.jpg"));
  level1.resize(1000, 800);
  deathMarker = loadImage("deathMarker.png");
  background(128);

  //Txt output
  output = createWriter("playerPattern.txt");

  img = loadImage("missileImg.png");
  img2 = loadImage("missileImgL.png");
  img3 = loadImage("missileImgBR.png");
  img4 = loadImage("missileImgBL.png");
  img5 = loadImage("col.png");
  lastReset = millis();
  
    
  // New enemy model png's
  test = loadImage(("enemyModel2.png"));
  test.resize(75, 75);
  deathMarker.resize(35,35);
  // ************************

  gi = new GameInterface(10000); // Set Game Interface values for Max score

  enemies = new Enemy[numEnemies];
  for (int i = 0; i < numEnemies; i++) {
    // create enemies, top of screen spawn.
    enemies[i] = new Enemy(random(width)*2, random(height)*0.3, 200, 250, 1, color(random(190, 255), 0, 0), 500, 0.4); // x, y , w, h, speed, color, hp, modelSize
  }


  p = new Player(width/3, height/1.2, 128, 128, 0.5, color(200, 210, 213)); //x,y,w,h,speed,color

  proj = new Projectile[numProj]; // Set number of projectiles fired

  for (int i= 0; i < numProj; i++) { //Create projectile array
    proj[i] = new Projectile(p.x, p.y, 16, 32, random(4, 7), color(200, random(100), random(200), 0), 5+(int)random(1, 25)); //x, y, width, height, speed, color, and damage
  }
  
}
//*************************************


// DRAW *******************************
void draw() {
  noStroke();
  image(level1, 0, 0); //bg image
  //Update and display all dynamic object
  p.update();
  p.display();
  gi.externalOutput(p.x, p.y, output);
   

  // Loop through the enemies array and update and display each enemy
  for (int i = 0; i < numEnemies; i++) {
    enemies[i].update(p.x, p.y);
    enemies[i].display();
    //compass Tracker
    gi.compassTracker(enemies[i].x, enemies[i].y, p.x, p.y, numEnemies);
    //**************
  }
  // game interface ui
  gi.display();
  gi.update();

  if (gameStart == true) { // Run at program start, gets set to false if button clicked.
    gi.startScreen();
  }
    
    //Gets rid of the projectile ellipses on end screen
    if (numEnemiesKilled >= numEnemiesToKill) {
    // Iterate through the projectiles array and set the alpha value to transparent
    noStroke();
    for (Projectile projectile : proj) {
      projectile.c = color(red(projectile.c), green(projectile.c), blue(projectile.c), 0);
    }
  
  }

  //Update and display projectile information.
  //Check each projectile for collisions with enemy object
  //Update Game interface score
  for (int i = 0; i < numProj; i++) {
    //***AARON*** new projectile calculations
    pushMatrix();
    translate(proj[i].initX, proj[i].initY);
    rotate(proj[i].angle);
    translate(-proj[i].initX, -proj[i].initY);
    proj[i].update();
    proj[i].display();
    if (collision(proj[i], enemies)) {
      proj[i].hit();
      gi.addScore();
    }
    popMatrix();
  }

  //update projectiles
  for (int i = 0; i < numProj; i++) {
    //***AARON*** new projectile calculations
    pushMatrix();
    translate(proj[i].initX, proj[i].initY);
    rotate(proj[i].angle);
    translate(-proj[i].initX, -proj[i].initY);
    proj[i].update();
    proj[i].display();
    popMatrix();
  }//
  
  //****************************************
  //Diksha
  if (millis() - lastReset > 5000) {

    // Set the initial position of the image to a different corner of the screen
      corner = int(random(4));
    if (corner == 0) { // top left corner
      x_ = 0;
      y_ = 0;
    } else if (corner == 1) { // top right corner
      x_ = width;
      y_ = 0;
    } else if (corner == 2) { // bottom left corner
      x_ = 0;
      y_ = height;
    } else { // bottom right corner
      x_ = width ;
      y_ = height;
    }
    lastReset = millis();
     isImageVisible = true;
  }

  // Move the image diagonally


    if (corner == 0) { // top left corner
  x_+= speed;
  y_ += speed;
   Mimg =  img;
    } else if (corner == 1) { // top right corner
  x_ -= speed;
  y_ += speed;
  Mimg =  img2;
    } else if (corner == 2) { // bottom left corner
  x_ += speed;
  y_ -= speed;
     Mimg =   img3;
    } else { // bottom right corner
  x_ -= speed;
  y_ -= speed;
  Mimg =   img4;
    }
    
   

  // Move the image to its new position
 
  if (x_ < p.x + p.w  && x_ +  100 >  p.x   &&
      y_ <  p.y+ p.h && y_ + 100 > p.y) {
    // Collision detected
    // You can handle this however you want, for example, by resetting the position of the image
image(img5,p.x-10,p.y, 150,150);
    isImageVisible = false;
    lastReset = millis(); // update the time to make the image reappear in a different corner

    playerhit =   1;
    
  }
  if(!loopExecuted){
    for (int i = 1; i < 2;  i++){
      println(i);
      counthit();
     
} loopExecuted = true;
  }
if(isImageVisible){
image(Mimg,x_,y_, 100,100);
loopExecuted = false;
}
//if( playerhit == 3 ){
  
//println(playerhit);
 
//}
}
//*************************************

void counthit(){
  
  playerhit2 += 1;
  println(playerhit2);
  
}
//*********************************************


boolean collision(Projectile proj, Enemy[] enemies) {

  for (Enemy e : enemies) {
    //***Aaron*** update collision for new projectiles
    pushMatrix();
    translate(proj.initX, proj.initY);
    rotate(-proj.angle);
    translate(-proj.initX, -proj.initY);
    boolean collide = true; // boolean makes sure each projectile hit doesnt trigger many kills as it passes through hitbox
    float distance = dist(e.x, e.y, (proj.initX-(proj.y-proj.initY)*sin(proj.angle)), (proj.initY-(proj.y-proj.initY)*cos(proj.angle+PI)));
    //circle for true enemy hitbox
    //circle(e.x, e.y, 20);
    //circle for projectile hitbox
    //circle((proj.initX-(proj.y-proj.initY)*sin(proj.angle)), (proj.initY-(proj.y-proj.initY)*cos(proj.angle+PI)), 50);
    popMatrix();
    if (distance < (e.w/2 + proj.w/2)) {
      e.decrementHP(proj.dmg); // call decrementHP() method on the enemy object

      if (e.hp <= 0 && collide) {
        numEnemiesKilled++;
        gi.recordEnemyDeath(e.x, e.y); // Record the enemy's death location
      }
      collide = false;
      return true;
    }
  }
  return false;
}

//boolean collision(Enemy e, Player p) {

//  float distance = dist(e.x, e.y, p.x, p.y);

//  if (distance < (e.w/2 + p.w/2)) {
//    return true;
//  } else {
//    return false;
//  }
//}

// P for pausing gameloop and call pause screen.
void keyPressed() {
  if (key == 'p' || key == 'P') {
    isPaused = !isPaused;
    if (isPaused) {
      noLoop();
      gi.pauseScreen();
    } else {
      loop();
    }
  }
  // K to set the cheat and increase kills.
  if (key == 'k' || key == 'K') {
    numEnemiesKilled += 5;
  }
  //***AARON*** New smoothed movement
  switch(key) {
  case 'a':
    p.l = true;
    break;
  case 'd':
    p.r = true;
    break;
  case 'w':
    p.u = true;
    break;
  case 's':
    p.d = true;
    break;
  }
}
//***AARON*** New smoothed movement
void keyReleased() {
  switch(key) {
  case 'a':
    p.l = false;
    break;
  case 'd':
    p.r = false;
    break;
  case 'w':
    p.u = false;
    break;
  case 's':
    p.d = false;
    break;
  }
}
// Call the mouse pressed methods of each object.
void mousePressed() {
  gi.mousePressed();
  gameStart = false;
  p.mousePressed();
  for (Enemy e : enemies) {
    e.mousePressed();
  }
  
}
