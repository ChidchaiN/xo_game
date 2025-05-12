import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';
import 'package:xo_app/routes/app_router.dart';

void showModeSelector(BuildContext context) async {
  final selectedMode = await showDialog<String>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.grey.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Game Mode',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 226,
                    height: 126,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop('PVP');
                      },
                      child: const Text(
                        'PVP',
                        style: TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    width: 226,
                    height: 126,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop('BOT');
                      },
                      child: const Text(
                        'BOT',
                        style: TextStyle(fontSize: 68, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (selectedMode != null) {
    final mode = selectedMode == 'PVP' ? GameMode.pvp : GameMode.bot;
    final size = context.read<GameSettingsBloc>().state.boardSize;
    AppRouter.goToGameScreen(context, mode: mode, size: size);
  }
}