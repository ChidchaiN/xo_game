class TicTacToeAI {
  static const String playerX = 'X';
  static const String playerO = 'O';
  static const String empty = '';

  // 1. Evaluate the game state
  static int evaluate(List<List<String>> board) {
    // Check for win conditions for player X
    if (isWinner(board, playerX)) return 10;
    // Check for win conditions for player O
    if (isWinner(board, playerO)) return -10;
    // If it's a draw or no winner
    return 0;
  }

  // 2. Check if the current player has won
  static bool isWinner(List<List<String>> board, String player) {
    // Check rows, columns, and diagonals
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true; // row
      if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true; // column
    }
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true; // diagonal
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true; // diagonal
    return false;
  }

  // 3. Check if there are moves left on the board
  static bool isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == empty) return true;
      }
    }
    return false;
  }

  // 4. Minimax algorithm implementation
  static int minimax(List<List<String>> board, int depth, bool isMax) {
    int score = evaluate(board);

    // If the maximizer wins
    if (score == 10) return score - depth;
    // If the minimizer wins
    if (score == -10) return score + depth;
    // If there are no moves left and it's a draw
    if (!isMovesLeft(board)) return 0;

    // If it's the maximizer's turn (X)
    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == empty) {
            board[i][j] = playerX;
            best = best > minimax(board, depth + 1, false) ? best : minimax(board, depth + 1, false);
            board[i][j] = empty;
          }
        }
      }
      return best;
    }
    // If it's the minimizer's turn (O)
    else {
      int best = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == empty) {
            board[i][j] = playerO;
            best = best < minimax(board, depth + 1, true) ? best : minimax(board, depth + 1, true);
            board[i][j] = empty;
          }
        }
      }
      return best;
    }
  }

  // 5. Find the best move for the AI (X or O)
  static List<int> findBestMove(List<List<String>> board) {
    int bestVal = -1000;
    List<int> bestMove = [-1, -1];

    // Loop through all possible moves and evaluate them
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == empty) {
          board[i][j] = playerX; // Assume it's the AI's turn (X)
          int moveVal = minimax(board, 0, false);
          board[i][j] = empty;

          if (moveVal > bestVal) {
            bestMove[0] = i;
            bestMove[1] = j;
            bestVal = moveVal;
          }
        }
      }
    }

    return bestMove;
  }
}
