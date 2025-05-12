import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_app/features/game/bloc/logic/game_logic_bloc.dart';
import 'package:xo_app/features/game/bloc/record/game_record_bloc.dart';
import '../../../data/services/game_record_dao.dart';
import '../models/minimax.dart';
import '../../../shared/game_board.dart';
import '../../../shared/turn_indicator.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';
import 'package:xo_app/features/game/widgets/end_game_dialog.dart';

class GameScreen extends StatefulWidget {
  final int size;
  final GameMode mode;

  const GameScreen({
    super.key,
    required this.size,
    required this.mode,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameLogic _gameLogic;

  @override
  void initState() {
    super.initState();
    _gameLogic = GameLogic(widget.size);

    context.read<GameRecordBloc>().add(const ResetRecord());
  }

  void _handleTap(int row, int col) async {
    // Player's move
    final playerEnded = _gameLogic.handleTap(row, col);

    // Add the move to the game record
    context.read<GameRecordBloc>().add(
      AddMove(
        MoveRecord(
          row: row,
          col: col,
          player: _gameLogic.board[row][col],
          timestamp: DateTime.now(),
        ),
      ),
    );
    setState(() {}); // Update UI

    if (playerEnded) {
      _showEndGameDialog();
      return;
    }

    // Bot's move (if mode is bot)
    if (widget.mode == GameMode.bot) {
      setState(() {
      });

      await Future.delayed(const Duration(seconds: 1)); // Add delay for better UX

      final bestMove = TicTacToeAI.findBestMove(_gameLogic.board);
      final botEnded = _gameLogic.handleTap(bestMove[0], bestMove[1]);

      // Add the bot's move to the game record
      context.read<GameRecordBloc>().add(
        AddMove(
          MoveRecord(
            row: bestMove[0],
            col: bestMove[1],
            player: _gameLogic.board[bestMove[0]][bestMove[1]],
            timestamp: DateTime.now(),
          ),
        ),
      );
      setState(() {}); // Update UI

      if (botEnded) {
        _showEndGameDialog();
      }
    }
  }

  void _showEndGameDialog() async {
    String message;
    if (_gameLogic.checkDraw()) {
      message = 'DRAW!';
    } else {
      message = '${_gameLogic.currentPlayer} WINS!';
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => EndGameDialog(message: message),
    ).then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final modeText = widget.mode.name.toUpperCase();

    return BlocListener<GameRecordBloc, GameRecordState>(
      listener: (context, state) async {
        if (_gameLogic.isGameEnd) {
          String message;
          if (_gameLogic.checkDraw()) {
            message = 'DRAW!';
          } else {
            message = '${_gameLogic.currentPlayer} WINS!';
          }

          for (var move in state.moves) {
            debugPrint('Player: ${move.player}, Row: ${move.row}, Col: ${move.col}, Time: ${move.timestamp}');
          }

          await GameRecordDao().saveGameRecord(context.read<GameRecordBloc>().state.moves);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => EndGameDialog(message: message),
          ).then((_) {
            Navigator.of(context).pop();
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              modeText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.white,
                shadows: [Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black)],
              ),
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
                currentPlayer: _gameLogic.currentPlayer,
                mode: widget.mode,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: GameBoard(
                      board: _gameLogic.board,
                      onTap: _handleTap,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}