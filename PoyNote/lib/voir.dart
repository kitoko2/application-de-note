import "package:flutter/material.dart";
import 'package:Poy_note/home.dart';
import 'package:Poy_note/modif.dart';

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
                color: Theme.of(context).accentColor,
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
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.notes.titre.length >= 7
                                    ? '${widget.notes.titreAb}'
                                    : '${widget.notes.titre}',
                                // abreger pour que je puisse mettre l'icone modifier
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
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
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 1.5,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
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
