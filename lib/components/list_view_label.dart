import 'dart:math';

import 'package:flutter/material.dart';

/// Limit number of items by `shows`
/// Default [length] by `items.length`
class ListViewLabel extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final int shows;

  ListViewLabel({this.title, this.items, this.shows});

  @override
  Widget build(BuildContext context) {
    Widget titleBuild(String title) {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 6, 6, 6),
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1AA1B0),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }

    return Column(
      children: <Widget>[
        titleBuild(title),
        Container(
            height: min(shows, items.length).toDouble() * 60,
            child: Column(
              children: items,
            )),
      ],
    );
  }
}
