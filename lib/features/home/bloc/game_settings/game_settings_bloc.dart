import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'game_settings_event.dart';
part 'game_settings_state.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  GameSettingsBloc()
      : super(const GameSettingsState(boardSize: 3, mode: GameMode.pvp)) {
    on<SetBoardSize>((event, emit) {
      emit(state.copyWith(boardSize: event.size));
    });

    on<SetGameMode>((event, emit) {
      emit(state.copyWith(mode: event.mode));
    });
  }
}