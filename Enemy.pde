PImage test, test1;
class Enemy extends GameObject {

  //properties

  float scaleFactor; // scale factor for enemy model
  // for arm movement
  float pR, pL; // Pivots
  float angle1, angle2;
  float segLength = 50;
  float armLength = 50;
  //***
  float hp;
  float playerX;
  float playerY;
  int debrisX = 0;
  boolean dead;
  float enemyPick;


  //constructor
  Enemy(float x, float y, float w, float h, float speed, color c, float hp, float scaleFactor) {
    println("Enemy Created");
    this.x = x*scaleFactor; //scaleFactor = scale() value on enemy object
    this.y = y*scaleFactor;
    this.w = w*scaleFactor;
    this.h = h*scaleFactor;
    this.hp = hp;
    this.scaleFactor = scaleFactor;
    this.speed = speed;
    this.c = c;
    this.dead = false;
    enemyPick = random(1);
    pR = -50; // pivot point for right arm
    // set initial angles for arms
    angle1 = 1;
    angle2 = 2;
    //methods
  }

  void update(float playerX, float playerY) {
    //These vars make the robot arms move in relation to player, and also move the enemies toward player.
    float dx = playerX - x;
    float dy = playerY - y;

    //Enemy movement towards player
    float dist = sqrt(dx*dx + dy*dy);
    if (dist > 0) {
      float vx = dx / dist;
      float vy = dy / dist;
      x += vx * speed;
      y += vy * speed;
    }

    //For arm movement
    angle1 = atan2(dy, dx);
    angle2 = angle1 * -0.5;

    // Just a simple loop for debris asteroid models to reset on x axis.
    if (debrisX > width*2) {
      debrisX = -700;
    }
  }

  void display() {


    if (dead) { // Check if enemy is dead, reset enemy


      for (int i = 0; i < 10; i++) {

        // Reset the enemy with new random x and y positions
        float respawnX = random(-width/2, width*2);
        float respawnY = random(-height/2, height*2);
        x = respawnX;
        y = respawnY;
        hp = 500;
        dead = false;
      }
    }

    // Just making asteroid models
    pushMatrix();
    translate(debrisX+=2, 0);
    debris();
    popMatrix();
    pushMatrix();
    translate(-800+debrisX++, 300+debrisX);
    debris();
    popMatrix();
    pushMatrix();
    translate(debrisX-200, 100);
    debris();
    popMatrix();
    pushMatrix();
    translate(debrisX-800, 90);
    debris();
    popMatrix();
    pushMatrix();
    translate(debrisX-900, -90);
    debris();
    popMatrix();
    //************************************


    // Move Enemy model around with noise.
    pushMatrix();
    float xMovement = map(noise(frameCount * 0.01), 0, 1, -150, 150);
    float yMovement = map(noise(frameCount * 0.01), 0, 1, -50, 50);
    translate(xMovement, yMovement);
    pushMatrix();
    //scale(scaleFactor);
    fill(0, 0, 255, 80);
    //ellipse(x, y, w, h); //collision hitbox highlight
    translate(this.x*0.92, this.y*0.9); // adjustment to better fit inside hitbox
    //if (enemyPick < 0.5) {
     enemyModel();
    //} else {
    //  testModel();
    //}
   
    popMatrix();
    popMatrix();
    // Update enemy position to match noise
    this.x += xMovement*0.01;
    this.y += yMovement*0.01;

    // Test *** Randomly display either enemyModel() or testModel(). 3 models only imo, anymore and screen is cluttered.
    // enemyPick is random var rolled in constructor for each enemy instance, rerolled whe hp = 0
    //if (enemyPick < 0.33) {
    //  enemyModel();
    //} else if (enemyPick > 0.33 && enemyPick < 0.66){
    //  testModel();
    //} else {
    //  testModel1();
    //}
    ////*********************************************
  }

  //*** taking the enemy model png from Main
  void testModel() {
    image(test, this.x, this.y);
  }
  //***

  void enemyModel() {
    stroke(1);
    pushMatrix();
    scale(scaleFactor);
    // Torso
    fill(130);
    rect(0, 0, 75, 100, 5);
    if (mousePressed) {
      fill(random(180, 220), 0, 0);
    } else {
      fill(0, random(180, 220), 0);
    }
    rect(60, 10, 10, 80);
    for (int i = 0; i < 90; i+=10) {
      for (int j = 0; j < 50; j+=10) {
        fill(c);
        ellipse (10+j, 10+i, 7, 7);
      }
    };
    //
    // Head
    fill(90);
    ellipse(37, -10, 20, 30);
    fill(130);
    rect(13, -55, 50, 40, 5);
    fill(random(150, 200), 10, 30);
    ellipse(25, -40, random(10, 13), 5);
    ellipse(50, -40, random(10, 13), 5);

    // Left Arm
    pushMatrix();
    translate(0, 0);
    rotate(angle1*1.3);
    segment(0, 0, armLength, 0, angle2);
    popMatrix();

    // Right Arm
    pushMatrix();
    translate(20+armLength, 0);
    rotate(-angle1*1.3);
    segment(0, 0, -armLength, 0, angle2*3);
    popMatrix();

    // Left Leg
    fill(80);
    for (int i = 0; i < 50; i+=7) {
      ellipse(15, 104+i, 30, 10);
    }

    // Right Leg
    for (int i = 0; i < 50; i+=7) {
      ellipse(60, 104+i, 30, 10);
    }
    popMatrix();
  }

  // For arm movement on robot
  void segment(float x, float y, float dx, float dy, float angle) {
    float sw = map(dist(x, y, dx, dy), 0, segLength*2, 10, 1);
    strokeWeight(sw*2);
    stroke(255, 160);
    line(x, y, dx, dy);
    pushMatrix();
    translate(dx, dy);
    rotate(angle);
    line(0, 0, segLength, 0);
    popMatrix();
    noStroke();
  }

  //for asteroid models
  void debris () {
    //pushMatrix();

    stroke(1);
    strokeWeight(2);
    fill (130);

    rect(width/2+20, height/2, 30, 60, 20);
    rect(width/2+20, height/2, 40, 30, 20);
    rect(width/2, height/2, 50, 50, 20);
    fill (70);
    rect(width/2+10, height/2+20, 10, 15, 20);
    rect(width/2+30, height/2+10, 15, 15, 10);
    rect(width/2+25, height/2+30, 15, 15, 5);
    fill (100);
    rect(width/2-45, height/2+15, 15, 15, 5);
    rect(width/2-25, height/2+7, 18, 18, 10);
    rect(width/2-15, height/2+30, 12, 12, 10);


    noStroke();
  }

  // Rreduce hp
  void decrementHP(float dmg) {
    hp -= dmg;
    println(" "+hp);
    if (hp <= 0) {
      dead = true;
      println("dead");
    }
  }

  void keyPressed() {
    if (key == 'c') {
      // Implementation in main draw
    }
  }
  void mousePressed() {
    // Check if mouse location is clicking on object, if so then toggle color.
    if (dist(mouseX, mouseY, x, y) < w/2) {
      c = color(random(255), random(255), random(255));
    }
  }
}
