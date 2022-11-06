
import 'package:flutter/material.dart';
import 'package:newsapp/Model/article_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class DatabaseHelper extends ChangeNotifier{
  static const int _version = 1;
  static const String _dbName = "Bookmark.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Bookmark("
                "url TEXT PRIMARY KEY, "
                "title TEXT NOT NULL, "
                "description TEXT NOT NULL,"
                 "urlToImage TEXT);"),
        version: _version);
  }

  static Future<int> addNote(Article article) async {
    final db = await _getDB();
    print(article.urlToImage);
    return await db.insert("Bookmark", {"url":article.url,"title":article.title,
      "description":article.description,"urlToImage":article.urlToImage.toString()},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



  static Future<int> deleteNote(Article article) async {
    final db = await _getDB();
    return await db.delete(
      "Bookmark",
      where: 'url = ?',
      whereArgs: [article.url],
    );
  }

  static Future<List<Article>?> getAllNotes() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Bookmark");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Article.fromJson(maps[index]));
  }
}