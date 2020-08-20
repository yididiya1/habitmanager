import 'package:habitmanager1/entities/Habit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';



class DatabaseHelper{
  
  static DatabaseHelper _databaseHelper; //Singleton DatabasrHelper
  static Database _database; //Singleton Database

  String habitTable = 'habitTable';
  String colId = 'id';
  String colHabitName = 'habitName';
  String colHabitDescription = 'habitDescription';
  String colDays = 'numberOfDays';


  DatabaseHelper._createInstance(); //Named constructor to create instance of DatabaseHelper
    
  
  factory DatabaseHelper(){
    
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); //this is executed once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if(_database == null){
        _database = await initializeDatabase();
    }
    return _database;
  }


  Future<Database> initializeDatabase() async{
    //Get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'habits.db' ;

    //Open/create the database at this given path
    var notesDatabase = await openDatabase(path,version: 1,onCreate: _createDB);
    return notesDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    
    await db.execute('CREATE TABLE $habitTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colHabitName TEXT, $colHabitDescription TEXT, $colDays INTEGER )');

  }

  //Fetch Operation
  Future<List<Map<String,dynamic>>> getHabitMapList() async {
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(habitTable,orderBy:'$colId ASC');
    return result;
  }

  //Update
  Future<int> updateHabit(Habit habit) async {
    Database db = await this.database;
    var result = await db.update(habitTable,habit.toMap(),where:'$colId = ?',whereArgs:[habit.id]);
    return result;
  }

  //Insert
  Future<int> insertHabit(Habit habit) async {
    Database db = await this.database;
    var result = db.insert(habitTable,habit.toMap());
    return result;
  }

  //Delete
  Future<int> deleteHabit(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $habitTable WHERE $colId = $id');
    return result;
  }

  //Get the number objects in the database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $habitTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


  //Get the MapList List<Map> and convert it to Note List List<Note>
  Future<List<Habit>> getHabitList() async {

    var noteMapList = await getHabitMapList(); //Get Map List from the database
    int count = noteMapList.length; 

    List<Habit> noteList = List<Habit>();

    for(int i = 0;i < count; i++){
      noteList.add(Habit.fromMapObject(noteMapList[i]));
    }

    return noteList;

  }



}