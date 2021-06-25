import "package:flutter/material.dart";
import 'package:Poy_note/home.dart';

class Search extends StatefulWidget {
  final List<MiniCont> mesNotes;
  final bool langVal;
  Search({this.mesNotes, this.langVal});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<MiniCont> resultList = [];
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _editingController.addListener(() {
      searchResult();
    });
  }

  searchResult() {
    List<MiniCont> result = [];

    if (_editingController.text != "") {
      for (var container in widget.mesNotes) {
        if (container.titre.contains(_editingController.text.toUpperCase())) {
          setState(() {
            result.add(container);
          });
        } else {
          //
        }
      }
    } else {
      setState(() {
        result.clear();
      });
    }

    return result.length;
  }

  List colorb = [
    Colors.red,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    Size largeur = MediaQuery.of(context).size;
    if (resultList.isEmpty) {
      resultList = widget.mesNotes;
    }

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // pour eviter le redimensionnement quand on veut ecrire
      appBar: new AppBar(
        brightness: Brightness.dark,
        toolbarHeight: largeur.width <= 360 ? 0 : 10,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Theme.of(context).accentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 17,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Text(
                      widget.langVal ? "Recherche" : "Search :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: largeur.width <= 320 ? 25 : 29,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    widget.langVal
                        ? "vous avez ${searchResult()} éléments"
                        : "you have ${searchResult()} items",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.5,
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: TextFormField(
              autofocus: true,
              textAlign: TextAlign.center,
              controller: _editingController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: widget.langVal
                    ? "entrer le titre a rechercher"
                    : "enter the title to search",
                hintStyle: TextStyle(
                  color: Colors.white12,
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Text(
                searchResult() != 0
                    ? widget.langVal
                        ? 'vous avez ${searchResult()} éléments Contenant "${_editingController.text}"'
                        : 'you have ${searchResult()} elements containing "${_editingController.text}"'
                    : widget.langVal
                        ? 'aucun élement trouvé'
                        : 'No found element',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            flex: 7,
          ),
        ],
      ),
    );
  }
}
