import "package:flutter/material.dart";
import "package:animated_text_kit/animated_text_kit.dart";
import "package:Poy_note/ShowDialog/dialogContacter.dart";

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
        child: ListView(
          children: [
            DrawerHeader(
              child: TextLiquidFill(
                loadDuration: Duration(seconds: 2),
                boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            list(Icons.share, "Share..."),
            list(Icons.send_rounded, "send note..."),
            list(Icons.receipt_rounded, "receveid note..."),
            list(Icons.info_rounded, "info. developpeur"),
          ],
        ),
      ),
    );
  }

  Widget list(IconData icone, String text) {
    return TextButton(
      onPressed: () {
        if (text == "info. developpeur") {
          contact(context);
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
            SizedBox(width: 30),
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
