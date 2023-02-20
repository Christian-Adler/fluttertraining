import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    sql.Database sqlDB = await _database(table);

    await sqlDB.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String id) async {
    sql.Database sqlDB = await _database(table);

    await sqlDB.delete(table, where: 'id =?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    sql.Database sqlDB = await _database(table);

    return sqlDB.query(table);
  }

  static Future<sql.Database> _database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    final sqlDB = await sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
    return sqlDB;
  }
}
