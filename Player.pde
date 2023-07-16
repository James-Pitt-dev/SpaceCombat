class Player extends GameObject{

  //properties
  //***AARON*** New property for rotation
  float angle = 0;
  //***AARON*** New property for smooth movement
  boolean l, r, u, d = false;


  //constructor
  Player(float x, float y, float w, float h, float speed, color c) {
    println("Player Created");

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.c = c;
    
  }

  //methods
  void update() {

    //Movement *****
    /*/ check which arrow keys are being pressed and move player in that direction
    if (keyPressed) {
      if (key == 'w') { // move up
        y-=speed;
        for (int i = 30; i < 50; i+=10) {
          for (int j = -40; j < 40; j+= 30) {
            fill (255, 200, 250, 10);
            rect(p.x+j, p.y+i, 10, 50, 20);
          }
        }
      }
      if (key == 'a') { // move left
        fill(0, 30);
        x-=speed;
        for (int i = 30; i < 50; i+=10) {
          for (int j = -40; j < 40; j+= 30) {
            fill (255, 200, 250, 10);
            rect(p.x+i, p.y+j+10, 50, 10, 20);
          }
        }
      }
      if (key == 's') { // move down
        y+=speed;
      }
      if (key == 'd') { // move right
        x+=speed;
        for (int i = 65; i < 100; i+=20) {
          for (int j = -40; j < 40; j+= 30) {
            fill (255, 200, 250, 10);
            rect(p.x-i, p.y+j+10, 50, 10, 20);
          }
        }
      }
      //***********************

      // check if player hits edge of screen
      if (x > width - w/2) {
        x = 0;
      }
      if ( x < 0) {
        x = width - w/2;
      }
      if (y > height + h/2) {
        y -= h;
      }
      if ( y < 0) {
        y+=h;
      }
    }/*/
    //***AARON*** New smoothed movement 
    
    if (u) { // move up
      y-=speed;
      for (int i = 30; i < 50; i+=10) {
        for (int j = -40; j < 40; j+= 30) {
          fill (255, 200, 250, 10);
          rect(p.x+j, p.y+i, 10, 50, 20);
        }
      }
    }
    if (l) { // move left
      fill(0, 30);
      x-=speed;
      for (int i = 30; i < 50; i+=10) {
        for (int j = -40; j < 40; j+= 30) {
          fill (255, 200, 250, 10);
          rect(p.x+i, p.y+j+10, 50, 10, 20);
        }
      }
    }
    if (d) { // move down
      y+=speed;
    }
    if (r) { // move right
      x+=speed;
      for (int i = 65; i < 100; i+=20) {
        for (int j = -40; j < 40; j+= 30) {
          fill (255, 200, 250, 10);
          rect(p.x-i, p.y+j+10, 50, 10, 20);
        }
      }
    }
    //***********************

    // check if player hits edge of screen
    if (x > width - w/2) {
      x = 0;
    }
    if ( x < 0) {
      x = width - w/2;
    }
    if (y > height + h/2) {
      y -= h;
    }
    if ( y < 0) {
      y+=h;
    }
    
  }
  void display() {

    // Adds realism to player movement by adding passive noise for bobbing and weaving effects.
    fill(255, 0, 0, 20);
    pushMatrix();
      float xMovement = map(noise(frameCount * 0.012), 0, 1, -20, 20);
      float yMovement = map(noise(frameCount * 0.01), 0, 1, -20, 20);
      translate(xMovement, yMovement);

      //***AARON*** New rotation code
      pushMatrix();
        translate(this.x, this.y);
        angle = atan2(mouseY - y, mouseX - x)+HALF_PI;
        rotate(angle);
        pushMatrix();
          translate(-this.w*0.8, -this.h/2);
          playerModel();
        popMatrix();
      popMatrix();
    popMatrix();
  }

  void playerModel() {

    //Just drawing the model
    strokeWeight(2);

    // Engine
    fill(255, 100, 100);
    quad(104, 94, 91, 127, 113, 127, 106, 108);

    // Wings

    //Left wing
    fill(156, 157, 160);
    pushMatrix();
    quad(60, 109, 104, 85, 89, 51, 50, 100);
    popMatrix();
    //Right wing
    quad(141, 109, 104, 85, 116, 51, 155, 100);

    // Body
    fill(c);
    stroke(1);
    ellipse(102, 58, 28, 65);
    rect(94, 90, 16, 17);

    // Cockpit
    fill(84, 167, 224);
    ellipse(61+41, 17+28, 13, 28);
    noStroke();
  }
  

  void mousePressed() {
    // detect if mouseclick on player, then toggle colors.
    if (dist(mouseX, mouseY, x, y) < w/2) {
      c = color(random(255), random(255), random(255));
    }
  }
  void keyPressed(){
  }
}
