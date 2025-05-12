import 'package:flutter/material.dart';
import 'package:xo_app/features/game/screens/game_screen.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';
import 'package:xo_app/features/home/screens/main_menu_screen.dart';

import '../features/game/bloc/record/game_record_bloc.dart';
import '../features/history/screen/history_screen.dart';
import '../features/replay/screen/replay_screen.dart';

class AppRouter {
  static void goToGameScreen(BuildContext context, {required GameMode mode, required int size}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameScreen(
          mode: mode,
          size: size,
        ),
      ),
    );
  }
  static void goToMainMenu(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainMenuScreen(),
      ),
      (route) => false, // Remove all previous routes
    );
  }

  static void goToHistoryScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
      ),
    );
  }

  static void goToReplayScreen(BuildContext context, {required List<MoveRecord> moves}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReplayScreen(moves: moves),
      ),
    );
  }
}