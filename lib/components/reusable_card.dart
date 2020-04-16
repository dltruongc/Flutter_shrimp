import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colour,
          border: Border.all(
            width: 2,
            style: BorderStyle.solid,
            color: kDeepColor,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
