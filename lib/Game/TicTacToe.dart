import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';

class TicTacToe extends StatefulWidget {
  TicTacToe({Key key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];

  List<List<Color>> boardBackgroundColor = [
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white],
    [Colors.white, Colors.white, Colors.white],
  ];

  bool isGameOver = false;
  String currentPlayer = "O";

  void _move(int x, int y) {
    if (!isGameOver) {
      if (board[x][y].isEmpty) {
        setState(() {
          board[x][y] = currentPlayer;
          boardBackgroundColor[x][y] =
              currentPlayer == "O" ? Colors.blue[100] : Colors.green[100];
        });
      }

      if (_checkWinner(x, y)) {
        setState(() {
          isGameOver = true;
        });
      } else {
        _changePlayer();
      }
    }
  }

  bool _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;

    for (int i = 0; i < 3; i++) {
      if (board[x][i] == currentPlayer) col++;
      if (board[i][y] == currentPlayer) row++;
      if (board[i][i] == currentPlayer) diag++;
      if (board[i][2 - i] == currentPlayer) rdiag++;
    }

    if (row == 3 || col == 3 || diag == 3 || rdiag == 3) {
      return true;
    }
    return false;
  }

  void resetBoard() {
    setState(() {
      board = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      boardBackgroundColor = [
        [Colors.white, Colors.white, Colors.white],
        [Colors.white, Colors.white, Colors.white],
        [Colors.white, Colors.white, Colors.white],
      ];
      isGameOver = false;
      currentPlayer = "O";
    });
  }

  void _changePlayer() {
    if (currentPlayer == "X") {
      currentPlayer = "O";
    } else {
      currentPlayer = "X";
    }
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: <Widget>[
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_buildBoard()],
      ),
      if (isGameOver)
        Text(
          "Game Over, $currentPlayer Win!",
          style: TextStyle(fontSize: 30),
        ),
      _buildBottomInfo()
    ]);
  }

  Widget _buildBoard() {
    return Column(
        children: List.generate(
      3,
      (x) => Row(
        children: new List.generate(3, (y) => _buildBox(x, y)),
      ),
    ));
  }

  Widget _buildBottomInfo() {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Current Player: $currentPlayer',
                style: TextStyle(fontSize: 20),
              ),
            )));
  }

  Widget _buildBox(int x, int y) {
    BoxBorder border = Border();
    BorderSide borderStyle = BorderSide(width: 1, color: Colors.black26);
    double height = 120;
    double width = 120;

    border = Border(
        top: borderStyle,
        bottom: borderStyle,
        left: borderStyle,
        right: borderStyle);

    return InkWell(
        onTap: () {
          _move(x, y);
        },
        child: (Container(
          decoration: BoxDecoration(
            color: boardBackgroundColor[x][y],
            border: border,
          ),
          height: height,
          width: width,
          child: Center(
              child: Text(
            board[x][y].toString(),
            style: TextStyle(fontSize: 30),
          )),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: buildAppBar(context, "Tic Tac Toe", resetBoard),
      body: _buildBody(context),
    );
  }
}
