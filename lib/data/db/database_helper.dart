import 'dart:async';

import 'package:digifest/data/model/expenditure_table.dart';
import 'package:sqflite/sqflite.dart';

import '../model/income_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    print("instance");
    _databaseHelper = this;
  }

  factory DatabaseHelper({Database? database}) {
    print("in Factory");
    _database = database;
    return _databaseHelper ?? DatabaseHelper._instance();
  }

  static Database? _database;

  Future<Database?> get database async {
    print("get Database");
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblExpenditure = 'expenditure';
  static const String _tblIncome = 'income';
  static const String _tblAllowance = 'allowance';

  Future<Database> _initDb() async {
    print("Init DB");
    final path = await getDatabasesPath();
    final databasePath = '$path/digifest.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE  $_tblAllowance (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tanggal TEXT,
          jumlah INTEGER,
          categories TEXT
        );
      ''');
    } on Exception catch (e) {
      print('=== Ada error dalam pembuatan $_tblAllowance ::: ${e.toString()}');
    }

    // print('Create database $_tblAllowance');

    try {
      await db.execute('''
      CREATE TABLE  $_tblExpenditure (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal TEXT,
        jumlah INTEGER,
        description TEXT
      );
    ''');
    } on Exception catch (e) {
      print(
          '=== Ada error dalam pembuatan $_tblExpenditure ::: ${e.toString()}');
    }

    // print('Create database $_tblExpenditure');

    try {
      await db.execute('''
      CREATE TABLE  $_tblIncome (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tanggal TEXT,
          jumlah INTEGER,
          description TEXT
        );
      ''');
    } on Exception catch (e) {
      print('=== Ada error dalam pembuatan $_tblIncome ::: ${e.toString()}');
    }

    // print('Create database $_tblIncome');
  }

  Future<int> insertExpenditure(ExpenditureTable expenditure) async {
    final db = await database;
    print('insert expenditure');
    return await db!.insert((_tblExpenditure), expenditure.toJson());
  }

  Future<int> insertIncome(IncomeTable income) async {
    final db = await database;
    return await db!.insert((_tblIncome), income.toJson());
  }

  Future<int> insertAllowance(IncomeTable allowance) async {
    final db = await database;
    return await db!.insert((_tblAllowance), allowance.toJson());
  }

  Future<int> removeExpenditure(ExpenditureTable expenditure) async {
    final db = await database;
    return await db!.delete(
      _tblExpenditure,
      where: 'id = ?',
      whereArgs: [expenditure.id],
    );
  }

  Future<int> removeAllowance(ExpenditureTable allowance) async {
    final db = await database;
    return await db!.delete(
      _tblAllowance,
      where: 'id = ?',
      whereArgs: [allowance.id],
    );
  }

  Future<int> removeIncome(IncomeTable income) async {
    final db = await database;
    return await db!.delete(
      _tblIncome,
      where: 'id = ?',
      whereArgs: [income.id],
    );
  }

  Future<Map<String, dynamic>?> getExpenditureById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblExpenditure,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getIncomeById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblIncome,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getAllowanceById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblAllowance,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getExpenditure() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblExpenditure);
    print('result :: $results');
    return results;
  }

  Future<List<Map<String, dynamic>>> getIncome() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblIncome);
    // print(results);
    return results;
  }

  Future<List<Map<String, dynamic>>> getAllowance() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblAllowance);
    // print(results);
    return results;
  }
}
