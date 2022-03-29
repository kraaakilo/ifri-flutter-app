import 'package:ifri_management/logic/CreateUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(
        '''
        CREATE TABLE $usersTable ( 
          id $idType, 
          firstname $textType,
          lastname $textType,
          birthday $textType,
          address $textType,
          phone $textType,
          email $textType,
          gender $textType,
          picture $textType,
          citation $textType
          )
        ''');
  }

  Future<int> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(usersTable, user.toJson());
    return id;
  }

  Future<User> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      usersTable,
      columns: UserFields.values,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> getUsers() async {
    final db = await instance.database;

    const orderBy = 'id DESC';

    final result = await db.query(usersTable, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
