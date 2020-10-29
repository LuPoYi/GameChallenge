import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:GameChallenge/layout.dart';
import 'dart:math';

class PegSolitaire extends StatefulWidget {
  PegSolitaire({Key key}) : super(key: key);

  @override
  _PegSolitaireState createState() => _PegSolitaireState();
}

class _PegSolitaireState extends State<PegSolitaire> {
  int currentX = 0;
  int currentY = 0;
  int remainingSpot = 36;
  int bestScore = 36;
  bool isFinish = false;

  static List<List<dynamic>> originBoard = [
    [null, null, 1, 1, 1, null, null],
    [null, 1, 1, 1, 1, 1, null],
    [1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 0, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1],
    [null, 1, 1, 1, 1, 1, null],
    [null, null, 1, 1, 1, null, null],
  ];

  List<List<dynamic>> board =
      originBoard.map((item) => item.map((sub) => sub).toList()).toList();

  List<List<Color>> boardColor = originBoard
      .map((arr) => arr
          .map((item) => item == null ? Colors.white : getRandomColor())
          .toList())
      .toList();

  void resetBoard() {
    setState(() {
      board =
          originBoard.map((item) => item.map((sub) => sub).toList()).toList();

      boardColor = originBoard
          .map((arr) => arr
              .map((item) => item == null ? Colors.white : getRandomColor())
              .toList())
          .toList();

      remainingSpot = 36;
      isFinish = false;
    });
  }

  void _targetSpot(int x, int y) {
    setState(() {
      if (board[x][y] == 1) {
        // change target
        currentX = x;
        currentY = y;
      } else if (board[x][y] == 0) {
        // try to score
        if ((currentX - x).abs() == 2 &&
            currentY == y &&
            board[((currentX + x) ~/ 2)][y] == 1) {
          boardColor[x][y] = boardColor[currentX][currentY];
          board[currentX][currentY] = 0;
          board[((currentX + x) ~/ 2)][y] = 0;
          board[x][y] = 1;
          currentX = x;
          currentY = y;
          remainingSpot--;
          _checkIsFinish();
          _checkBestScore();
        } else if ((currentY - y).abs() == 2 &&
            currentX == x &&
            board[x][((currentY + y) ~/ 2)] == 1) {
          boardColor[x][y] = boardColor[currentX][currentY];
          board[currentX][currentY] = 0;
          board[x][((currentY + y) ~/ 2)] = 0;
          board[x][y] = 1;
          currentX = x;
          currentY = y;
          remainingSpot--;
          _checkIsFinish();
          _checkBestScore();
        }
      }
    });
  }

  void _checkIsFinish() {
    // check right and down
    if (!isFinish) {
      for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 7; j++) {
          if (board[i][j] == null || board[i][j] == 0) {
            continue;
          }

          if ((i > 2 && board[i - 1][j] == 1 && board[i - 2][j] == 0) ||
              (i < 5 && board[i + 1][j] == 1 && board[i + 2][j] == 0) ||
              (j > 2 && board[i][j - 1] == 1 && board[i][j - 2] == 0) ||
              (j < 5 && board[i][j + 1] == 1 && board[i][j + 2] == 0)) {
            return;
          }
        }
      }
      isFinish = true;
      _showFinishDialog();
    }
  }

  void _showFinishDialog() {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text("Good Job!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void _checkBestScore() {
    if (remainingSpot < bestScore) {
      bestScore = remainingSpot;
    }
  }

  static Color getRandomColor() {
    return Color.fromARGB(200, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  Widget buildBoard() {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
            width: double.maxFinite,
            child: Column(
              children: <Widget>[
                for (int x = 0; x < 7; x++)
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              for (int y = 0; y < 7; y++)
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Visibility(
                                              child: RawMaterialButton(
                                                child: x == currentX &&
                                                        y == currentY
                                                    ? Icon(Icons.flag)
                                                    : null,
                                                onPressed: () =>
                                                    _targetSpot(x, y),
                                                elevation: 2.0,
                                                fillColor: board[x][y] == 0
                                                    ? Colors.white
                                                    : boardColor[x][y],
                                                highlightColor:
                                                    Colors.blueAccent,
                                                padding: EdgeInsets.all(0.0),
                                                shape: CircleBorder(),
                                              ),
                                              visible: board[x][y] != null)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            )));
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: <Widget>[buildBoard(), _buildBottomInfo()]);
  }

  Widget _buildBottomInfo() {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'remainingSpot: $remainingSpot',
                style: TextStyle(fontSize: 20),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: buildAppBar(context, "Peg Solitaire", resetBoard),
      body: _buildBody(context),
    );
  }
}
