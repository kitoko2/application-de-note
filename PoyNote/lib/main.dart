import 'dart:async';

import 'package:Poy_note/authentification.dart';
import 'package:Poy_note/home.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:Poy_note/description/Description.dart';
import "package:shared_preferences/shared_preferences.dart";

void main(List<String> args) {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color.fromRGBO(30, 80, 200, 1),
        appBarTheme: AppBarTheme(elevation: 0),
        primaryColor: Color.fromRGBO(30, 80, 200, 1),
        scaffoldBackgroundColor:
            Color.fromRGBO(30, 30, 30, 1), // Color.fromRGBO(30, 80, 200, 1),
      ),
      debugShowCheckedModeBanner: false,
      title: "PoyNote",
      home: Splash(),
      routes: {
        "/appli": (BuildContext context) => MyHomme(),
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> isSecure; // si la securité est activé
  Future<bool> isFirst;
  bool first;
  bool valSecure;

  @override
  void initState() {
    super.initState();
    isFirst = _prefs.then((SharedPreferences prefs) {
      first = prefs.getBool("isFirst") ?? true;
      return prefs.getBool("isFirst") ?? true;
    });

    isSecure = _prefs.then((SharedPreferences prefs) {
      valSecure = prefs.getBool("isSecure") ?? false;
      return prefs.getBool("isSecure") ?? false; // pas securiser par default
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirst,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SplashScreenView(
            navigateRoute: first
                ? Description()
                : valSecure
                    ? Authentification()
                    : MyHomme(),
            duration: 4100,
            imageSize: 200,
            text: "Poyo Note",
            textType: TextType.ColorizeAnimationText,
            textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            colors: [
              Colors.orange,
              Colors.yellow,
              Colors.white,
              Colors.teal,
              Colors.yellow,
            ],
            imageSrc: "asset/SplashScreen/splashScreen (1).png",
            backgroundColor: Theme.of(context).accentColor,
          );
        } else {
          return Scaffold(
            body: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
