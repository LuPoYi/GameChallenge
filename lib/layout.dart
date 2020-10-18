import 'package:flutter/material.dart';

Widget buildAppBar(BuildContext context, String gameTitle,
    [Function onPressdFunction]) {
  return AppBar(
    // backgroundColor: Color(0xFF2C6171),
    title: Text(
      gameTitle,
      style: TextStyle(fontSize: 25, fontFamily: 'tahoma'),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.add_alert),
        onPressed: () {
          onPressdFunction();
        },
      )
    ],
  );
}
