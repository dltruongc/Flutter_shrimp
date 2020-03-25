import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';

import 'constants.dart';
import 'screens/home_page.dart';

FadeInImage fa = FadeInImage(
  placeholder: null,
  image: null,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NewFeedController(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteController(),
          ),
        ],
        child: MaterialApp(
          routes: {
            HomePage.route: (context) => HomePage(),
          },
          home: MyApp(),
          theme: ThemeData(
            iconTheme: new IconThemeData(
              color: Colors.white,
              opacity: 1.0,
              size: 60.0,
            ),
            textTheme: TextTheme(
              body1: TextStyle(color: kDisplayTextColor),
              display1: TextStyle(color: kBodyTextColor),
              title: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
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
  });
}
