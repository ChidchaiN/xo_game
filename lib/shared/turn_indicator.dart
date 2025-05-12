import 'package:flutter/material.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';

class TurnIndicator extends StatelessWidget {
  final String currentPlayer;
  final GameMode mode;

  const TurnIndicator({
    super.key,
    required this.currentPlayer,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    String turnText;
    if (currentPlayer == 'X') {
      turnText = 'P1';
    } else {
      turnText = mode == GameMode.bot ? 'BOT' : 'P2';
    }

    return Text(
      'TURN: $turnText',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black),
        ],
      ),
    );
  }
}