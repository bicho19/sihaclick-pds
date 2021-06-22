import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:sihaclik/store/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const String _TOKEN_KEY = "jwtToken";
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  // Create storage
  final _secureStorage = new FlutterSecureStorage();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "sihacLIK.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, lastname TEXT, email TEXT, phone TEXT)");
    debugPrint("Created tables");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.saveToJson());
    return res;
  }

  Future<int> deleteUsers() async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getLoggedInUser() async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query("User", limit: 1);
    if (res.length > 0) {
      debugPrint("DatabaseHelper :: user logged in");
      User user = User.fromJson(res[0]);
      return user;
    } else {
      debugPrint("DatabaseHelper :: user not logged in");
      return null;
    }
  }

  Future<String> isLoggedIn() async {
    var token = await getToken();
    if (token != null && token.length > 0) return token;
    return null;
  }

  Future<void> saveToken({String token}) async {
    // Write value
    await _secureStorage.write(key: _TOKEN_KEY, value: token);
  }

  Future<String> getToken() async {
    // Read value
    String value = await _secureStorage.read(key: _TOKEN_KEY);
    return value;
  }

  Future<void> clearAllData() async {
    await _secureStorage.deleteAll();
  }
}
