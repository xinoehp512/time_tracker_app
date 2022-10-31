import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    //deleteDatabase(join(dbPath, "activities.db"));
    return openDatabase(
      join(dbPath, 'activities.db'),
      onCreate: (db, version) {
        return db
            .execute(
                'CREATE TABLE activities(name TEXT PRIMARY KEY, color INTEGER)')
            .then((_) => db.execute(
                'CREATE TABLE logs(id INTEGER PRIMARY KEY, activity TEXT, startDate INTEGER, endDate INTEGER, length INTEGER)'));
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.database();
    await sqlDb.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();
    return sqlDb.query(table);
  }
}
