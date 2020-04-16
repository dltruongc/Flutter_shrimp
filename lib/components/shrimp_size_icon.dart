import 'dart:math';

import 'package:flutter/material.dart';

class ShrimpSizeIcon extends StatelessWidget {
  final double height;
  final int max;
  final int min;
  ShrimpSizeIcon(this.height, {this.max, this.min});
  @override
  Widget build(BuildContext context) {
    final Color color = Color.fromARGB(255, Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
    if (min == null && max == null) {
      final double pad = this.height * 1 / 9;
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: color),
          shape: BoxShape.circle,
        ),
        height: this.height,
        width: this.height,
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Image.asset(
            'images/shrimp_ico.png',
            color: color.withOpacity(0.7),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: color),
        shape: BoxShape.circle,
      ),
      height: this.height,
      width: this.height,
      child: Center(
        child: Text(
          '$min',
          style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: this.height * 2 / 5,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
