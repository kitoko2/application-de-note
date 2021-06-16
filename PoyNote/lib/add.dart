import 'package:Poy_note/ShowDialog/dialog.dart';
import "package:flutter/material.dart";
import 'package:Poy_note/home.dart';
import 'package:Poy_note/notesDatabase.dart';
import "package:date_time_format/date_time_format.dart";

class AddNote extends StatefulWidget {
  final List<MiniCont> compteur;
  final bool langVal;
  AddNote({this.compteur, this.langVal});
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var titre = "";
  var auteur = "";
  var note = "";
  String datetoday() {
    DateTime t = DateTime.now();
    return t.format("j M Y  H:i ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        brightness:
            Brightness.dark, //pour la couleur des icons(batteries...) blanche
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              color: Theme.of(context).accentColor,
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
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      height: 95,
                      child: Center(
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
                            hintText: widget.langVal
                                ? "Entrer titre..."
                                : "Enter title...",
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (note != "" && titre != "") {
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
                              name: auteur, //n'est pas utiliser ici
                              dateEnr: datetoday(), //pour la date d'aujourd'hui
                              isFa: 0,
                            ),
                          );
                        });
                        Navigator.pop(context);
                      } else {
                        runDialog(
                          context,
                          widget.langVal
                              ? "Erreur d'enregistrement"
                              : "Registration error",
                          widget.langVal
                              ? "Champ Requis Vide"
                              : "Required Field Empty",
                          widget.langVal
                              ? "veiller entrer le titre et la note"
                              : "make sure you enter the title and the note",
                        );
                        //pour anglais et francais
                      }
                    },
                    child: Text(widget.langVal ? "Enregistrer" : "save"),
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
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          hintText: widget.langVal
                              ? "Entrer votre note ..."
                              : "Enter note ...",
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
