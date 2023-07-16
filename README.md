# Space Combat

Game project programmed in Processing 4 Java. Follows OOP principles

## System Design
### Class Diagram
![ClassDiagram](https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/417a31e7-0ae2-4c03-b9d9-89c05518bc6e)
### FSM Diagram
<p>
**System FSM:**
  <ol>
    <li>StartScreen state: The initial state of the game, where the player is presented with the start menu.</li>
    <li>GamePlay state: The main game state, where the player interacts with the environment and enemies. This state is triggered by clicking the startButton on the StartScreen.</li>
    <li>Menu state: The pause menu state, which is accessed by pressing the pause button or clicking the menu button during gameplay. This state allows the player to return to the GamePlay state.</li>
    <li>GameEnd state: The final state of the game, which is reached after killing enough enemies or the player dies from damage.</li>
  </ol>
</p>
![image](https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/07822818-9adb-4106-8cdc-734436411591)
![image](https://github.com/James-Pitt-dev/SpaceCombat/assets/39842510/4c663d00-2bab-4cc9-a45c-dbbff12c2ad2)


