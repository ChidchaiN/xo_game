part of 'game_settings_bloc.dart';

enum GameMode { pvp, bot, replay }

class GameSettingsState extends Equatable {
  final int boardSize;
  final GameMode mode;

  const GameSettingsState({
    required this.boardSize,
    required this.mode,
  });

  GameSettingsState copyWith({
    int? boardSize,
    GameMode? mode,
  }) {
    return GameSettingsState(
      boardSize: boardSize ?? this.boardSize,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object> get props => [boardSize, mode];
}