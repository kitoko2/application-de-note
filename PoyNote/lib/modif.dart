import 'package:Poy_note/ShowDialog/dialog.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:Poy_note/home.dart';
import 'package:Poy_note/notesDatabase.dart';
import "home.dart";
import "package:date_time_format/date_time_format.dart";

class Modif extends StatefulWidget {
  final MiniCont notes;

  Modif({this.notes});

  @override
  _ModifState createState() => _ModifState();
}

class _ModifState extends State<Modif> {
  var newTitre, newNote, newAuteur;

  @override
  void initState() {
    super.initState();
    newTitre = widget.notes.titre;
    newNote = widget.notes.note;
    newAuteur = widget.notes.name;
  }

  String datetoday() {
    DateTime t = DateTime.now();
    return t.format("j M Y  H:i ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        toolbarHeight: 10,
        brightness: Brightness.dark,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Theme.of(context).accentColor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 17,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Modification',
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (newNote.isNotEmpty && newNote != null) {
                          setState(() {
                            MiniCont newCont = MiniCont(
                              id: widget.notes.id,
                              titre: newTitre,
                              note: newNote,
                              name: newAuteur, //pas utiliser ici
                              dateEnr: datetoday(), //avec la date de la modif
                              isFa: widget.notes.isFa,
                            );
                            NotesDataBase.instance.updateNote(newCont);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        } else {
                          runDialog(
                            context,
                            "Erreur d'enregistrement",
                            "Notes Vide",
                            "veiller entrer une note",
                          );
                        }
                      },
                      child: Text("Enregistrer"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            flex: 7,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 500),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: null,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        initialValue: "$newNote",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        cursorHeight: 40,
                        cursorColor: Color.fromRGBO(30, 80, 200, 1),

                        // controller: TextEditingController()..text = "POYO TE SALUT",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (note) {
                          setState(() {
                            newNote = note;
                          });
                        },
                        validator: (s) {
                          if (s.isEmpty || s == null) {
                            return "modification incorrect";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
