import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';

void showSizeSelector(BuildContext context) async {
  final selectedSize = await showDialog<int>(
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
                'Select Board Size',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(8, (index) {
                  final size = index + 3; // 3x3 to 10x10
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(size);
                    },
                    child: Text('${size}x$size'),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    },
  );

  if (selectedSize != null) {
    debugPrint('Selected size: $selectedSize');
    context.read<GameSettingsBloc>().add(SetBoardSize(selectedSize));
  }
}