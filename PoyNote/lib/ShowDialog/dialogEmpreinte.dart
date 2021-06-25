import "package:flutter/material.dart";

dialogEmmpreinte(BuildContext context, String error) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        children: [
          Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        ],
      );
    },
  );
}
