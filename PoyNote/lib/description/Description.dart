import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import "package:google_fonts/google_fonts.dart";

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "suivant",
        child: Icon(
          Icons.arrow_forward,
        ),
        onPressed: () {
          _prefs.then((SharedPreferences prefs) {
            setState(() {
              prefs.setBool("isFirst", false);
            });
          });
          Navigator.pushReplacementNamed(context, "/appli");
        },
      ),
      body: Stack(
        children: [
          Container(
            child: CarouselSlider(
              items: [
                Container(
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.3,
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 35,
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
                            horizontal: 30,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Une appli de note accessible à tous le monde. \nNoté vos idées où que vous soyez avec une simplicité...",
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.3,
                          margin: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 35,
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
                            horizontal: 30,
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
                                '"+" pour ajouter une note, mettre un titre et ensuite entrez votre note',
                                style: GoogleFonts.acme(
                                  color: Colors.white70,
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'appuiyer sur 	"→" pour continuer',
                                style: GoogleFonts.acme(
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
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                pageViewKey: PageStorageKey(1),
                onPageChanged: (index, c) {
                  setState(() {
                    itemCount = index;
                  });
                },
                viewportFraction: 1,
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.of(context).size.width / 2) - 10,
            top: MediaQuery.of(context).size.height - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: itemCount == 0
                        ? Color.fromRGBO(240, 240, 240, 0.9)
                        : Color.fromRGBO(100, 100, 0, 0.4),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: itemCount == 1
                        ? Color.fromRGBO(240, 240, 240, 0.9)
                        : Color.fromRGBO(100, 100, 0, 0.4),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
