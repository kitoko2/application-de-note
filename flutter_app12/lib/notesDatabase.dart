import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class NotesDataBase {
  NotesDataBase._();
  static NotesDataBase instance = NotesDataBase._();

  static Database db;

  Future<Database> get database async {
    if (db != null) {
      return db;
    } else {
      db = await initDB();
      return db;
    }
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), "MeSNotes.db"),
      onCreate: (db, i) {
        return db.execute(
          "CREATE TABLE note(titre TEXT,note TEXT,name TEXT,jour INT,mois INT,annee INT,heure INT,minute INT,isfa INT)",
        );
      },
      version: 1,
    );
  }

  insertNote(MiniCont miniCont) async {
    final Database tdb = await database;
    await tdb.insert(
      "note",
      miniCont.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateNote(MiniCont miniCont, int isfa) async {
    final Database tdb = await database;
    await tdb.update(
      "note",
      miniCont.toMap(),
      where: "isfa=?",
      whereArgs: [isfa],
    );
  }

  deleteNote(String titre) async {
    final Database tdb = await database;
    tdb.delete(
      "note",
      where: "titre=?",
      whereArgs: [titre],
    );
  }

  Future<List<MiniCont>> notes() async {
    final Database tdb = await database;
    List<Map<String, dynamic>> maps = await tdb.query("note");
    List<MiniCont> mesnotes = List.generate(
      maps.length,
      (index) {
        return MiniCont.fromMap(maps[index]);
      },
    );
    if (mesnotes.isEmpty) {
      for (MiniCont m in defaultNotes) {
        insertNote(m);
      }
      mesnotes = defaultNotes;
    }
    return mesnotes;
  }

  List<MiniCont> defaultNotes = [
    MiniCont(
        "JNRH",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "Richard",
        // Color.fromRGBO(100, 12, 5, 0.4),
        // Colors.red,
        27,
        12,
        2020,
        9,
        30,
        1),
    MiniCont(
        "EMM",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "jean",
        // Color.fromRGBO(10, 120, 5, 0.4),
        // Colors.green,
        27,
        12,
        2020,
        9,
        30,
        0),
    MiniCont(
        "ENERGIE",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "ange",
        // Color.fromRGBO(10, 12, 244, 0.4),
        // Colors.blue,
        20,
        10,
        2020,
        12,
        00,
        1),
    MiniCont(
        "RH MAG",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "yao",
        // Color.fromRGBO(100, 12, 5, 0.4),
        // Colors.red,
        27,
        12,
        2020,
        9,
        30,
        1),
    MiniCont(
        "CGA",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "Richar",
        // Color.fromRGBO(10, 12, 244, 0.4),
        // Colors.blue,
        28,
        12,
        2020,
        9,
        35,
        0),
    MiniCont(
        "MERCI",
        "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
        "jean",
        // Color.fromRGBO(10, 120, 5, 0.4),
        // Colors.green,
        27,
        12,
        2020,
        9,
        30,
        1),
  ];
}
