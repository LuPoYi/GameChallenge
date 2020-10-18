import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black26,
      appBar: buildAppBar(context, "Menu page"),
      body: _buildGameList(context),
    ));
  }

  Widget _buildGameList(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 192.0,
          mainAxisSpacing: 8.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _buildGameCard(context, 'TicTacToe');
          },
          childCount: 10,
        ),
      ),
    ]);
  }

  Widget _buildGameCard(BuildContext context, String gameTitle) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                child: Hero(
                    placeholderBuilder: (context, size, child) {
                      final Color color =
                          Theme.of(context).scaffoldBackgroundColor ==
                                  Colors.black
                              ? Colors.white24
                              : Colors.black54;
                      return ColorFiltered(
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                          child: child);
                    },
                    transitionOnUserGestures: true,
                    tag: gameTitle,
                    child: Image.asset(
                      'assets/tictactoe.png',
                      fit: BoxFit.scaleDown,
                    ))),
            flex: 9,
          ),
          Expanded(
            child: Container(
                decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColorLight,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8)))),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(gameTitle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 15, color: Color(0xFF161616)))),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
