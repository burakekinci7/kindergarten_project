import 'package:flutter_anaokulu_project/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelperStudent {
  static const _dataBaseName = "student2.db"; //excahngeS
  static const _dataBaseVersion = 1;
  static const table = "student2_table";
  static const columnId = "id";
  static const columnTc = "tc";
  static const columnName = "name";
  static const columnSurName = "surname";
  static const columnAge = "age";
  static const columnHeight = "height";
  static const columnWeight = "weight";
  static const columnBirth = "birth";
  static const columnAdress = "adress";
  static const columnImagePath = "imagepath";

  DataBaseHelperStudent._privateConstructor();

  static final DataBaseHelperStudent instance =
      DataBaseHelperStudent._privateConstructor();
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
      $columnTc INTEGER NOT NULL,
      $columnName TEXT,
      $columnSurName TEXT,
      $columnAge INTEGER,
      $columnHeight INTEGER,
      $columnWeight INTEGER,
      $columnBirth TEXT,
      $columnAdress TEXT,
      $columnImagePath TEXT
    )
    ''');
  }

  //database tabloların kayıt yapmak için kullanılır -
  Future insert(Student student) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.insert(
          table,
          {
            "id": student.id,
            "tc": student.tc,
            "name": student.name,
            "surname": student.surname,
            "age": student.age,
            "height": student.height,
            "weight": student.weight,
            "birth": student.birth,
            "adress": student.adress,
            "imagepath": student.imagePath,
          },
          //idler öğrenciler özel olduğu için aynı plakadan sadecebir tane olabilir
          //alttaki komut ise aynı id'li öğrenci çağrırırsa update yapar
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  //tabloyu döndermek için kullanıcaz - tüm listedeki elemanlar
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return await db.query(table);
    }
    return [];
  }

  //TC si verilen bir öğrencinin silinmesi - elemet delete in list
  Future delete(int tc) async {
    Database? db = await instance.dataBaseFuture;
    if (db != null) {
      return db.delete(table, where: "$columnTc = ?", whereArgs: [tc]);
    } else {
      return "";
    }
  }
}
