import 'package:flutter/material.dart';
import 'package:GameChallenge/layout.dart';

class Menu extends StatelessWidget {
  final List<String> gameList;
  const Menu({Key key, this.gameList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: buildAppBar(context, "Menu page"),
      body: _buildGameList(context),
    );
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
            return _buildGameCard(context, gameList[index]);
          },
          childCount: gameList.length,
        ),
      ),
    ]);
  }

  Widget _buildGameCard(BuildContext context, String gameName) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/${gameName.toLowerCase()}');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                    child: Hero(
                        placeholderBuilder: (context, size, child) {
                          final Color color =
                              Theme.of(context).scaffoldBackgroundColor ==
                                      Colors.black
                                  ? Colors.white24
                                  : Colors.black54;
                          return ColorFiltered(
                              colorFilter:
                                  ColorFilter.mode(color, BlendMode.srcIn),
                              child: child);
                        },
                        transitionOnUserGestures: true,
                        tag: gameName,
                        child: Image.asset(
                          'assets/${gameName.toLowerCase()}.png',
                          fit: BoxFit.scaleDown,
                        ))),
                flex: 9,
              ),
              Expanded(
                child: Container(
                    decoration: ShapeDecoration(
                        color: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8)))),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(gameName,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF161616)))),
                flex: 2,
              ),
            ],
          ),
        ));
  }
}
