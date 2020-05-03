import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/screens/home_page.dart';
import 'package:shrimpapp/screens/register_page.dart';
import 'package:shrimpapp/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => NewFeedController(),
            ),
            ChangeNotifierProvider(
              create: (context) => FavoriteController(),
            ),
            ChangeNotifierProvider(
              create: (context) => AuthController(),
            ),
          ],
          child: MaterialApp(
            routes: {
              HomePage.route: (context) => HomePage(),
              MyApp.route: (context) => MyApp(),
              RegisterPage.registerRoute: (context) => RegisterPage(),
            },
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              iconTheme: new IconThemeData(
                color: Colors.white,
                opacity: 1.0,
                size: 60.0,
              ),
              textTheme: TextTheme(
                body1: TextStyle(
                  color: kDisplayTextColor,
                  height: 1.3,
                ),
                display1: TextStyle(color: kBodyTextColor),
                title: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  letterSpacing: 1.3,
                ),
                caption: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  letterSpacing: 1.2,
                  wordSpacing: 1.5,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Color(0xFF00A3B3),
            ),
          ),
        ),
      );
    },
  );
}
