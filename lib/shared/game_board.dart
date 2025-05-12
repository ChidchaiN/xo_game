import 'package:flutter/material.dart';
import 'package:xo_app/core/theme/app_theme.dart';

class GameBoard extends StatelessWidget {
  final List<List<String>> board;
  final void Function(int row, int col)? onTap;

  const GameBoard({super.key, required this.board, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(board.length, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(board[row].length, (col) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      elevation: 0,
                    ),
                    onPressed: onTap == null ? null : () => onTap!(row, col),
                    child: Text(
                      board[row][col],
                      style: const TextStyle(
                        fontSize: 49,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}