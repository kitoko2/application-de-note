import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriseEnMain extends StatefulWidget {
  final bool langVal;
  PriseEnMain(this.langVal);
  @override
  _PriseEnMainState createState() => _PriseEnMainState();
}

class _PriseEnMainState extends State<PriseEnMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.5),
      appBar: new AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 17,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.langVal ? "Prise en main" : "Getting started"),
        centerTitle: true,
      ),
      body: Scrollbar(
        radius: Radius.circular(20),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("asset/presentation1.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                widget.langVal
                                    ? "Une appli de note accessible à tous le monde. \nNoté vos idées où que vous soyez avec une simplicité..."
                                    : "A note app accessible to everyone. \nJot down your ideas wherever you are with ease ...",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white70,
                                  fontSize: 19,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("asset/presentation2.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "• Description",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white70,
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                widget.langVal
                                    ? '"+" pour ajouter une note, mettre un titre et ensuite entrez votre note'
                                    : '"+" to add a note, put a title and then enter your note ',
                                style: GoogleFonts.acme(
                                  color: Colors.white70,
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
