import "package:flutter/material.dart";
import "package:local_auth/local_auth.dart";
import 'package:flutter/services.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  LocalAuthentication auth = LocalAuthentication();
  String authorized = "Non Autorisé";
  Future<void> authentification() async {
    bool result;
    try {
      result = await auth.authenticate(
          localizedReason: "poyo is good",
          biometricOnly: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      authorized = result ? "Autorisé" : "Non Autorisé";
    });
    if (authorized == "Autorisé") {
      Navigator.pushReplacementNamed(context, "/appli");
      //aller a la page homme si c'est bien authentifier
    }
  }

  @override
  void initState() {
    super.initState();
    authentification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("authentification"),
      ),
      body: Container(),
    );
  }
}
