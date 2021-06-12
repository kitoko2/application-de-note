import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

void lauchWhatssap({@required number, @required message}) async {
  String url = "https://wa.me/$number?text=$message";

  await canLaunch(url) ? launch(url) : print("pas de connection");
}

void lauchTelephone({@required mail, @required message}) async {
  var url = "mailto:$mail?subject=$message";
  await canLaunch(url) ? launch("$url") : print("no connection");
}

contact(BuildContext context) {
  showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(30, 80, 200, 0.9),
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
          "@copyright by Josias Ezechiel and Mo_smad\n\nNous contacter : ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              lauchTelephone(
                mail: "Dogbo804@gmail.com",
                message: "a propos de l'appli de note!",
              );
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              lauchWhatssap(
                number: "22543992749",
                message: "hello ezechiel!",
              ); //aller sur whatssap
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
