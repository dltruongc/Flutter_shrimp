import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String leftChild;
  final String rightChild;
  final Widget trailing;
  final Widget leading;
  ListTileCustom({
    this.leftChild,
    this.rightChild,
    this.trailing,
    this.leading,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(leftChild), Text(rightChild)],
        ),
      ),
    );
  }
}
