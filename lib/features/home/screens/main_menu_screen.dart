import 'package:flutter/material.dart';
import 'package:xo_app/core/theme/app_theme.dart';
import 'package:xo_app/features/home/widgets/size_selector.dart';
import 'package:xo_app/features/home/widgets/mode_selector.dart';

import '../../../routes/app_router.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XO Game'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuButton(
                'ENTER GAME',
                onPressed: () {
                  showModeSelector(context);
                },
            ),
            const SizedBox(height: 27),
            _buildMenuButton(
              'SIZE',
              onPressed: () {
                showSizeSelector(context);
              },
            ),
            const SizedBox(height: 27),
            _buildMenuButton(
                'HISTORY',
                onPressed: () {
                  AppRouter.goToHistoryScreen(context);
                },
            ),
            const SizedBox(height: 27),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String text, {VoidCallback? onPressed}) {
    return Container(
      width: 350,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}