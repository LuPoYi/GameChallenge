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
  List<int> targetNumbers = [9, 5, 2, 7];
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
      targetNumbers = targetNumbers.map((e) => random.nextInt(10)).toList();
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

    // check 2A2B or ...
    // insert guess and result to boardGuessAndResult
  }

  String _checkBullsAndCows() {
    // targetNumbers
    // inputNumbers
    return "2A1B";
  }

  Widget _buildResultTable(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                            DataCell(Text(items[2])),
                          ],
                        ))
                    .toList())));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
            children: List.generate(
                inputNumbers.length,
                (index) => NumberPicker.integer(
                    initialValue: inputNumbers[index],
                    minValue: 0,
                    maxValue: 9,
                    onChanged: (newValue) =>
                        setState(() => inputNumbers[index] = newValue)))),
        RaisedButton(
            color: Colors.greenAccent,
            animationDuration: Duration(seconds: 2),
            padding: EdgeInsets.all(20.0),
            child: Text('Submit'),
            onPressed: () {
              _handleSubmit();
            }),
        _buildResultTable(context),
        if (isGameOver)
          Text(
            "Game Over!",
            style: TextStyle(fontSize: 30),
          ),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "inputNumbers: ${inputNumbers.join(",")} ; targetNumbers: ${targetNumbers.join(",")}",
                    style: TextStyle(fontSize: 14),
                  ),
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: buildAppBar(context, "2A1B", _resetBoard),
      body: _buildBody(context),
    );
  }
}
