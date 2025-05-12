import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class SembastDb {
  static final SembastDb _singleton = SembastDb._internal();
  factory SembastDb() => _singleton;

  SembastDb._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'game.db');
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
