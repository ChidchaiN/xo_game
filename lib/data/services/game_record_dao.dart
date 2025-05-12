import 'package:sembast/sembast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as p;
import 'package:xo_app/features/game/bloc/record/game_record_bloc.dart';

class GameRecordDao {
  static final GameRecordDao _instance = GameRecordDao._internal();
  static const String _storeName = 'game_records';
  final _store = intMapStoreFactory.store(_storeName);
  late Database _db;
  bool _initialized = false;

  GameRecordDao._internal();

  factory GameRecordDao() => _instance;

  Future<void> init() async {
    if (_initialized) return;
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = p.join(dir.path, 'game.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    _initialized = true;
  }

  Future<void> saveGameRecord(List<MoveRecord> moves) async {
    if (!_initialized) {
      await init();
    }
    await _store.add(_db, {
      'moves': moves.map(_moveToMap).toList(),
      'savedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<List<MoveRecord>>> loadAllGameRecords() async {
    final snapshots = await _store.find(_db);
    return snapshots.map((record) {
      final moveList = record.value['moves'] as List;
      return moveList.map((m) => _moveFromMap(Map<String, dynamic>.from(m))).toList();
    }).toList();
  }

  Future<void> clearAllRecords() async => await _store.delete(_db);

  Map<String, dynamic> _moveToMap(MoveRecord move) => {
    'row': move.row,
    'col': move.col,
    'player': move.player,
    'timestamp': move.timestamp.toIso8601String(),
  };

  MoveRecord _moveFromMap(Map<String, dynamic> map) => MoveRecord(
    row: map['row'],
    col: map['col'],
    player: map['player'],
    timestamp: DateTime.parse(map['timestamp']),
  );
}

