# Space Combat
<p>This project is a minigame with a space combat theme. The player moves a ship around the screen, firing at enemies and objects to stay alive and progress through the stage. The projectiles are automatically fired in a loop so the player can focus on movement and aiming.
<br>
This highlights the development of a 2D space combat game using Processing 4, a Java based platform for creating 2D objects, it focuses on aspects like player-enemy interactions, dynamic movement, and custom UI components. The game's structure leverages OOP principles like class designs, inheritance systems, and uses collision detection algorithms
</p>
## System Design
### Class Diagram
![ClassDiagram](https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/417a31e7-0ae2-4c03-b9d9-89c05518bc6e)
<hr>
### FSM Diagram
<p>The program incorporates a Finite State Machine (FSM) to manage both system and enemy states effectively. Figures for System and Enemy state below.</p>
<p>
<b>System FSM:</b>
  <ol>
    <li>StartScreen state: The initial state of the game, where the player is presented with the start menu.</li>
    <li>GamePlay state: The main game state, where the player interacts with the environment and enemies. This state is triggered by clicking the startButton on the StartScreen.</li>
    <li>Menu state: The pause menu state, which is accessed by pressing the pause button or clicking the menu button during gameplay. This state allows the player to return to the GamePlay state.</li>
    <li>GameEnd state: The final state of the game, which is reached after killing enough enemies or the player dies from damage.</li>
  </ol>
  <img src="https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/07822818-9adb-4106-8cdc-734436411591"></img>
</p>
<p>
<b>Enemy FSM:</b>
  <ol>
    <li>Idle state: The initial state of the enemies, where they remain stationary until the player is detected (instantiated), detection transitions to Chasing state.</li>
    <li>Chasing state: Triggered when the enemy detects the player, causing it to pursue the player.</li>
    <li>Dead state: Reached when they are defeated by the player attacks and hp is reduced to 0. This triggers a respawn and transition to Idle state</li>
  </ol>
</p>
<img src="https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/4c663d00-2bab-4cc9-a45c-dbbff12c2ad2"></img>

