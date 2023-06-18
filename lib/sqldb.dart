import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?>? get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Notes ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "note" TEXT NOT NULL)');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  readData({required String sql}) async {
    Database? database = await db;
    List<Map<String, Object?>> response = await database!.rawQuery(sql);
    return response;
  }

  insertData({required String sql}) async {
    Database? database = await db;
    int response = await database!.rawInsert(sql);
    return response;
  }

  updateData({required String sql}) async {
    Database? database = await db;
    int response = await database!.rawUpdate(sql);
    return response;
  }

  deleteData({required String sql}) async {
    Database? database = await db;
    int response = await database!.rawDelete(sql);
    return response;
  }
}
