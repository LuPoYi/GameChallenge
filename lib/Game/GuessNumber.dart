import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:math';

class GuessNumber extends StatefulWidget {
  GuessNumber({Key key}) : super(key: key);

  @override
  _GuessNumberState createState() => _GuessNumberState();
}

class _GuessNumberState extends State<GuessNumber> {
  int targetNumber;
  int inputNumber;
  int lowerLimit = 0;
  int higherLimit = 100;
  bool isGameOver = false;

  Random random = new Random();

  List<List<dynamic>> guessNumberResult = [];

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  _resetBoard() {
    setState(() {
      targetNumber = random.nextInt(100);
      inputNumber = random.nextInt(100);
      lowerLimit = 0;
      higherLimit = 100;
      inputNumber = 50;
      isGameOver = false;
      guessNumberResult = [];
    });
  }

  _handleSubmit() {
    int lastIndex = 0;
    if (guessNumberResult.length > 0) {
      lastIndex = guessNumberResult.last[0];
    }

    setState(() {
      if (targetNumber > inputNumber) {
        lowerLimit = inputNumber;
        guessNumberResult
            .add([lastIndex + 1, inputNumber, Icon(Icons.arrow_circle_up)]);
      } else if (targetNumber < inputNumber) {
        higherLimit = inputNumber;
        guessNumberResult
            .add([lastIndex + 1, inputNumber, Icon(Icons.arrow_circle_down)]);
      } else {
        isGameOver = true;
        guessNumberResult.add([lastIndex + 1, inputNumber, Icon(Icons.check)]);
      }
    });
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
                    rows: guessNumberResult.reversed
                        .toList()
                        .map((items) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(items[0].toString())),
                                DataCell(Text(items[1].toString())),
                                DataCell(items[2]),
                              ],
                            ))
                        .toList()))));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        NumberPicker.integer(
            initialValue: inputNumber,
            listViewWidth: 160,
            infiniteLoop: false,
            minValue: lowerLimit,
            maxValue: higherLimit,
            onChanged: (newValue) => {
                  setState(() {
                    inputNumber = newValue;
                  })
                }),
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
                "Count: ${guessNumberResult.length}",
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
