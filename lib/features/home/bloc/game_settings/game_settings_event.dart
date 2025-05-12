part of 'game_settings_bloc.dart';

abstract class GameSettingsEvent extends Equatable {
  const GameSettingsEvent();

  @override
  List<Object> get props => [];
}

class SetBoardSize extends GameSettingsEvent {
  final int size;

  const SetBoardSize(this.size);

  @override
  List<Object> get props => [size];
}

class SetGameMode extends GameSettingsEvent {
  final GameMode mode;

  const SetGameMode(this.mode);

  @override
  List<Object> get props => [mode];
}
