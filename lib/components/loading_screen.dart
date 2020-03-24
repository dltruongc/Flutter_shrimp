import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shrimpapp/constants.dart';

class LoadingScreen extends StatelessWidget {
  final bool isBackground;

  LoadingScreen({this.isBackground = false});

  @override
  Widget build(BuildContext context) {
    if (isBackground)
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather_wall.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: LoadingBouncingGrid.square(
            borderColor: Colors.white,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: LoadingBouncingGrid.square(
          borderColor: kLightColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
