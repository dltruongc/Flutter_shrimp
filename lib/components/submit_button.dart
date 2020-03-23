import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double height;
  final double width;

  SubmitButton({
    @required this.title,
    @required this.onPressed,
    this.height = 60,
    this.width = 240,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF17ead9),
            Color(0xFF6078ea),
          ]),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6078ea).withOpacity(.3),
              offset: Offset(0.0, 8.0),
              blurRadius: 8.0,
            )
          ],
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins-Bold",
                fontSize: 18,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
