
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ahmed.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

// اضافه للجدول صفوف مع المحافظه على بياناته السابقه
//   _onUpgrade(Database db, int oldversion, int newversion) async {
//     if (oldversion < 5) { // assuming version 5 adds the color column
//       await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
//       print("onUpgrade =====================================");
//     }
//   }


  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "color" TEXT
  )
 ''');
    print(" onCreate =====================================");

    // اضافة اكثر من جدول
 //    Batch batch = db.batch();
 //    batch.execute('''
 //  CREATE TABLE "notes" (
 //    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
 //    "title" TEXT NOT NULL,
 //    "note" TEXT NOT NULL,
 //    "color" TEXT
 //  )
 // ''');
 //    batch.execute('''
 //  CREATE TABLE "students" (
 //    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
 //    "title" TEXT NOT NULL,
 //    "note" TEXT NOT NULL,
 //    "color" TEXT
 //  )
 // ''');
 //   await batch.commit();

  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }


  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ahmed.db');
    await deleteDatabase(path);
  }



// SELECT
// DELETE
// UPDATE
// INSERT

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table,values);
    return response;
  }

  update(String table, Map<String, Object?> value, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, value,where: mywhere );
    return response;
  }

  delete(String table, String? mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: mywhere);
    return response;
  }
}
