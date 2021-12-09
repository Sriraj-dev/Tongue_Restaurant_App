import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB{
  static final LocalDB instance = LocalDB._init();

  Database? _database;
  LocalDB._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('items2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);

    return await openDatabase(path, version: 2,onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{
    print('Creating the table');
    await db.execute('CREATE TABLE user_favItems(iid TEXT NOT NULL)');
    await db.execute('CREATE TABLE user_cartItems(iid TEXT NOT NULL)');
    await db.execute('CREATE TABLE user_homeAddress(Address TEXT NOT NULL)');
    return db;
  }

  Future close()async{
    final db = await instance.database;

    db.close();
  }

  Future insert(String tableName,Map<String,dynamic> data)async{
    final db = await instance.database;

    db.insert(tableName, data , conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String,dynamic>>> getData(String tableName)async{
    final db = await instance.database;
    var res = await db.query(tableName);
    res.toList();
    print(res);
    return res;
  }

  delete(String tableName,var id)async{
    final db = await instance.database;

    await db.rawDelete('DELETE FROM $tableName WHERE iid = ?',[id]);
  }

  clearTable(String tableName)async{
    final db = await instance.database;

    await db.rawDelete('DELETE FROM $tableName');
  }
}