import "package:flutter/material.dart";
import "package:animated_text_kit/animated_text_kit.dart";
import "package:Poy_note/ShowDialog/dialogContacter.dart";
import "package:share_plus/share_plus.dart";
import "package:package_info/package_info.dart";

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
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
                  list(Icons.send_rounded, "send note"),
                  list(Icons.info_rounded, "info. developpeur"),
                  list(Icons.share, "Share"),
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
      onPressed: () async {
        if (text == "info. developpeur") {
          contact(context);
        }
        if (text == "Share") {
          await Share.share(
            "https://github.com/kitoko2/application-de-note.git",
          ); // send ici le liens de mon appli sur les differents stores
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
