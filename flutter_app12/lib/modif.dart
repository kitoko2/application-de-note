import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_app12/main.dart';
import 'package:flutter_app12/notesDatabase.dart';
import "main.dart";

class Modif extends StatefulWidget {
  // final titre;
  // final note;
  // final auteur;
  MiniCont notes;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292d32),
      appBar: new AppBar(
        title: Text("Modification"),
        actions: [
          ElevatedButton(
            onPressed: () {
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
              });
            },
            child: Text("Enr. modification"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "MODIFIER TRITRE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "police1",
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              TextFormField(
                cursorColor: Colors.white,

                initialValue: "$newTitre",
                // controller: TextEditingController()..text = "POYO TE SALUT",
                decoration: InputDecoration(),
                onChanged: (titre) {
                  setState(() {
                    newTitre = titre;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "MODIFIER NOTE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "police1",
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              TextFormField(
                initialValue: "$newNote",
                decoration: InputDecoration(),
                onChanged: (note) {
                  setState(() {
                    newNote = note;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "MODIFIER AUTEUR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "police1",
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              TextFormField(
                initialValue: "$newAuteur",
                decoration: InputDecoration(),
                onChanged: (auteur) {
                  setState(() {
                    newAuteur = auteur;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
