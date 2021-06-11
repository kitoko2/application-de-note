import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'home.dart';

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
      join(await getDatabasesPath(), "MYNOTE.db"),
      onCreate: (db, i) {
        return db.execute(
          "CREATE TABLE note(id INT,titre TEXT,note TEXT,name TEXT,jour INT,mois INT,annee INT,heure INT,minute INT,isfa INT)",
        );
      },
      version: 2,
    );
  }

  insertNote(MiniCont miniCont) async {
    final Database tdb = await database;
    await tdb.insert(
      "note",
      miniCont.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // await tdb.rawInsert(
    //     "INSERT INTO note(titre,note,name,jour,mois,annee,heure,minute,isfa) VALUES(?,?,?,?,?,?,?,?,?)",
    //     [
    //       miniCont.titre,
    //       miniCont.note,
    //       miniCont.name,
    //       miniCont.j,
    //       miniCont.m,
    //       miniCont.y,
    //       miniCont.heure,
    //       miniCont.minute,
    //       miniCont.isFa
    //     ]);
  }

  updateNote(MiniCont miniCont) async {
    final Database tdb = await database;
    await tdb.update(
      "note",
      miniCont.toMap(),
      where: "id=?",
      whereArgs: [miniCont.id],
    );
  }

  deleteNote(int id) async {
    final Database tdb = await database;
    tdb.delete(
      "note",
      where: "id=?",
      whereArgs: [id],
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
    // if (mesnotes.isEmpty) {
    //   for (MiniCont m in defaultNotes) {
    //     insertNote(m);
    //   }
    //   mesnotes = defaultNotes;
    // }
    //  ON ELEVE LE RETOUR OBLIGATOIRE(POUR NE PAS QUE LES ELEMENTS PAR DEFAULT REAPPARAISSE UNE FOIS SUPPRIMER)

    return mesnotes;
  }

  // List<MiniCont> defaultNotes = [
  //   MiniCont(
  //       "JNRH",
  //       "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       "Richard",
  //       // Color.fromRGBO(100, 12, 5, 0.4),
  //       // Colors.red,
  //       27,
  //       12,
  //       2020,
  //       9,
  //       30,
  //       1),
  //   MiniCont(
  //       "EMM",
  //       "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       "jean",
  //       // Color.fromRGBO(10, 120, 5, 0.4),
  //       // Colors.green,
  //       27,
  //       12,
  //       2020,
  //       9,
  //       30,
  //       0),
  //   MiniCont(
  //       "ENERGIE",
  //       "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       "ange",
  //       // Color.fromRGBO(10, 12, 244, 0.4),
  //       // Colors.blue,
  //       20,
  //       10,
  //       2020,
  //       12,
  //       00,
  //       1),
  //   MiniCont(
  //       titre:  "RH MAG",
  //       note:  "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       name:  "yao",
  //       // Color.fromRGBO(100, 12, 5, 0.4),
  //       // Colors.red,
  //       j:  27,
  //       m:  12,
  //       y:  2020,
  //       heure:  9,
  //       minute:  30,
  //       isFa:  1),
  //   MiniCont(
  //       "CGA",
  //       "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       "Richar",
  //       // Color.fromRGBO(10, 12, 244, 0.4),
  //       // Colors.blue,
  //       28,
  //       12,
  //       2020,
  //       9,
  //       35,
  //       0),
  //   MiniCont(
  //       id: 1,
  //       titre: "MERCI",
  //       note:
  //           "Lorem ipsum dolor sit amet, consectetir adipliscing elit, set do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
  //       name: "jean",
  //       // Color.fromRGBO(10, 120, 5, 0.4),
  //       // Colors.green,
  //       j: 27,
  //       m: 12,
  //       y: 2020,
  //       heure: 9,
  //       minute: 30,
  //       isFa: 1),
  // ];
}
