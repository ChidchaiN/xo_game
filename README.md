# XO Game App

## Project Overview
This is a Tic-Tac-Toe (XO) game built using Flutter. The app supports multiple game modes, including Player vs Player (PvP) and Player vs AI (using the Minimax algorithm).  
The project follows a **feature-based architecture** and uses **Sembast**, a NoSQL database, for storing game history.

---

## Setup Instructions

### Prerequisites
- Flutter (version 3.0 or later)
- Android Studio or VS Code
- Emulator or physical device connected for testing

### Steps to Set Up
```bash
# Clone the repository
git clone https://github.com/ChidchaiN/xo_game.git
cd xo_game

# Install dependencies
flutter pub get

# Run the app
flutter run
```
This will launch the app on the connected device or emulator.

## Project Structure
The project is organized using a feature-based architecture:

lib/
├── core/        # Shared utilities, themes, constants
├── data/        # Database services (Sembast)
├── features/    # Feature-specific code (game, history, replay)
├── shared/      # Reusable widgets (e.g., game board)
└── routes/      # Navigation setup

## How to Run the App
1. Open the project in Android Studio or VS Code.

2. Connect a physical device or start an emulator.

3. Run the app using:
```bash
flutter run
```
## Minimax Algorithm Explanation
The Minimax algorithm is used to implement a smart AI opponent in the game.

## How It Works

### 1. Evaluate the Board:
   - +10 if AI (X) wins
   - -10 if player (O) wins
   - 0 for a draw

### 2. Recursive Simulation:
   - Simulate all possible moves
   - Alternate between maximizing (AI) and minimizing (opponent) the score

### 3. Base Case:
   - Return score if game is over

### 4. Choose Optimal Move:
   - AI picks the move with the highest score

Code Example
```dart
static int minimax(List<List<String>> board, int depth, bool isMax) {
  int score = evaluate(board);

  if (score == 10) return score - depth;
  if (score == -10) return score + depth;
  if (!isMovesLeft(board)) return 0;

  if (isMax) {
    int best = -1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          board[i][j] = 'X';
          best = max(best, minimax(board, depth + 1, false));
          board[i][j] = '';
        }
      }
    }
    return best;
  } else {
    int best = 1000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          board[i][j] = 'O';
          best = min(best, minimax(board, depth + 1, true));
          board[i][j] = '';
        }
      }
    }
    return best;
  }
}
```

## Key Points

 - Depth Adjustment: Encourage quicker wins or slower losses
 - Efficiency: Fully explores all board states (fine for 3x3, not scalable for large boards)

## Design Process

### Requirement Analysis

 - Understand XO rules
 - Define features like PvP, AI, and history recording

### UI/UX Design

 - Design wireframes with Figma
 - Focus on clarity and usability

### Tech Stack

 - Flutter: Cross-platform app development
 - Sembast: Lightweight local database

### Implementation

 - Build core gameplay and AI logic
 - Implement game history recording
 - Use feature-based structure for scalability

## Database: Sembast

 - Type: NoSQL (file-based)
 - Usage: Stores game history as list of moves

### Advantages

 - Lightweight and fast
 - No server or setup needed

## Conclusion

This project demonstrates:
 - Clean architecture with Flutter
 - Smart AI using Minimax
 - Local persistence with Sembast
 - Modular and maintainable codebase for scalability