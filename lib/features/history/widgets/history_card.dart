import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xo_app/routes/app_router.dart';

import '../../game/bloc/record/game_record_bloc.dart';
import '../../replay/screen/replay_screen.dart';

class HistoryCard extends StatelessWidget {
  final List<MoveRecord> moves;

  const HistoryCard({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    if (moves.isEmpty) return const SizedBox();

    final firstMove = moves.first;
    final lastMove = moves.last;

    final date = DateFormat('dd/MM/yyyy').format(firstMove.timestamp);
    final time = DateFormat('hh:mm a').format(lastMove.timestamp);

    // Detect winner
    final winner = _getWinner(moves);
    final header = winner;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => AppRouter.goToReplayScreen(
        context,
        moves: moves,
      ),
      child: Container(
        width: 400,
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.cardColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$date    $header', style: theme.textTheme.bodyMedium),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(time, style: theme.textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  bool _isBotGame(List<MoveRecord> moves) {
    return moves.any((m) => m.player == 'BOT');
  }

  String _getWinner(List<MoveRecord> moves) {
    if (moves.isEmpty) return 'DRAW';

    final lastMove = moves.last;
    final size = moves.map((m) => m.row).reduce((a, b) => a > b ? a : b) + 1;
    final board = List.generate(size, (_) => List.filled(size, ''));

    for (var move in moves) {
      board[move.row][move.col] = move.player;
    }

    final player = lastMove.player;

    // Check row
    if (board[lastMove.row].every((cell) => cell == player)) {
      return player == 'X' ? 'P1 WIN' : 'P2 WIN';
    }

    // Check column
    if (board.every((row) => row[lastMove.col] == player)) {
      return player == 'X' ? 'P1 WIN' : 'P2 WIN';
    }

    // Check main diagonal
    if (lastMove.row == lastMove.col &&
        List.generate(size, (i) => board[i][i]).every((cell) => cell == player)) {
      return player == 'X' ? 'P1 WIN' : 'P2 WIN';
    }

    // Check anti-diagonal
    if (lastMove.row + lastMove.col == size - 1 &&
        List.generate(size, (i) => board[i][size - i - 1]).every((cell) => cell == player)) {
      return player == 'X' ? 'P1 WIN' : 'P2 WIN';
    }

    // Check for draw
    if (moves.length == size * size) {
      return 'DRAW';
    }

    return 'DRAW';
  }
}
