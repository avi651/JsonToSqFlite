import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static const _databaseName = "Continental.db";
  static const _databaseVersion = 1;
  static const tableName = "ContinentalUsers";
  static const columnId = 'id';
  static const title = 'title';
  static const description = 'description';
  static const imageHref = 'imageHref';

  Future<Database?> get databse async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $title TEXT NOT NULL,
            $description TEXT NOT NULL,
            $imageHref BLOB NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.databse;
    return await db?.insert(tableName, row) ?? 0;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.databse;
    return await db?.query(tableName) ?? [];
  }

  Future<int> delete(int id) async {
    Database? db = await instance.databse;
    return await db
            ?.delete(tableName, where: '$columnId = ?', whereArgs: [id]) ??
        0;
  }

  Future<void> deleteDB() async {
    try {
      final db = await instance.databse;
      db?.delete(tableName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
