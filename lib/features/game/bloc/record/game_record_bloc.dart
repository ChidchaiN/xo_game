import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_record_event.dart';
part 'game_record_state.dart';

class GameRecordBloc extends Bloc<GameRecordEvent, GameRecordState> {
  GameRecordBloc() : super(const GameRecordState()) {
    on<AddMove>(_onAddMove);
    on<ResetRecord>(_onResetRecord);
  }

  void _onAddMove(AddMove event, Emitter<GameRecordState> emit) {
    if (state.moves.any((move) =>
        move.row == event.move.row &&
        move.col == event.move.col &&
        move.player == event.move.player)) {
      return;
    }

    final updatedMoves = List<MoveRecord>.from(state.moves)..add(event.move);
    emit(state.copyWith(moves: updatedMoves));
  }

  void _onResetRecord(ResetRecord event, Emitter<GameRecordState> emit) {
    emit(const GameRecordState());
  }
}
