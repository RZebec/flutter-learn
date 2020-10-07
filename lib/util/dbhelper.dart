import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  String tblTodo = 'todo';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  static Database _db;

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }

    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dire = await getApplicationDocumentsDirectory();
    String path = dire.path + 'todos.db';
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, ' +
            '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    return await db.insert(tblTodo, todo.toMap());
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    return await db
        .rawQuery('SELECT * FROM $tblTodo ORDER BY $colPriority ASC');
  }

  Future<int> getCount() async {
    Database db = await this.db;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tblTodo'));
  }

  Future<int> updateTodo(Todo todo) async {
    var db = await this.db;
    return await db.update(tblTodo, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.db;
    return await db.rawDelete('DELETE FROM $tblTodo WHERE $colId = $id');
  }
}
