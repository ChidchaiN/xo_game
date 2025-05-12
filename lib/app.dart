import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xo_app/core/theme/app_theme.dart';
import 'package:xo_app/features/home/bloc/game_settings/game_settings_bloc.dart';
import 'package:xo_app/features/game/bloc/record/game_record_bloc.dart';
import 'package:xo_app/features/home/screens/main_menu_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameSettingsBloc>(
          create: (_) => GameSettingsBloc(),
        ),
        BlocProvider<GameRecordBloc>(
          create: (_) => GameRecordBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'XO Game',
        theme: AppTheme.lightTheme,
        home: const MainMenuScreen(),
      ),
    );
  }
}