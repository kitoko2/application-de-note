import "package:flutter/material.dart";

runDialog(
    BuildContext context, String erreur, String message, String correction) {
  showDialog(
    context: context,
    builder: (c) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(30, 30, 30, 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          erreur,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                size: 30,
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  correction,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
