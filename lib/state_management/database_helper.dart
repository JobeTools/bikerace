import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'app_database.db');

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );

    await _clearUserData(database);

    return database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE settings(id INTEGER PRIMARY KEY, isDarkMode INTEGER)');
    await db
        .execute('CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT)');
    // Add more tables as needed
  }

  Future<void> _clearUserData(Database database) async {
    final tablesToPreserve = ['settings'];
    final tables = await database
        .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);

    for (final table in tables) {
      final tableName = table['name'] as String;
      if (!tablesToPreserve.contains(tableName)) {
        await database.delete(tableName);
      }
    }
  }

  Future<void> saveSettings(bool isDarkMode) async {
    final db = await database;
    await db.update(
      'settings',
      {'isDarkMode': isDarkMode ? 1 : 0},
    );
  }

  Future<bool> getDarkModeSetting() async {
    final db = await database;
    final result = await db.query('settings');
    if (result.isNotEmpty) {
      return result.first['isDarkMode'] == 1;
    }
    return false;
  }

  Future<void> saveUsername(String username) async {
    final db = await database;
    await db.update(
      'user',
      {'username': username},
    );
  }

  Future<String> getUsername() async {
    final db = await database;
    final result = await db.query('user');
    if (result.isNotEmpty) {
      return result.first['username'] as String;
    }
    return '';
  }

  // Add more helper methods for CRUD operations as needed
}
