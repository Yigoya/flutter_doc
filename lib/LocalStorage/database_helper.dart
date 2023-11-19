// database_helper.dart
import 'package:first/LocalStorage/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'tasks.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        is_completed INTEGER
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    Database db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> fetchTasks() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> tasks = await db.query('tasks');
    return tasks.map((task) => Task.fromMap(task)).toList();
  }

  Future<int> updateTask(Task task) async {
    Database db = await instance.database;
    return await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
