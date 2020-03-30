import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/screens/login_page.dart';

class LoginAlert extends Alert {
  LoginAlert({@required BuildContext context, @required String title})
      : super(context: context, title: title);

  get alert => Alert(
        context: context,
        title: 'Đăng nhập',
        content: Text('Bạn chưa đăng nhập!'),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text('Đăng nhập'),
          ),
        ],
      );
}
