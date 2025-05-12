import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xo_app/shared/game_board.dart';
import 'package:xo_app/shared/turn_indicator.dart';
import 'package:xo_app/features/game/bloc/record/game_record_bloc.dart';

import '../../home/bloc/game_settings/game_settings_bloc.dart';

class ReplayScreen extends StatefulWidget {
  final List<MoveRecord> moves;

  const ReplayScreen({super.key, required this.moves});

  @override
  State<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  late List<List<String>> _board;
  int _currentMoveIndex = 0;
  String _currentPlayer = 'X';
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    final size = widget.moves.map((m) => m.row > m.col ? m.row : m.col).reduce((a, b) => a > b ? a : b) + 1;
    _board = List.generate(size, (_) => List.filled(size, ''));

    _startReplay();
  }

  void _startReplay() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_currentMoveIndex >= widget.moves.length) {
        _timer?.cancel();
        return;
      }

      final move = widget.moves[_currentMoveIndex];
      setState(() {
        _board[move.row][move.col] = move.player;
        _currentPlayer = move.player == 'X' ? 'O' : 'X';
        _currentMoveIndex++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'REPLAY',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
            shadows: [Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black)],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Center(
            child: TurnIndicator(
              currentPlayer: _currentPlayer,
              mode: GameMode.replay,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.white,
                      child: GameBoard(
                        board: _board,
                        onTap: null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
