import 'package:flutter/material.dart';
import 'package:GameChallenge/Menu.dart';
import 'package:GameChallenge/About.dart';
import 'package:GameChallenge/Game/TicTacToe.dart';
import 'package:GameChallenge/Game/MineSweeper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static List<String> gameList = ['TicTacToe', 'MineSweeper'];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Menu(gameList: gameList),
      routes: {
        '/about': (BuildContext context) => About(),
        '/tictactoe': (BuildContext context) => TicTacToe(),
        '/minesweeper': (BuildContext context) => MineSweeper(),
      },
    );
  }
}
