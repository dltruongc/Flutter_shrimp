import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        home: MyApp(),
        theme: ThemeData(
          iconTheme: new IconThemeData(
            color: Colors.white,
            opacity: 1.0,
            size: 60.0,
          ),
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFF00A3B3),
        ),
      ),
    );
  });
}
