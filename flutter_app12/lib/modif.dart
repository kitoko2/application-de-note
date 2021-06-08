import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_app12/main.dart';
import 'package:flutter_app12/notesDatabase.dart';
import "main.dart";

class Modif extends StatefulWidget {
  // final titre;
  // final note;
  // final auteur;
  MiniCont notes;
  GlobalKey ky;
  Modif({this.notes, this.ky});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        toolbarHeight: 10,
        elevation: 0,
        actions: [],
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Color.fromRGBO(30, 80, 200, 1),
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
                      onPressed: () {
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
                              name: newAuteur,
                              j: widget.notes.j,
                              m: widget.notes.m,
                              y: widget.notes.y,
                              heure: widget.notes.heure,
                              minute: widget.notes.minute,
                              isFa: widget.notes.isFa,
                            );
                            NotesDataBase.instance.updateNote(newCont);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                          // SnackBar my = new SnackBar(
                          //   content: Text("modification de la note effectuer"),
                          // );
                          // Scaffold.of(context).showSnackBar(my); a voir...
                        } else {
                          showDialog(
                            context: context,
                            builder: (c) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text("Erreur d'enregistrement"),
                                content: Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      SizedBox(height: 20),
                                      Center(
                                        child: Text("Notes Vide"),
                                      ),
                                      Center(
                                        child: Text(
                                          "veiller entrer une note",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 1.5,
                        ),
                        child: TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          initialValue: "$newNote",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
