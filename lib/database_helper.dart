import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the document directory
    String path = join(await getDatabasesPath(), 'your_database.db');

    // Open/create the database at a given path
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create tables if they don't exist
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)',
        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<void> insertUsers(List<User> users) async {
    Database db = await database;
    Batch batch = db.batch();

    for (User user in users) {
      batch.insert('users', user.toMap());
    }

    await batch.commit(noResult: true);
  }

  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }
}
