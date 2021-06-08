import "package:flutter/material.dart";
import 'package:flutter_app12/main.dart';
import 'package:flutter_app12/modif.dart';

class Voir extends StatefulWidget {
  final MiniCont notes;
  GlobalKey ky;
  Voir({this.notes, this.ky});
  @override
  _VoirState createState() => _VoirState();
}

class _VoirState extends State<Voir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: new AppBar(
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            child: Material(
              color: Colors.transparent,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.notes.titre.length >= 7
                                  ? '${widget.notes.titreAb}'
                                  : '${widget.notes.titre}',
                              // abreger pour que je puisse mettre l'icone modifier
                              style:
                                  TextStyle(fontSize: 29, color: Colors.white),
                            ),
                            Text(
                              widget.notes.name.length >= 8
                                  ? "auteur: ${widget.notes.nameAb}"
                                  : "auteur: ${widget.notes.name}",
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Modif(
                                    notes: widget.notes,
                                    ky: widget.ky,
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            flex: 1,
          ),
          Flexible(
            child: Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 1.5,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "${widget.notes.note}",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
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
