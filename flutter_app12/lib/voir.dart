import "package:flutter/material.dart";
import 'package:flutter_app12/main.dart';

class Voir extends StatefulWidget {
  final MiniCont notes;
  Voir({this.notes});
  @override
  _VoirState createState() => _VoirState();
}

class _VoirState extends State<Voir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Hero(
        tag: widget.notes.name,
        child: Column(
          children: [
            Flexible(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.notes.titre.length >= 7
                                    ? '${widget.notes.titreAb}'
                                    : '${widget.notes.titre}',
                                // abreger pour que je puisse mettre l'icone modifier
                                style: TextStyle(
                                    fontSize: 29, color: Colors.white),
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
                              Icons.arrow_upward,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {},
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff292D32),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "${widget.notes.note}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              flex: 7,
            ),
          ],
        ),
      ),
    );
  }
}
