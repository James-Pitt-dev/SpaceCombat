
class Projectile extends GameObject {

  //properties
  int alpha = 100;
  int dmg;
  //***AARON*** new attributes for projectiles
  int life = 5;
  float initX, initY;
  float angle;

  //constructor
  Projectile(float x, float y, float w, float h, float speed, color c, int dmg) {
    //Projectile originates from player position at random speeds.
    // width and height to be used as hitbox detection.
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.c = c;
    this.dmg = dmg;
    //***AARON*** constructor for new attributes
    initY = y;
    initX = x;
    angle = p.angle;
  }

  //methods
  void update() {
    // Update player position so projectiles stay tied to it.
    p.update();
    y = y - speed; // Shoot upwards

    //If projectile leaves screen, reset it at player position.
    //***AARON*** If projectile runs out of life or goes 600 pixels it resets
    //Needed to allow downward shooting
    if ((initY - y) > 600  || life < 0) {
      y = p.y;
      x = p.x;
      stroke(1);
      strokeWeight(1);
      c = color(100, 200, 255);
      noStroke();
      speed = 5;
      //***AARON*** New attribute updates
      life = 5;
      initY = y;
      initX = x;
      angle = p.angle;
    }
  }

  void display() {
    // Draw projectile ellipses on object location.
    fill(c);
    ellipse(x, y, w, h);

    //Key press for special attacks
    if (key == '1') {
      speed = 1;
      ellipse (this.x, this.y, 10, 30);
      c = color(255, 200, 0);
    }
    if (key == '2') {
      c = color(255, 200, 0, 0);
    }
  }

  void displayDamage(int dmg) {
    // display damage text to the right of screen
    resetMatrix();  //***AARON*** reset for consistent placement
    textAlign(RIGHT);
    textSize(36);
    fill(255, 255, 0);
    text(dmg, (width*0.8), height*0.2);
  }


  void hit() {
    // When collision occurs. Change projectile color and draw ellipses on top to simulate explosions.
    // Then print out damage text.
    println("Player Hit");
    life--; //***AARON*** more reliable bullet removal
    speed = 5;
    c = color(0, 100);
    fill(random(200, 255), random(100, 255), 0);


    ellipse(random(x-25, x+25), y, w*random(1, 4), h*random(1, 4));
    displayDamage(dmg);
  }

  void keyPressed() {
    // implementation in draw()
  }

  void mousePressed() {
    // implementation in draw()
  }
}
