import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';
import 'dart:math';

class MineSweeper extends StatefulWidget {
  MineSweeper({Key key}) : super(key: key);

  @override
  _MineSweeperState createState() => _MineSweeperState();
}

class _MineSweeperState extends State<MineSweeper> {
  List<List<bool>> board;
  List<List<bool>> boardCover;
  List<List<Color>> boardBackgroundColor;
  int mineX, mineY;
  int randomSeed = 5;
  int restItem;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  void _sweep(int x, int y) {
    if (!boardCover[x][y] && !isGameOver) {
      _pick(x, y);
    }
  }

  void _pick(int x, int y) {
    setState(() {
      if (!boardCover[x][y]) {
        boardCover[x][y] = true;
      }
      if (board[x][y]) {
        boardBackgroundColor[x][y] = Colors.red[200];
        isGameOver = true;
      } else {
        boardBackgroundColor[x][y] = Colors.green[200];
      }
      restItem--;
    });
  }

  void _resetBoard() {
    setState(() {
      board = new List.generate(
          5,
          (i) => List.generate(
              5, (i) => Random().nextInt(randomSeed) == 0 ? true : false));

      boardCover = new List.generate(5, (i) => List.generate(5, (i) => false));

      boardBackgroundColor =
          new List.generate(5, (i) => List.generate(5, (i) => Colors.white));
    });

    isGameOver = false;
    restItem = 25;
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_buildBoard()],
      )),
      if (isGameOver)
        Text(
          "Game Over!",
          style: TextStyle(fontSize: 30),
        ),
      _buildBottomInfo()
    ]);
  }

  Widget _buildBottomInfo() {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Rest: $restItem',
                style: TextStyle(fontSize: 20),
              ),
            )));
  }

  Widget _buildBoard() {
    return Column(
        children: List.generate(
      5,
      (x) => Row(
        children: new List.generate(5, (y) => _buildBox(x, y)),
      ),
    ));
  }

  Widget _buildBox(int x, int y) {
    BoxBorder border = Border();
    BorderSide borderStyle = BorderSide(width: 1, color: Colors.black26);
    double height = 70;
    double width = 70;

    border = Border(
        top: borderStyle,
        bottom: borderStyle,
        left: borderStyle,
        right: borderStyle);

    return InkWell(
        onTap: () {
          _sweep(x, y);
        },
        child: (Container(
            decoration: BoxDecoration(
              color: boardBackgroundColor[x][y],
              border: border,
            ),
            height: height,
            width: width,
            child: Center(child: Text((() {
              if (!boardCover[x][y]) {
                return '';
              }
              return board[x][y] ? 'Boom!' : 'Safe';
            })())))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: buildAppBar(context, "Mine Sweeper", _resetBoard),
      body: _buildBody(context),
    );
  }
}
