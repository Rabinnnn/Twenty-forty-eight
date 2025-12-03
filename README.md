# Twenty-forty-eight
A Flutter implementation of the classic sliding-tile game (the objective: make a 2048 tile).
Built as if it were April 2014 — reproduce the original gameplay with smooth animations, responsive UI, and best-practice code structure.

## Features
- 4×4 grid with initial 3–4 tiles placed randomly (values 2 or 4).
- Tile merging rules: identical tiles combine into a tile with twice the value and increase score.

- Smooth animations for tile movement and merges.

- Responsive layout for phones and tablets.

- Live display of current score and best score during gameplay.

- Best score persists across sessions (uses shared_preferences).

- Pre-game instructions screen explaining how to play.

- Restart and Quit buttons (Quit returns to the launcher/exit point).

- Clean, modular code following Flutter best practices and a testable architecture.

## How to run
* Clone the repo and navigate to the directory
```bash
git clone https://github.com/Rabinnnn/Twenty-forty-eight.git
cd Twenty-forty-eight
```
* Run on device/emulator
```bash
flutter run
```
* To build release for android
```bash
flutter build apk
```

## Game rules & controls
* Objective: Merge tiles until you create a 2048 tile.

* Start: Game begins with 3–4 tiles placed randomly; each tile is 2 or 4.

* Swipe: Swipe Up / Down / Left / Right to move tiles. Tiles slide as far as possible.

* Merge: When two tiles of the same value collide they merge into one tile of value ×2; that value is added to your current score.

* New tile: After each successful move, a new tile (2 or 4) appears in a random empty cell.

* Game over: No legal moves remain (grid full & no adjacent equal tiles).

* Controls:

Restart — reset board and score.

Quit — exit the game / return to the launcher.

* Pre-game instructions: The app shows a short instructions overlay before first play.

## Project structure

lib/
|- main.dart
|- models/
|  |- game_state.dart
|  |- tile.dart
|- screens/
|  |- game_screen.dart
|  |- instructions_screen.dart
|- widgets/
|  |- board_widget.dart
|  |- controls_widget.dart
|  |- score_widget.dart
|  |- tile_widget.dart
|