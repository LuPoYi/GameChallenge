import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';

class MineSweeper extends StatefulWidget {
  MineSweeper({Key key}) : super(key: key);

  @override
  _MineSweeperState createState() => _MineSweeperState();
}

Widget _buildBody(BuildContext context) {
  return Text("Mine Sweeper - not yet");
}

class _MineSweeperState extends State<MineSweeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: buildAppBar(context, "Mine Sweeper"),
      body: _buildBody(context),
    );
  }
}
