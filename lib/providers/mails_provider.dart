import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gmailclone/providers/mail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Mails with ChangeNotifier {
  Future<List<Mail>> get mails async {
    return await getAllMails();
  }

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mail.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
              CREATE TABLE Mail (
              toto TEXT,
              fromfrom TEXT,
              subject TEXT,
              description TEXT,
              isFavourite TEXT,
              datedate TEXT PRIMARY KEY
              )
              ''');
    });
  }

  addMailToDatabase(Mail mail) async {
    final db = await database;
    var raw = await db.insert(
      "Mail",
      mail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
    return raw;
  }

  Future<dynamic> updateMail(DateTime date, bool isFavourite) async {
    final db = await database;
    var response = await db.update(
        "Mail", {"isFavourite": isFavourite.toString()},
        where: "datedate = ?", whereArgs: [date.toIso8601String()]);

    return response;
  }



  Future<List<Mail>> getAllMails() async {
    final db = await database;
    var response = await db.query("Mail");
    List<Mail> list = response.map((c) => Mail.fromMap(c)).toList();

    return list.reversed.toList();
  }

  deleteMailWithDate(String date) async {
    final db = await database;

    var delete = db.delete("Mail", where: "datedate = ?", whereArgs: [date]);
    notifyListeners();
    return delete;
  }
}
