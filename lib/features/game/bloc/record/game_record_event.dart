part of 'game_record_bloc.dart';

sealed class GameRecordEvent extends Equatable {
  const GameRecordEvent();

  @override
  List<Object> get props => [];
}

class AddMove extends GameRecordEvent {
  final MoveRecord move;

  const AddMove(this.move);

  @override
  List<Object> get props => [move];
}

class ResetRecord extends GameRecordEvent {
  const ResetRecord();
}
