import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:math';

class BullsAndCows extends StatefulWidget {
  BullsAndCows({Key key}) : super(key: key);

  @override
  _BullsAndCowsState createState() => _BullsAndCowsState();
}

class _BullsAndCowsState extends State<BullsAndCows> {
  List<int> numberList = List<int>.generate(10, (i) => i);
  List<int> targetNumbers = [];
  List<int> inputNumbers = [9, 5, 2, 7];
  bool isGameOver = false;
  Random random = new Random();

  List<List<dynamic>> boardGuessAndResult = [];

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  _resetBoard() {
    setState(() {
      numberList.shuffle();
      targetNumbers = numberList.sublist(0, 4);

      boardGuessAndResult = [];
    });
  }

  _handleInput(index, newValue) {
    setState(() {
      inputNumbers[index] = newValue;
    });
  }

  _handleSubmit() {
    int lastIndex = 0;
    if (boardGuessAndResult.length > 0) {
      lastIndex = boardGuessAndResult.last[0];
    }
    String result = _checkBullsAndCows();

    setState(() {
      boardGuessAndResult.add([lastIndex + 1, inputNumbers.join(), result]);
      if (result == '4A0B') {
        isGameOver = true;
      }
    });
  }

  String _checkBullsAndCows() {
    int countA = 0, countB = 0;
    inputNumbers.asMap().forEach((index, element) {
      if (targetNumbers[index] == element) {
        countA++;
      } else if (targetNumbers.indexOf(element) != -1) {
        countB++;
      }
    });
    return "${countA}A${countB}B";
  }

  Widget _buildResultTable(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Theme(
                data:
                    Theme.of(context).copyWith(dividerColor: Colors.blueAccent),
                child: DataTable(
                    columns: ['#', 'Guess', 'Result']
                        .map(
                          (title) => DataColumn(
                            label: Text(
                              title,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                        .toList(),
                    rows: boardGuessAndResult.reversed
                        .toList()
                        .map((items) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(items[0].toString())),
                                DataCell(Text(items[1])),
                                DataCell(Text(items[2],
                                    style:
                                        TextStyle(color: Colors.deepPurple))),
                              ],
                            ))
                        .toList()))));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                inputNumbers.length,
                (index) => NumberPicker.integer(
                    initialValue: inputNumbers[index],
                    listViewWidth: 80,
                    infiniteLoop: true,
                    minValue: 0,
                    maxValue: 9,
                    onChanged: (newValue) => _handleInput(index, newValue)))),
        RaisedButton(
            color: Colors.greenAccent,
            animationDuration: Duration(seconds: 2),
            padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: Text('Submit'),
            onPressed: () {
              _handleSubmit();
            }),
        _buildResultTable(context),
        if (isGameOver)
          Text(
            "Finish!",
            style: TextStyle(fontSize: 30),
          ),
        _buildBottomInfo()
      ],
    );
  }

  Widget _buildBottomInfo() {
    return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Count: ${boardGuessAndResult.length}",
                style: TextStyle(fontSize: 14),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: buildAppBar(context, "2A1B", _resetBoard),
      body: _buildBody(context),
    );
  }
}
