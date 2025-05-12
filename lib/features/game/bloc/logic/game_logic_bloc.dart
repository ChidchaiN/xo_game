class GameLogic {
  final int size;
  late List<List<String>> board;
  String currentPlayer = 'X';
  bool isGameOver = false;

  GameLogic(this.size) {
    board = List.generate(size, (_) => List.generate(size, (_) => ''));
  }

  bool get isGameEnd => isGameOver;

  bool handleTap(int row, int col) {
    if (board[row][col].isNotEmpty || isGameOver) return false;

    board[row][col] = currentPlayer;
    if (_checkWin(row, col)) {
      isGameOver = true;
      return true;
    } else if (checkDraw()) {
      isGameOver = true;
      return true;
    } else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      return false;
    }
  }

  bool _checkWin(int row, int col) {
    if (board[row].every((cell) => cell == currentPlayer)) return true;
    if (board.every((r) => r[col] == currentPlayer)) return true;
    if (row == col && List.generate(size, (i) => board[i][i]).every((cell) => cell == currentPlayer)) return true;
    if (row + col == size - 1 &&
        List.generate(size, (i) => board[i][size - 1 - i]).every((cell) => cell == currentPlayer)) return true;
    return false;
  }

  bool checkDraw() {
    return board.every((row) => row.every((cell) => cell.isNotEmpty));
  }
}