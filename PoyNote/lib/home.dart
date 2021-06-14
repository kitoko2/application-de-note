import 'dart:async';
import 'package:Poy_note/drawer/endDrawer.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:Poy_note/add.dart';
import 'package:Poy_note/notesDatabase.dart';
import 'package:Poy_note/search.dart';
import 'package:Poy_note/voir.dart';
import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter/services.dart";
// import "package:o_popup/o_popup.dart"; a voir

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      appBar: new AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      endDrawer: Draw(),
      body: Column(
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
                      width: 240,
                      child: TextLiquidFill(
                        waveDuration: Duration(seconds: 1),
                        loadDuration: Duration(seconds: 5),
                        boxHeight: 58,
                        boxBackgroundColor: Theme.of(context).accentColor,
                        waveColor: Colors.white,
                        text: "Activités",
                        textStyle: TextStyle(
                          fontSize: 29,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: IconButton(
                              tooltip:
                                  "voir le nombre d'elements de votre bloc note",
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Search(mesNotes: mesNotes);
                                    },
                                  ),
                                );
                              }),
                        ),
                        Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              tooltip: "Options",
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white70,
                                size: 32,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                            );
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
                top: 35,
                bottom: 20,
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
                builder: (context, AsyncSnapshot<List<MiniCont>> snapshot) {
                  if (snapshot.hasData) {
                    mesNotes = snapshot.data;

                    compteur = mesNotes;

                    return mesNotes.isNotEmpty
                        ? Scrollbar(
                            radius: Radius.circular(30),
                            //juste pour la scrollbar
                            child: GridView.builder(
                              itemCount: mesNotes.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width >= 768
                                        ? 4
                                        : 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 20,
                              ),
                              itemBuilder: (BuildContext context, i) {
                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                            return Voir(
                                              notes: mesNotes[i],
                                            );
                                          }),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Color(0xff1f1d2b),
                                            // color: Color(0xff292d32)
                                            //car j'ai mis la mm couleur pr les 2
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              // BoxShadow(
                                              //   color: Colors.white
                                              //       .withOpacity(0.1),
                                              //   blurRadius: 5,
                                              //   offset: Offset(-3, -3),
                                              // ),
                                              BoxShadow(
                                                color:
                                                    Colors.black.withOpacity(1),
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
                                                color: mesNotes[i].isFa == 1
                                                    ? colorb[mesNotes[i].isFa]
                                                        .withOpacity(0.5)
                                                    : colorb[0]
                                                        .withOpacity(0.5),
                                                //si c'est favoris(1)colorb[1]:colorb[0]
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(10),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  PopupMenuButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    color: Color(0xff292D32),
                                                    iconSize: 21,
                                                    initialValue: 20,
                                                    itemBuilder: (context) {
                                                      return [
                                                        PopupMenuItem(
                                                          child: Text(
                                                            "supprimer",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          value: 0,
                                                        ),
                                                        PopupMenuItem(
                                                          child: Text(
                                                            mesNotes[i].isFa ==
                                                                    1
                                                                ? "désépinglé"
                                                                : "épingler",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          value: 1,
                                                        ),
                                                      ];
                                                    },
                                                    onSelected: (int value) {
                                                      if (value == 0) {
                                                        setState(() {
                                                          SnackBar me =
                                                              new SnackBar(
                                                            content: mesNotes[i]
                                                                        .titre
                                                                        .length >=
                                                                    7
                                                                ? Text(
                                                                    "${mesNotes[i].titreAb} à été supprimer avec succès",
                                                                  )
                                                                : Text(
                                                                    "${mesNotes[i].titre} à été supprimer avec succès",
                                                                  ),
                                                            duration: Duration(
                                                              milliseconds: 200,
                                                            ),
                                                          );
                                                          Scaffold.of(context)
                                                              .showSnackBar(me);
                                                          NotesDataBase.instance
                                                              .deleteNote(
                                                            mesNotes[i].id,
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
                                                              id: mesNotes[i]
                                                                  .id,
                                                              titre: mesNotes[i]
                                                                  .titre,
                                                              note: mesNotes[i]
                                                                  .note,
                                                              name: mesNotes[i]
                                                                  .name,
                                                              dateEnr:
                                                                  mesNotes[i]
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
                                                              id: mesNotes[i]
                                                                  .id,
                                                              titre: mesNotes[i]
                                                                  .titre,
                                                              note: mesNotes[i]
                                                                  .note,
                                                              name: mesNotes[i]
                                                                  .name,
                                                              dateEnr:
                                                                  mesNotes[i]
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
                                                  Center(
                                                    child: Text(
                                                      mesNotes[i]
                                                                  .titre
                                                                  .length >=
                                                              7
                                                          ? mesNotes[i]
                                                              .titreAb
                                                              .toUpperCase()
                                                          : mesNotes[i]
                                                              .titre
                                                              .toUpperCase(),
                                                      //pour gerer les abreger si >=7
                                                      style: TextStyle(
                                                        color: Colors.white,
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
                                                padding: EdgeInsets.symmetric(
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
                                    mesNotes[i].isFa == 1
                                        ? Positioned(
                                            top: -3,
                                            right: -3,
                                            child: Container(
                                              child:
                                                  Image.asset("asset/pin.png"),
                                              width: 19,
                                              height: 19,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "« No Element Found Please Add Note with '+' »",
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
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "add note",
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNote(
                  compteur: compteur,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {
        mesNotes; // actualiser
      });
    });
  }
}

class MiniCont {
  int id;
  String titre;
  String titreAb;
  String note;
  String name;
  String nameAb;
  String dateEnr;
  int isFa;

  MiniCont(
      {int id,
      String titre,
      String note,
      String name,
      String dateEnr,
      int isFa}) {
    if (titre.length >= 7) {
      titreAb = titre.substring(0, 7) + "."; //pour abrerger
    }
    if (name.length >= 8) {
      nameAb = name.substring(0, 8) + '.';
    } // NB: name(auteur) n'est plus utiliser dans mon appli pour raison d'optimisation
    this.id = id;
    this.titre = titre;
    this.note = note;
    this.name = name;
    // this.a = a;
    // this.b = b;
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
