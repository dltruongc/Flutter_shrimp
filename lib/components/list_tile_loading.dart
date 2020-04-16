import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';

class LoadingContainer extends StatefulWidget {
  @override
  _LoadingContainerState createState() => _LoadingContainerState();
}

class _LoadingContainerState extends State<LoadingContainer> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        color: kDeepColor,
        height: 50,
        width: 50,
      ),
      title: Container(
        color: kDeepColor,
        height: 30.0,
        width: 30.0,
      ),
      subtitle: Column(
        children: <Widget>[
          Divider(
            thickness: 12.0,
            endIndent: 8.0,
          ),
          Divider(
            thickness: 12.0,
            endIndent: 8.0,
          )
        ],
      ),
    );
  }

  final x = AnimatedContainer(
    curve: Curves.linear,
    duration: Duration(seconds: 3),
  );
}
