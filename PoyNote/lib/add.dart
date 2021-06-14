import 'package:Poy_note/ShowDialog/dialog.dart';
import "package:flutter/material.dart";
import 'package:Poy_note/home.dart';
import 'package:Poy_note/notesDatabase.dart';
import "package:date_time_format/date_time_format.dart";

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
                          "Erreur d'enregistrement",
                          "Champ Requis Vide",
                          "veiller entrer le titre et la note",
                        );
                        // showDialog(
                        //   context: context,
                        //   builder: (c) {
                        //     return AlertDialog(
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       title: Text("Erreur d'enregistrement"),
                        //       content: Container(
                        //         height: 100,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           children: [
                        //             Icon(
                        //               Icons.warning,
                        //               size: 30,
                        //               color: Colors.red,
                        //             ),
                        //             SizedBox(height: 10),
                        //             Center(
                        //               child: Text("Champ Requis Vide"),
                        //             ),
                        //             Center(
                        //               child: Text(
                        //                 "veiller entrer le titre et la note",
                        //                 style: TextStyle(
                        //                   color: Colors.red,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // );
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
