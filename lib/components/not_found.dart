import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;

  NotFoundWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.error,
          color: Colors.red.shade700,
          size: 48,
        ),
        Text(
          message,
          style: TextStyle(color: Colors.red.shade800),
        ),
      ],
    );
  }
}
