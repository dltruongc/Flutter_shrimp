import 'package:flutter/material.dart';

class TextHighlight {
  static Text highlight({@required String content, String symbol = ''}) => Text(
        '$symbol$content',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
}
