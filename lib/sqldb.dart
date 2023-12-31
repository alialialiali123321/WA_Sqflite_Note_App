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

  //? For multiple tables
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE Notes (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "note" TEXT NOT NULL,
        "color" TEXT NOT NULL
        )''');

    //     batch.execute('''
    // CREATE TABLE nameDB (
    // "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    // "nameC" TEXT NOT NULL
    // )''');

    await batch.commit();
  }

  //? For one table
  // _onCreate(Database db, int version) async {
  //   await db.execute('''
  //       CREATE TABLE Notes (
  //       "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  //       "title" TEXT NOT NULL,
  //       "note" TEXT NOT NULL,
  //       "color" TEXT NOT NULL
  //       )''');
  // }

  //? When the version number is changed
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
        ALTER TABLE Notes ADD COLUMN
        "color" TEXT NOT NULL
        ''');
  }

  readData({required String table}) async {
    Database? database = await db;
    List<Map<String, Object?>> response = await database!.query(table);
    return response;
  }

  insertData({
    required String table,
    required Map<String, Object?> values,
  }) async {
    Database? database = await db;
    int response = await database!.insert(table, values);
    return response;
  }

  updateData({
    required String table,
    required Map<String, Object?> values,
    required String where,
  }) async {
    Database? database = await db;
    int response = await database!.update(table, values, where: where);
    return response;
  }

  deleteData({required String table, required String where}) async {
    Database? database = await db;
    int response = await database!.delete(table, where: where);
    return response;
  }

  deleteDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
  }
}
