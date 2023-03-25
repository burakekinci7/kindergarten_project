import 'dart:async';

import 'package:flutter_anaokulu_project/models/allergy.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseAllergy {
  static const _dataBaseName = "allergy5.db";
  static const _dataBaseVersion = 1;
  static const table = "allergy5_table"; //
  static const columnId = "id";
  static const columnAllergy = "allergyName";
  static const columnState = "state";
  static const columnTeacherNote = "teacherNote";

  DataBaseAllergy._privateConstructor();

  static final DataBaseAllergy instance = DataBaseAllergy._privateConstructor();
  static Database? _database;

  Future<Database?> get dataBaseFuture async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return null;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dataBaseName);
    return await openDatabase(path,
        version: _dataBaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnAllergy TEXT,
      $columnState INTEGER,
      $columnTeacherNote TEXT
    )
    ''');
  }

  Future insertAllergy(Allergy allergy) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.insert(
          table,
          {
            "allergyName": allergy.allergyName,
            "state": allergy.state,
            "teacherNote": allergy.teacherNote,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRowsAllergy() async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.query(table);
    }
    return [];
  }

  Future delete(int id) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return db.delete(table, where: "$columnId = ?", whereArgs: [id]);
    } else {
      return "";
    }
  }

  Future<int> updateAllergy(Allergy allergy) async {
    Database? db = await instance.dataBaseFuture;
    int stateUpdate = allergy.toJson()['id'];
    if (db != null) {
      return await db.update(
        table,
        allergy.toJson(),
        where: "$columnId = ?",
        whereArgs: [stateUpdate],
      );
    }
    return -1;
  }
}
