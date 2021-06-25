import 'dart:async';
import 'package:Poy_note/drawer/endDrawer.dart';
import 'package:Poy_note/search.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:Poy_note/add.dart';
import 'package:Poy_note/notesDatabase.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:Poy_note/voir.dart';
import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter/services.dart";

class MyHomme extends StatefulWidget {
  @override
  _MyHommeState createState() => _MyHommeState();
}

List colora = [
  Color(0xff292d32), //Color.fromRGBO(100, 12, 5, 0.4),
  Color(0xff292d32), //Color.fromRGBO(10, 120, 5, 0.4),
];
List colorb = [
  Color(0xff2f556b),
  Colors.red,
];

class _MyHommeState extends State<MyHomme> {
  List<MiniCont> mesNotes = []; //pour gerer l'actualisation
  List<MiniCont> compteur = []; //pour gerer les id uniques

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> isFrench;
  bool langVal = true; //par defaut francais

  @override
  void initState() {
    super.initState();
    isFrench = _prefs.then((SharedPreferences prefs) {
      langVal = prefs.getBool("isFrench") ?? true;
      return prefs.getBool("isFrench") ?? true;
    });

    Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {
        mesNotes; // actualiser
        isFrench = _prefs.then((SharedPreferences prefs) {
          langVal = prefs.getBool("isFrench") ?? true;
          return prefs.getBool("isFrench") ?? true;
        });
        // si la cle isFrench contient null par default(au premier lancement) langVal =true (francais) sinon langVal = ce que contient la cle
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size largeur = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      appBar: new AppBar(
        brightness: Brightness.dark, //pour voir les icones du haut du telephone
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      endDrawer: Draw(langVal),
      body: FutureBuilder(
        future: isFrench,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: largeur.width <= 320 ? 160 : 230,
                            child: largeur.width <= 320
                                ? Text(
                                    langVal ? "Activités" : "activities",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  )
                                : TextLiquidFill(
                                    waveDuration: Duration(seconds: 1),
                                    loadDuration: Duration(seconds: 5),
                                    boxHeight: 58,
                                    boxBackgroundColor:
                                        Theme.of(context).accentColor,
                                    waveColor: Colors.white,
                                    text: langVal ? "Activités" : "activities",
                                    textStyle: TextStyle(
                                      fontSize: 29,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                tooltip: langVal
                                    ? "voir le nombre d'elements de votre bloc note"
                                    : "see the number of elements in your notepad",
                                icon: Icon(
                                  Icons.search,
                                  size: largeur.width <= 320 ? 20 : 30,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Search(
                                          mesNotes: mesNotes,
                                          langVal: langVal,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                tooltip: "Options",
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white70,
                                  size: largeur.width <= 320 ? 20 : 30,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 25,
                      left: 25,
                      top: 30,
                      bottom: 10,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: FutureBuilder<List<MiniCont>>(
                      future: NotesDataBase.instance.notes(),
                      builder:
                          (context, AsyncSnapshot<List<MiniCont>> snapshot) {
                        if (snapshot.hasData) {
                          mesNotes = snapshot.data;

                          compteur = mesNotes;

                          return mesNotes.isNotEmpty
                              ? Scrollbar(
                                  radius: Radius.circular(30),
                                  //juste pour la scrollbar
                                  child: GridView.builder(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      bottom: 20,
                                      left: 7,
                                      right: 7,
                                    ),
                                    itemCount: mesNotes.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent:
                                          largeur.width <= 320 ? 130 : 172,
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width >=
                                                  768
                                              ? 4
                                              : 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 20,
                                    ),
                                    itemBuilder: (BuildContext context, i) {
                                      return Hero(
                                        tag: "hero $i",
                                        child: Material(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                                  return Voir(
                                                    notes: mesNotes[i],
                                                    langVal: langVal,
                                                    indexTag: i,
                                                  );
                                                }),
                                              );
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff1f1d2b),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(1),
                                                      blurRadius: 5,
                                                      offset: Offset(3, 3),
                                                    ),
                                                  ]),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: mesNotes[i].isFa ==
                                                              1
                                                          ? colorb[mesNotes[i]
                                                                  .isFa]
                                                              .withOpacity(0.5)
                                                          : colorb[0]
                                                              .withOpacity(0.5),
                                                      //si c'est favoris(1)colorb[1]:colorb[0]
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        PopupMenuButton(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          color:
                                                              Color(0xff292D32),
                                                          iconSize: 21,
                                                          initialValue: 20,
                                                          itemBuilder:
                                                              (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                child: Text(
                                                                  langVal
                                                                      ? "supprimer"
                                                                      : "delete",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                value: 0,
                                                              ),
                                                              PopupMenuItem(
                                                                child: Text(
                                                                  mesNotes[i].isFa ==
                                                                          1
                                                                      ? langVal
                                                                          ? "désépinglé"
                                                                          : "unpinned"
                                                                      : langVal
                                                                          ? "épingler"
                                                                          : "pin",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                value: 1,
                                                              ),
                                                            ];
                                                          },
                                                          onSelected:
                                                              (int value) {
                                                            if (value == 0) {
                                                              setState(() {
                                                                SnackBar me =
                                                                    new SnackBar(
                                                                  content: Text(
                                                                    langVal
                                                                        ? "votre note à été supprimer avec succès"
                                                                        : "your note has been successfully deleted",
                                                                    //francais/anglais
                                                                  ),
                                                                  duration:
                                                                      Duration(
                                                                    milliseconds:
                                                                        200,
                                                                  ),
                                                                );

                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        me);
                                                                NotesDataBase
                                                                    .instance
                                                                    .deleteNote(
                                                                  mesNotes[i]
                                                                      .id,
                                                                );
                                                              });
                                                            }
                                                            if (value == 1) {
                                                              //désepingler ou épingler
                                                              setState(() {
                                                                if (mesNotes[i]
                                                                        .isFa ==
                                                                    1) {
                                                                  mesNotes[i] =
                                                                      MiniCont(
                                                                    id: mesNotes[
                                                                            i]
                                                                        .id,
                                                                    titre: mesNotes[
                                                                            i]
                                                                        .titre,
                                                                    note: mesNotes[
                                                                            i]
                                                                        .note,
                                                                    name: mesNotes[
                                                                            i]
                                                                        .name,
                                                                    dateEnr: mesNotes[
                                                                            i]
                                                                        .dateEnr,
                                                                    isFa: 0,
                                                                    //0 pour désépingler
                                                                  );
                                                                  NotesDataBase
                                                                      .instance
                                                                      .updateNote(
                                                                    mesNotes[i],
                                                                  );
                                                                  //remplacer dans la base de donner par mesNotes[i] là ou titre=mesNotes[i].titre
                                                                  //mais nous avons changer mesNotes[i].isfav qui devient 0(d'esepingler)

                                                                } else {
                                                                  //mesNotes[i].isFa==0 donc le faire passer a 1 pour l'epingler;
                                                                  mesNotes[i] =
                                                                      MiniCont(
                                                                    id: mesNotes[
                                                                            i]
                                                                        .id,
                                                                    titre: mesNotes[
                                                                            i]
                                                                        .titre,
                                                                    note: mesNotes[
                                                                            i]
                                                                        .note,
                                                                    name: mesNotes[
                                                                            i]
                                                                        .name,
                                                                    dateEnr: mesNotes[
                                                                            i]
                                                                        .dateEnr,
                                                                    isFa: 1,
                                                                  );
                                                                  NotesDataBase
                                                                      .instance
                                                                      .updateNote(
                                                                    mesNotes[i],
                                                                  );
                                                                }
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        //a terminer
                                                        Container(
                                                          width: 50,
                                                          height: 18,
                                                          child: Center(
                                                            child: Text(
                                                              mesNotes[i].titre,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    "${mesNotes[i].dateEnr}",
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Flexible(
                                                    flex: 2,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 4,
                                                      ),
                                                      child: Text(
                                                        mesNotes[i].note,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    langVal
                                        ? "« Aucun Elément trouvé Veuillez Ajouter une note avec '+' »"
                                        : "« No Element Found Please Add Note with '+' »",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: langVal ? "ajout note" : "add note",
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNote(
                  compteur: compteur,
                  langVal: langVal,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MiniCont {
  int id;
  String titre;
  String note;
  String name;
  String dateEnr;
  int isFa;

  MiniCont(
      {int id,
      String titre,
      String note,
      String name,
      String dateEnr,
      int isFa}) {
    this.id = id;
    this.titre = titre;
    this.note = note;
    this.name = name;
    this.dateEnr = dateEnr;
    this.isFa = isFa;
  }

  Map<String, dynamic> toMap() {
    final map = {
      "id": id,
      "titre": titre,
      "note": note,
      "name": name,
      "dateEnr": dateEnr,
      "isfa": isFa
    };
    return map;
  }

  factory MiniCont.fromMap(Map<String, dynamic> map) {
    return MiniCont(
      id: map["id"],
      titre: map["titre"],
      note: map["note"],
      name: map["name"],
      dateEnr: map["dateEnr"],
      isFa: map["isfa"],
    );
  }
}
