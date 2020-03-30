import 'package:flutter/material.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/screens/login_page.dart';

class LoginRequireScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather_wall.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.softLight),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Bạn chưa đăng nhập!\n',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                  wordSpacing: 3.0,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Đăng nhập để theo dõi những nội dung bạn quan tâm',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                      wordSpacing: 2.0,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 40,
              width: 300,
              child: Column(
                children: <Widget>[
                  SubmitButton(
                    title: 'Đăng nhập',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
