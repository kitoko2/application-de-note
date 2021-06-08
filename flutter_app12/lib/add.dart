import "package:flutter/material.dart";
import 'package:flutter_app12/main.dart';
import 'package:flutter_app12/notesDatabase.dart';

class AddNote extends StatefulWidget {
  final List<MiniCont> compteur;
  AddNote({this.compteur});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var titre = "";
  var auteur = "";
  var note = "";
  DateTime datetoday() {
    DateTime t = DateTime.now();
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
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
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      height: 70,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (t) {
                          setState(() {
                            titre = t;
                          });
                        },
                        cursorHeight: 35,
                        decoration: InputDecoration(
                          hintText: "Titre",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 29,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (note != "" && auteur != "" && titre != "") {
                        setState(() {
                          NotesDataBase.instance.insertNote(
                            MiniCont(
                              id: widget.compteur.isEmpty
                                  ? 1
                                  : (widget.compteur[widget.compteur.length - 1]
                                          .id) +
                                      1,
                              titre: titre.toUpperCase(),
                              note: note,
                              name: auteur,
                              j: datetoday().day,
                              m: datetoday().month,
                              y: datetoday().year,
                              heure: datetoday().hour,
                              minute: datetoday().minute,
                              isFa: 0,
                            ),
                          );
                        });
                        Navigator.pop(context);
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    SizedBox(height: 10),
                                    Center(
                                      child: Text("Champ Requis Vide"),
                                    ),
                                    Center(
                                      child: Text(
                                        "veiller remplir tous les champs",
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
            flex: 1,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      color: Theme.of(context).accentColor,
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      height: 70,
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                        cursorHeight: 25,
                        onChanged: (a) {
                          setState(() {
                            auteur = a;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Auteur",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 19,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 1.5,
                      ),
                      child: TextFormField(
                        maxLines: null,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                        onChanged: (n) {
                          setState(() {
                            note = n;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Entrez votre note ...",
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 19,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
