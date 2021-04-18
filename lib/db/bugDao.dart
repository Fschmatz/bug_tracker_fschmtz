import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class BugDao {

  static final _databaseName = "BugTracker.db";
  static final _databaseVersion = 1;

  static final table = 'bug';
  static final columnIdBug = 'idBug';
  static final columnDescription = 'description';
  static final columnState = 'state'; // 0 do - 1 done
  static final columnColor = 'color';
  static final columnCorrectOutcome = 'correctOutcome';
  static final columnErrorDescription = 'errorDescription';
  static final columnNote = 'note';

  BugDao._privateConstructor();
  static final BugDao instance = BugDao._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnIdBug INTEGER PRIMARY KEY,            
            $columnDescription TEXT NOT NULL,
            $columnState INTEGER NOT NULL,
            $columnColor TEXT NOT NULL,  
            $columnCorrectOutcome TEXT NOT NULL,
            $columnErrorDescription TEXT NOT NULL,            
            $columnNote TEXT
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdBug];
    return await db.update(table, row, where: '$columnIdBug = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllByState(int state) async {
    Database db = await instance.database;
    return await db.rawQuery('''   
    
        SELECT *
        FROM bug 
        WHERE state=$state       
        
        ''');
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdBug = ?', whereArgs: [id]);
  }
}