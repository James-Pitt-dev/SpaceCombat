
// Abstract class that Player, Enemy and Projectile need.

abstract class GameObject implements UpdateInterface {

  //attributes
  float x,y,w,h;
  float speed;
  color c;
  
  //methods
  abstract void keyPressed();
  abstract void mousePressed();

}
