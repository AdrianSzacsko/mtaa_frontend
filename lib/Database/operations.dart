import 'package:mtaa_frontend/Database/SearchModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'search.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE search (p_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,code TEXT NOT NULL, id TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertSearch(List<SearchDB> search) async {
    int result = 0;
    final Database db = await initializeDB();
    
    await db.execute("CREATE TABLE IF NOT EXISTS search (p_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,code TEXT NOT NULL, id TEXT NOT NULL)");

    await db.execute("DELETE FROM search");

    for(var search in search){
      result = await db.insert('search', search.toMap());
    }
    return result;
  }

  // do not use
  Future<List<SearchDB>> retrieveAllSearch() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('search');
    return queryResult.map((e) => SearchDB.fromMap(e)).toList();
  }

  Future<List<SearchDB>> retrieveSearch(String search_string) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(
        'search',
      where: "name like ? or code like ?",
      whereArgs: ["%" + search_string + "%"],
    );
    return queryResult.map((e) => SearchDB.fromMap(e)).toList();
  }


  Future<void> dropSearch() async {
    final db = await initializeDB();
    await db.execute(
      'DROP TABLE search'
    );
  }

}