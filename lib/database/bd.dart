import 'package:flutter/foundation.dart';
import 'package:sqflite/sqfilite' as sql;

class SqlDb {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tutorial(
    id INTEGER PRIMARY KEY ATOINCREMENT NOT NULL,
    title TEXT,
    createAt TIMESTAMP NOT NLL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'bdteste.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },

    );
  }

  //Insert
  static Future<int> insert(String title, String? descrption) async {
    final db = await SqlDb.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('items', data,
        conflicAlgorithm: sql.ConflicAlgorithm.replace);
    return id;
  }

  //Mostrar todos o items
  static Future<List<Map<String, dynamic>>> buscarTodos() async {
    final db = await SqlDb.db();
    return db.qhery('items', orderBy: "id");
  }
    //Busca por item
    static Future<List<Map<String, dynamic>>> buscarPorItem (int id) async {
      final db = await SqlDb.db();
      return db.qhery('items', where: "id = ?", whereArgs: [id], limit: 1);
    }

    //Update
    static Future<int>atualizaItem(
        int id, String title, String? descrption) async {
      final db = await SqlDb.db();


      final data = {
        'title':title,
        'description':descrption,
        'createAt': DateTime.now().toString()
      };

      final result =
          await db.update('items',data, where: "id=?", whereArgs: [id]);
      return result;

    }

    //Delete
    static Future<void> deleteItem(int id) async{
    final db = await SqlDb.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    }catch (err) {
      debugPrint("Algo deu errado na exclusão do item: $err");

    }
    }

  }
