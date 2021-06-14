import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

void lauchWhatssap({@required number, @required message}) async {
  String url = "https://wa.me/$number?text=$message";

  await canLaunch(url) ? launch(url) : print("pas de connection");
}

void lauchMail({@required mail, @required message}) async {
  var url = "mailto:$mail?subject=$message";
  await canLaunch(url) ? launch("$url") : print("pas de connection");
}

contact(BuildContext context) {
  showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(30, 30, 30, 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          "Information développeur",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        content: Text(
          "@copyright by Josias Ezechiel\nNous contacter : ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              lauchMail(
                mail: "Dogbo804@gmail.com",
                message: "A propos de l'appli de note!",
              );
              Navigator.pop(context);
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    child: Image.asset(
                      "asset/gmail.png",
                    ),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Mail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              lauchWhatssap(
                number: "22543992749",
                message: "hello ezechiel! c'est à propos de l'appli de note",
              ); //aller sur whatssap
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    child: Image.asset("asset/wha1.png"),
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'whatsapp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
