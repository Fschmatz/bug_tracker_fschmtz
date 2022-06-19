import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class BugDao {

  static final _databaseName = "BugTracker.db";
  static final _databaseVersion = 1;

  static final table = 'bug';
  static final columnIdBug = 'idBug';
  static final columnApplicationName = 'applicationName';
  static final columnDescription = 'description';
  static final columnCorrectOutcome = 'correctOutcome';
  static final columnState = 'state'; // 0 open - 1 closed
  static final columnPriority = 'priority'; // 0 yellow - 1 orange - 2 red
  static final columnHowWasSolved = 'howWasSolved';
  static final columnNote = 'note';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  BugDao._privateConstructor();
  static final BugDao instance = BugDao._privateConstructor();

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
            $columnApplicationName TEXT NOT NULL,
            $columnState INTEGER NOT NULL,
            $columnPriority INTEGER NOT NULL,  
            $columnCorrectOutcome TEXT NOT NULL,    
            $columnHowWasSolved TEXT,     
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

  Future<int?> queryRowCount() async {
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