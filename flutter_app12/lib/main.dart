import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_app12/modif.dart';
import 'package:flutter_app12/notesDatabase.dart';
import 'package:flutter_app12/voir.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(30, 80, 200, 1),
      ),
      debugShowCheckedModeBanner: false,
      title: "notes",
      home: MyHomme(),
    );
  }
}

class MyHomme extends StatefulWidget {
  @override
  _MyHommeState createState() => _MyHommeState();
}

List colora = [
  Color(0xff292d32), //Color.fromRGBO(100, 12, 5, 0.4),
  Color(0xff292d32), //Color.fromRGBO(10, 120, 5, 0.4),
];
List colorb = [
  Colors.red,
  Colors.green,
];

class _MyHommeState extends State<MyHomme> {
  List<MiniCont> mesNotes = []; //pour gerer l'actualisation
  List<MiniCont> compteur = []; //pour gerer les id uniques
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        mesNotes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'Activités',
                  style: TextStyle(fontSize: 29, color: Colors.white),
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
                color: Color(0xff292D32),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: FutureBuilder<List<MiniCont>>(
                future: NotesDataBase.instance.notes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    mesNotes = snapshot.data;

                    compteur = mesNotes;

                    return Scrollbar(
                      radius: Radius.circular(30),
                      //juste pour la scrollbar
                      child: GridView.builder(
                        itemCount: mesNotes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width >= 768 ? 4 : 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (BuildContext context, i) {
                          return Hero(
                            tag: mesNotes[i].name,
                            child: Material(
                              color: Colors.transparent,
                              child: Stack(
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
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(30, 80, 200, 1),
                                          // color: Color(0xff292d32),
                                          //car j'ai mis la mm couleur pr les 2
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              // spreadRadius: 2,
                                              blurRadius: 16,
                                              offset: Offset(-6, -6),
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(1),
                                              // spreadRadius: 2,
                                              blurRadius: 16,
                                              offset: Offset(6, 6),
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: mesNotes[i].isFa == 1
                                                  ? colorb[mesNotes[i].isFa]
                                                  : colorb[0],
                                              //si c'est favoris(1)colorb[1]:colorb[0]
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                PopupMenuButton(
                                                  initialValue: 20,
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        child:
                                                            Text("supprimer"),
                                                        value: 0,
                                                      ),
                                                      PopupMenuItem(
                                                        child: Text(
                                                          mesNotes[i].isFa == 1
                                                              ? "désépinglé"
                                                              : "épingler",
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
                                                          content: Text(
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
                                                        if (mesNotes[i].isFa ==
                                                            1) {
                                                          mesNotes[i] =
                                                              MiniCont(
                                                            id: mesNotes[i].id,
                                                            titre: mesNotes[i]
                                                                .titre,
                                                            note: mesNotes[i]
                                                                .note,
                                                            name: mesNotes[i]
                                                                .name,
                                                            j: mesNotes[i].j,
                                                            m: mesNotes[i].m,
                                                            y: mesNotes[i].y,
                                                            heure: mesNotes[i]
                                                                .heure,
                                                            minute: mesNotes[i]
                                                                .minute,
                                                            isFa: 0,
                                                            //0 pour désépingler
                                                          );
                                                          NotesDataBase.instance
                                                              .updateNote(
                                                            mesNotes[i],
                                                          );
                                                          //remplacer dans la base de donner par mesNotes[i] là ou titre=mesNotes[i].titre
                                                          //mais nous avons changer mesNotes[i].isfav qui devient 0(d'esepingler)

                                                        } else {
                                                          //mesNotes[i].isFa==0 donc le faire passer a 1 pour l'epingler;
                                                          mesNotes[i] =
                                                              MiniCont(
                                                            id: mesNotes[i].id,
                                                            titre: mesNotes[i]
                                                                .titre,
                                                            note: mesNotes[i]
                                                                .note,
                                                            name: mesNotes[i]
                                                                .name,
                                                            j: mesNotes[i].j,
                                                            m: mesNotes[i].m,
                                                            y: mesNotes[i].y,
                                                            heure: mesNotes[i]
                                                                .heure,
                                                            minute: mesNotes[i]
                                                                .minute,
                                                            isFa: 1,
                                                          );
                                                          NotesDataBase.instance
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
                                                    mesNotes[i].titre.length >=
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "${mesNotes[i].j}/${mesNotes[i].m}/${mesNotes[i].y}",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                "${mesNotes[i].heure}h ${mesNotes[i].minute}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              child: Text(
                                                mesNotes[i].note,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 0,
                                            child: Text(
                                              mesNotes[i].name.length >= 8
                                                  ? mesNotes[i].nameAb
                                                  : mesNotes[i].name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: mesNotes[i].isFa == 1
                                                    ? colorb[mesNotes[i].isFa]
                                                    : colorb[0],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  mesNotes[i].isFa == 1
                                      ? Positioned(
                                          top: -1,
                                          right: -1,
                                          child: Container(
                                            child: Image.asset("asset/pin.png"),
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            popupNote(
              MiniCont(
                titre: "",
                name: "",
                j: 0,
                m: 0,
                y: 0,
                heure: 0,
                minute: 0,
                isFa: 0,
                //je ne fais pas passer le nom,titre et notre pour qu'ils soient null
              ),
            );
          });
        },
      ),
    );
  }

  popupNote(MiniCont m) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width - 20,
            child: Card(
              // color: Color.fromRGBO(12, 34, 78, 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "titre de la note",
                        ),
                        onChanged: (e) {
                          setState(() {
                            m.titre = e;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "entrer la note",
                        ),
                        onChanged: (n) {
                          setState(() {
                            m.note = n;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "nom de l'auteur",
                        ),
                        onChanged: (n) {
                          setState(() {
                            m.name = n;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // print("${m.titre} ${m.note} ${m.name} voir");
                          Navigator.pop(context);
                          setState(() {
                            if (m.titre != null &&
                                m.note != null &&
                                m.name != null) {
                              //pour un ajout dans la table note de la bd
                              NotesDataBase.instance.insertNote(
                                MiniCont(
                                  id: compteur.isEmpty
                                      ? 1
                                      : (compteur[compteur.length - 1].id) + 1,
                                  titre: m.titre.toUpperCase(),
                                  note: m.note,
                                  name: m.name,
                                  j: datetoday().day,
                                  m: datetoday().month,
                                  y: datetoday().year,
                                  heure: datetoday().hour,
                                  minute: datetoday().minute,
                                  isFa: 0,
                                ),
                              );
                            }
                          });
                        },
                        icon: Icon(Icons.check),
                        label: Text("Valider"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  DateTime datetoday() {
    DateTime t = DateTime.now();
    return t;
  }
}

class MiniCont {
  int id;
  String titre;
  String titreAb;
  String note;
  String name;
  String nameAb;
  // Color a;
  // Color b;
  int j;
  int m;
  int y;
  int heure;
  int minute;
  int isFa;

  MiniCont(
      {int id,
      String titre,
      String note,
      String name,
      int j,
      int m,
      int y,
      int heure,
      int minute,
      int isFa}) {
    if (titre.length >= 7) {
      titreAb = titre.substring(0, 7) + "."; //pour abrerger
    }
    if (name.length >= 8) {
      nameAb = name.substring(0, 8) + '.';
    }
    this.id = id;
    this.titre = titre;
    this.note = note;
    this.name = name;
    // this.a = a;
    // this.b = b;
    this.heure = heure;
    this.minute = minute;
    this.j = j;
    this.m = m;
    this.y = y;
    this.isFa = isFa;
  }

  Map<String, dynamic> toMap() {
    final map = {
      "id": id,
      "titre": titre,
      "note": note,
      "name": name,
      "jour": j,
      "mois": m,
      "annee": y,
      "heure": heure,
      "minute": minute,
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
      j: map["jour"],
      m: map["mois"],
      y: map["annee"],
      heure: map["heure"],
      minute: map["minute"],
      isFa: map["isfa"],
    );
  }
}
