import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String title;
  final List<String> items;
  final TextStyle titleStyle;
  final TextStyle childStyle;

  Paragraph({
    @required this.title,
    @required this.items,
    this.titleStyle,
    this.childStyle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = this.titleStyle ??
        TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 82, 170, 165),
          fontWeight: FontWeight.bold,
        );

    final childStyle = this.childStyle ??
        TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          this.title,
          style: titleStyle,
        ),
        Text.rich(textSpanBuild(items, childStyle)),
      ],
    );
  }

  TextSpan textSpanBuild(List<String> items, TextStyle style) {
    return TextSpan(
      children: items.map((item) => TextSpan(text: item + '\n')).toList(),
      style: style,
    );
  }
}
