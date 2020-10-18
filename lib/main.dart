import 'package:flutter/material.dart';
import 'package:GameChallenge/Menu.dart';
import 'package:GameChallenge/About.dart';
import 'package:GameChallenge/Game/TicTacToe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Menu(),
      routes: {
        'about': (BuildContext context) => About(),
        'tictactoe': (BuildContext context) => TicTacToe(),
      },
    );
  }
}
