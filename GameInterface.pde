
//Program starts, title screen shows. Click Start Game
//Runs all the code in Game Project class once clicked.
//During a game, interface tracks score based on hit() method, it has a running timer, enemy hp, and pause button

class GameInterface implements UpdateInterface {
  // properties
  PImage startBG; // Title background
  boolean isPaused; // Check if paused already for toggling on/off
  float levelTime; // Timer
  int score; // Current score
  int maxScore; // Winning score
  boolean gameStart; //Check on program start, if false then display Title screen

  // constructor
  GameInterface(int maxScore) {
    // Level timer and score default to 0
    levelTime = 0;
    score = 0;
    this.maxScore = maxScore; // Pass in maximum score for alternate win condition.

    gameStart = false; // Forces title screen
    isPaused = false;
    startBG = loadImage("startScreen.png"); // Load title image
    startBG.resize(800, 800);
  }

  //methods

  void startScreen() {
    // On program start, noLoop(). Display Title of game, with start game option
    background(startBG);
    noLoop(); // stop program from running

    // display title of game and start button.
    fill(255);
    textSize(116);
    textAlign(CENTER);
    text("Space Combat", width/2, height/2 - 50);
    fill(44);
    rect(width/2 - 105, height/2 + 45, 210, 60);
    fill(120, 120, 150);
    rect(width/2 - 100, height/2 + 50, 200, 50);
    fill(255);
    textSize(32);
    textAlign(CENTER);
    text("Start Game", width/2, height/2 + 85);
  }

  boolean enemiesDefeated() {
    //New win condition, many enemies
    // Main draw constantly checks this.
    if (numEnemiesKilled >= numEnemiesToKill) {
      fill(255);
      textSize(48);
      textAlign(CENTER);
      filter(BLUR, 10);
      text("Level Complete!", width/2, 70);
      text("Score: "+score, width/2, 115);
      text("Time: "+startTimer()/1000, width/2, 160);
       textSize(32);
       text("Movement Pattern and enemy kill positions", width/2, 230);
      //readPlayerPattern();
      saveOutput();
      // Add a rectangle border frame
      noFill();
      stroke(255);
      strokeWeight(2);
      rect(width*0.16, height*0.325, width*0.65, height*0.67); // Draw a rectangle border around the display
      displayPlayerPattern();
      noLoop();
      return true;
    } else return false;
  }


  void displayPlayerPattern() {
    pushMatrix();
    scale(0.6); // Scale down by 50%
    translate(width*0.35, height*0.55); // Translate to the desired position
    readPlayerPattern();
    popMatrix();
  }

  //Take in player movement patterns and save to txt
  void externalOutput(float playerX, float playerY, PrintWriter output) {
    output.println(playerX + ", " + playerY); // Write the coordinate to the file
  }
  void saveOutput() {
    output.println(); // Adds an empty line between rounds
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    stop();
  }

  void readPlayerPattern() {
    String[] lines = loadStrings("playerPattern.txt");
    //patternScreen();
    int round = 0;
    float prevX = 0;
    float prevY = 0;
    boolean firstCoordinate = true;

    for (String line : lines) {
      // Check for a round separator (assuming an empty line separates rounds)
      if (line.trim().isEmpty()) {
        round++;
        firstCoordinate = true;
        continue;
      }

      //death print
      if (line.startsWith("DEAD")) {
        String[] coordinates = split(line.substring(5), ','); // Skip the "DEAD " part
        float x = float(coordinates[0]);
        float y = float(coordinates[1]);

        // Draw a marker for the dead enemy on the patternScreen
        fill(255, 0, 0);
        image(deathMarker, x-10, y-10);
      }
      //death print end

      String[] coordinates = split(line, ',');
      float x = float(coordinates[0]);
      float y = float(coordinates[1]);

      if (!firstCoordinate) {
        if (round == 0) {
          stroke(245, 200, 0); // Red for the previous round
        } else if (round == 1) {
          stroke(0, 255, 0); // Green for the current round
        } else {
          break;
        }
        strokeWeight(8);
        line(prevX, prevY, x, y);
      } else {
        firstCoordinate = false;
      }

      prevX = x;
      prevY = y;
    }
    strokeWeight(1);
  }

  // Screen for comparing patterns
  void patternScreen() {
    noLoop();
    pushMatrix();

    popMatrix();
    fill(0);
    image(level1, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(255);
    text("Player Pattern", width/2, 25);
    textSize(24);
    text("View the path you took and where you destroyed enemies", width/2, 50);
  }

  void recordEnemyDeath(float x, float y) {
    output.println("DEAD " + x + ", " + y); // Write the "DEAD" tag and the coordinate to the file
  }

  // ***** PLayer pattern end***


  // compass tracker in bottom right
  void compassTracker(float enemyX, float enemyY, float playerX, float playerY, int numEnemy) {
    fill(200, 5);
    rect(width-170, height-170, 170, 170);
    // draw an outline to the above rectangle
    noFill();
    stroke(255); // White outline
    strokeWeight(2); // Adjust the outline
    rect(width-170, height-170, 170, 170);
    stroke(0);
    noStroke();

    pushMatrix();
    translate(width-120, height-140);
    scale(0.1, 0.1);
    fill(0, 255, 0);
    ellipse(playerX, playerY, 90, 90);
    fill(255, 0, 0);
    rect(enemyX, enemyY, 90, 90);
    popMatrix();
  }
  // compass tracker end *************

  // Pause menu
  void pauseScreen() {
    // Blur filter, halt game loop, display menu
    filter(BLUR, 10);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(255);
    text("Game Paused", width/2, height/2-50);
    textSize(32);
    text("Press P to resume", width/2, height/2);
    text("Movement: W,A,S,D", width/2, height/2 + 100);
    text("Hide Projectiles: 1", width/2, height/2 + 140);
    text("Slow Projectiles: 2", width/2, height/2 + 180);
    text("Cheat and increase kill count: k", width/2, height/2 + 220);
    text("Mouse click objects to interact.", width/2, height/2 + 260);
  }
  // pause menu end************


  // Timer method for level time
  float startTimer() {
    levelTime = millis(); // Uses millis()
    return levelTime;
  }

  // increment score when hit collision occurs
  void addScore() {
    score++;
  }



  void update() {

    enemiesDefeated();
  }

  void display() {
    //Display a UI of score, kills, Menu button, and timer
    fill(150, 90);
    rect(0, 0, width, 60);
    fill(255);
    textSize(32);
    textAlign(LEFT);
    fill(0, 255, 200);
    text("Score: " + score, 20, 40);

    fill(220);
    rect(13, 63, 90, 64);
    fill(110);
    rect(16, 66, 84, 59);
    fill(255);
    textSize(32);
    textAlign(LEFT);
    text("Menu", 20, 102);

    textAlign(RIGHT);
    fill(255);
    // Subtract time since level started, from the time since program started to get correct timer.
    text("Time: " + int((millis() - levelTime) / 1000), width - 20, 40); // Divide by 1000 to convert

    textAlign(CENTER);
    text("Enemies Killed: " + numEnemiesKilled + "/ " + numEnemiesToKill, width/2, 40);
    enemiesDefeated();
  }


  void mousePressed() {
    // check if mouseclick is on start button
    if (mouseX > width/2 - 100 && mouseX < width/2 + 100 &&
      mouseY > height/2 + 50 && mouseY < height/2 + 100) {
      gameStart = true;
      levelTime = millis();
      loop(); // start program running
    }
    
    //check if mouseclick is on Menu button
    if (mouseX > 13 && mouseX < 103 && mouseY > 63 && mouseY < 127 && !isPaused) {
      noLoop();
      pauseScreen();
    } else {
      loop();
    }
  }
}
