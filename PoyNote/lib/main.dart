import 'package:Poy_note/home.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main(List<String> args) {
  runApp(MyApp());
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
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MyHomme(),
      duration: 4000,
      imageSize: 200,
      text: "Poyo Note",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 18.0,
      ),
      colors: [
        Theme.of(context).scaffoldBackgroundColor,
        Colors.black,
        Colors.white,
        Colors.teal,
        Colors.yellow,
      ],
      imageSrc: "asset/SplashScreen/splashScreen (1).png",
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
