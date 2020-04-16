import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/providers/login_state_provider.dart';
import 'package:shrimpapp/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadAccount();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(MyApp.route);
  }

  loadAccount() async {
    try {
      Account loggedInAccount = await LoginStorageProvider.loadFromSP();
      if (loggedInAccount != null) {
        Provider.of<AuthController>(context, listen: false)
            .setOwner(loggedInAccount);
      }
      navigationPage();
    } catch (e) {
      Alert(
        context: context,
        title: 'Đăng nhập thất bại',
        content: Text(e.toString()),
        type: AlertType.warning,
        closeFunction: navigationPage,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(
        isBackground: true,
      ),
    );
  }
}
