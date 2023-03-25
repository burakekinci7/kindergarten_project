import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/ill_medicine.dart';

class DataBaseIllMedicineHelper {
  //privite yapıyoruz bunları çünkü başka bir yerden ulaşılmaz olmalıdır!.
  static const _dataBaseName = "ill_medicine2.db";
  static const _dataBaseVersion = 1;
  static const _table = "ill_medicine_table";
  //bu değikenlere model sinifinda ulaşmamız lazim
  static const columnId = "id";
  static const columnIll = "ill";
  static const columnMedicine = "medicine";
  static const columnTeacherNote = "note";

  DataBaseIllMedicineHelper._privateConstructor();

  static final DataBaseIllMedicineHelper instance =
      DataBaseIllMedicineHelper._privateConstructor();

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

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnIll TEXT,
      $columnMedicine TEXT,
      $columnTeacherNote TEXT
    )
    ''');
  }

  Future insertIllMed(IllMedicine illMedicine) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.insert(
          _table,
          {
            "id": illMedicine.id,
            "ill": illMedicine.ill,
            "medicine": illMedicine.medicine,
            "note": illMedicine.teacherNote,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  //tabloyu döndermek için kullanıcaz - tüm listedi elemanlar
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.query(_table);
    }
    return [];
  }

  Future deleteIllMedicine(int id) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return db.delete(_table, where: "$columnId = ?", whereArgs: [id]);
    } else {
      return 0;
    }
  }

  Future updateIllMedicine(IllMedicine illMedicine) async {
    Database? db = await instance.dataBaseFuture;
    int id = illMedicine.toJMap()['id'];
    if (db != null) {
      return await db.update(
        _table,
        illMedicine.toJMap(),
        where: "$columnId = ?",
        whereArgs: [id],
      );
    }
  }
}
