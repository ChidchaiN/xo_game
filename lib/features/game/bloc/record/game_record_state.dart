part of 'game_record_bloc.dart';

class GameRecordState extends Equatable {
  final List<MoveRecord> moves;

  const GameRecordState({this.moves = const []});

  GameRecordState copyWith({List<MoveRecord>? moves}) {
    return GameRecordState(moves: moves ?? this.moves);
  }

  @override
  List<Object> get props => [moves];
}

class MoveRecord extends Equatable {
  final int row;
  final int col;
  final String player; // 'X' or 'O'
  final DateTime timestamp;

  const MoveRecord({
    required this.row,
    required this.col,
    required this.player,
    required this.timestamp,
  });

  @override
  List<Object> get props => [row, col, player, timestamp];
}
