import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:final_barnyard_defenders/omed_work/game_stats.dart';

class DatabaseHelper {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'game_stats.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE stats(id INTEGER PRIMARY KEY AUTOINCREMENT, gamesPlayed INTEGER, gamesWon INTEGER, highestScore INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future<int> insertStats(GameStats stats) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('stats', stats.toMap());
    return result;
  }
}