// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DBHelper {
//   static const _databaseName = "GameStats.db";
//   static const _databaseVersion = 1;
//   static const table = 'stats';
//   static const columnId = 'id';
//   static const columnScore = 'score';
//
//   DBHelper._privateConstructor();
//   static final DBHelper instance = DBHelper._privateConstructor();
//
//   static Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }
//
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE $table (
//             $columnId INTEGER PRIMARY KEY,
//             $columnScore INTEGER NOT NULL
//           )
//           ''');
//   }
//
//   Future<int> insert(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     return await db.insert(table, row);
//   }
//
//   Future<List<Map<String, dynamic>>> queryAllRows() async {
//     Database db = await instance.database;
//     return await db.query(table);
//   }
//
//   Future<int> delete(int id) async {
//     Database db = await instance.database;
//     return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   // Method to update a record
//   Future<int> update(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     int id = row[columnId];
//     return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
//   }
//
//   // Method to get a single record by id
//   Future<Map<String, dynamic>> queryRow(int id) async {
//     Database db = await instance.database;
//     List<Map> results =
//         await db.query(table, where: '$columnId = ?', whereArgs: [id]);
//     if (results.isNotEmpty) {
//       return results.first;
//     }
//     return null;
//   }
//
//   // Method to handle complex queries or joins (if needed)
//   Future<List<Map<String, dynamic>>> customQuery(String query) async {
//     Database db = await instance.database;
//     return await db.rawQuery(query);
//   }
// }
