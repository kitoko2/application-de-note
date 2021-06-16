import "package:flutter/material.dart";
import 'package:Poy_note/home.dart';
import 'package:Poy_note/modif.dart';

class Voir extends StatefulWidget {
  final MiniCont notes;
  final bool langVal;
  Voir({this.notes, this.langVal});
  @override
  _VoirState createState() => _VoirState();
}

class _VoirState extends State<Voir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        toolbarHeight: 10,
        brightness: Brightness.dark,
      ),
      bottomSheet: BottomSheet(
        builder: (context) {
          return Container(
            color: Color.fromRGBO(30, 30, 30, 1),
            height: 30,
            width: double.infinity,
            child: Center(
              child: Text(
                widget.langVal
                    ? "dernière modification : ${widget.notes.dateEnr}"
                    : "Last modification : ${widget.notes.dateEnr}",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        },
        onClosing: () {},
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
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width - 190,
                            child: Text(
                              '${widget.notes.titre}',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
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
                                    langVal: widget.langVal,
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
