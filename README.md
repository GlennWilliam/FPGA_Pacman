# Pacman Game Project

## Overview
This project involves the development of a classic Pacman game using SystemVerilog on an FPGA platform. The game features Pacman, ghosts, and food pellets, displayed on a VGA screen and controlled using an N8 input controller.

## Features
- **Maze Display**: A maze layout similar to the classic Pacman games displayed on a VGA screen.
- **Pacman Movement**: Pacman can be controlled in four directions (up, down, left, right) using the N8 controller.
- **Ghosts**: Ghosts chase Pacman within the maze. If Pacman collides with any of the ghosts, the game ends.
- **Food Pellets**: Pacman must eat all the food pellets to win the game.

## System Modules
- **pacman_cont**: Manages the state movement of Pacman.
- **pacman_datapath**: Controls the data according to the state determined by `pacman_cont`.
- **pacman_display**: Responsible for displaying Pacman at a scale of 3x3 pixels.
- **user_direction_hold**: Keeps Pacman moving in the specified direction without the need for repeated user input.
- **maze_logic**: Prevents Pacman from moving through the maze walls.
- **food**: Manages the display and disappearance of food pellets as Pacman eats them.
- **ghost**: Similar to the Pacman logic but controls the ghost's movement.
- **loser**: Triggers the game over condition.
- **winner**: Activates when all food is eaten, displaying a win condition.

## Diagrams
- **Figures 1-31**: Detailed diagrams of the game logic, including system modules, Pacman and ghost interactions, and ASMD charts.

## Implementation
- The game is implemented on the DE1-SoC board using SystemVerilog.
- VGA Driver is used to handle display operations with RGB color outputs.

## How to Run
- Compile the SystemVerilog code using Quartus Prime.
- Load the FPGA with the compiled code.
- Connect a VGA display and the N8 controller.
- Reset the system and start the game using the N8 controller.

## ASMD Chart
![image](https://github.com/user-attachments/assets/2edb4722-4932-4607-ae59-0956176c4b22)

## Top Level Module Diagram
![image](https://github.com/user-attachments/assets/4db4b81f-5a6e-4c53-9bb4-8dca7edb8a44)

Refer to the pdf file for more complete explanation
