import "package:flutter/material.dart";
import "package:animated_text_kit/animated_text_kit.dart";
import "package:Poy_note/ShowDialog/dialogContacter.dart";
import "package:share_plus/share_plus.dart";
import "package:package_info/package_info.dart";
import "package:shared_preferences/shared_preferences.dart";

class Draw extends StatefulWidget {
  final bool langVal;
  Draw(this.langVal);
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: TextLiquidFill(
                      loadDuration: Duration(seconds: 2),
                      waveDuration: Duration(seconds: 1),
                      boxBackgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      waveColor: Colors.white,
                      text: "Options",
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                      boxHeight: 90,
                      boxWidth: 300,
                    ),
                  ),
                  list(
                    Icons.info_rounded,
                    widget.langVal ? "info. developpeur" : "developer info",
                  ),
                  list(
                    Icons.share,
                    widget.langVal ? "Partager" : "Share",
                  ),
                  list(
                    Icons.note,
                    widget.langVal ? "Prise en main" : "Getting started",
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.langVal ? "langue :" : "language :",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _prefs.then((SharedPreferences prefs) {
                              prefs.setBool("isFrench", true);
                            }); //met en francais
                          });
                        },
                        child: Text(widget.langVal ? "francais" : "french"),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _prefs.then((SharedPreferences prefs) {
                              prefs.setBool("isFrench", false);
                            }); //met en anglais
                          });
                        },
                        child: Text(widget.langVal ? "anglais" : "english"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var resultat = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "version : ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${resultat.version}",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget list(IconData icone, String text) {
    return TextButton(
      onPressed: () {
        if (text == "info. developpeur" || text == "developer info") {
          contact(context);
        }
        if (text == "Share" || text == "Partager") {
          Share.share(
            "https://github.com/kitoko2/application-de-note.git",
          ); // send ici le liens de mon appli sur les differents stores
        }
        if (text == "Prise en main" || text == "Getting started") {
          //prise en main
        }
      },
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Icon(
              icone,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
