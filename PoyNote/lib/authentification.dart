import 'dart:async';
import "package:flutter/material.dart";
import 'package:local_auth/auth_strings.dart';
import "package:local_auth/local_auth.dart";
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  LocalAuthentication auth = LocalAuthentication();
  String text = "";
  bool isLock = false;
  Future<void> authentification() async {
    bool result;
    setState(() {
      isLock = false; // essaye de ne pas setsate
    });

    try {
      result = await auth.authenticate(
        androidAuthStrings: AndroidAuthMessages(
          biometricHint: "",
          signInTitle: "Empreinte",
        ),
        localizedReason: "verification d'identité",
        biometricOnly: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
      if (e.message == "No biometrics enrolled on this device." ||
          e.message == "Required security features not enabled") {
        _prefs.then((SharedPreferences prefs) {
          prefs.setBool("isSecure", false);
        });
        Navigator.pushReplacementNamed(context, "/appli");
        // en cas d'exeception c'est que l'utilisateur a supprimer ces empreintes dans les parametres de son
        // telephone donc on vas directement sur son menu Home et on change la valeur de secure a false;
      } else if (e.code == "LockedOut") {
        result = false;

        setState(() {
          isLock = true;
        });

        print("empreinte verrouiller");
      } else if (e.code == "PermanentlyLockedOut") {
        result = false;
        setState(() {
          isLock = true;
        });

        print("trop d'essaies empreinte desactié");
        // si le gars a fait trop d'essaie
      } else {}
    }

    if (!mounted) return;

    if (result != null) {
      if (result == true) {
        Navigator.pushReplacementNamed(context, "/appli");
        //aller a la page homme si c'est bien authentifier
      }
    }
  }

  @override
  void initState() {
    super.initState();
    authentification();

    Timer.periodic(Duration(seconds: 10), (timer) {
      if (isLock) {
        authentification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: Text("authentification"),
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      // ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: isLock
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("asset/errorEmpreinte.png"),
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      "empreinte verouillés réessayer plus tard",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Text(""),
              ),
      ),
    );
  }
}
