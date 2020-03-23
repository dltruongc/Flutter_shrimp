import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';

import 'constants.dart';
import 'models/NewFeed.dart';
import 'screens/home_page.dart';

final _newFeeds = [
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "images": ['/public/images/c.jpeg', '/public/images/b.jpeg'],
    "updatedAt": "2020-03-18T13:59:00.996Z",
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e722926d684b2542460e047",
    "accountId": "5e71f11bfbb5942d4031b0c0",
    "title": "Postman",
    "newfeedLocation": "Bến Tre, Việt Nam",
    "newfeedContent": "Hello from Postman"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "images": [
      "/public/images/6b62f3a7-a2f6-4187-85b1-e93e88706bde.png",
      '/public/images/c.jpeg'
    ],
    "movies": [],
    "views": 0,
    "updatedAt": "2020-03-18T13:59:00.996Z",
    "favorites": 0,
    "_id": "5e722a15d684b2542460e050",
    "accountId": "5e71f11bfbb5942d4031b0c0",
    "title": "Postman",
    "newfeedLocation": "Bến Tre, Việt Nam",
    "newfeedContent": "Hello from Postman"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "updatedAt": "2020-03-18T13:59:00.996Z",
    "images": ['/public/images/a.jpeg'],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e722a18d684b2542460e053",
    "accountId": "5e71f11bfbb5942d4031b0c0",
    "title": "Postman",
    "newfeedLocation": "Bến Tre, Việt Nam",
    "newfeedContent": "Hello from Postman"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "updatedAt": "2020-03-18T13:59:00.996Z",
    "images": ['/public/images/c.jpeg'],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e722a19d684b2542460e056",
    "accountId": "5e71f11bfbb5942d4031b0c0",
    "title": "Postman",
    "newfeedLocation": "Bến Tre, Việt Nam",
    "newfeedContent": "Hello from Postman"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-14T15:39:30.486Z",
    "updatedAt": "2020-01-14T15:39:30.486Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e1de0b233fe301a0dd44c5b",
    "accountId": "5dc801d6e01a84c693e64291",
    "newfeedContent": "rwe",
    "newfeedLocation": "Đường Đề Thám, Quận Ninh Kiều, Thành Phố Cần Thơ",
    "updatedAt": "2020-01-14T15:39:30.486Z",
    "title": "so good1"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-14T15:33:06.774Z",
    "updatedAt": "2020-01-14T15:33:06.774Z",
    "images": ['/public/images/d.jpg'],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e1ddf32c4ac97351284d5be",
    "accountId": "5dc801d6e01a84c693e64291",
    "newfeedContent": "ghnjmy",
    "newfeedLocation": "Đường Đề Thám, Quận Ninh Kiều, Thành Phố Cần Thơ",
    "updatedAt": "2020-01-14T15:33:06.774Z",
    "title": "oh my good"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-13T12:00:30.389Z",
    "updatedAt": "2020-01-13T12:00:30.389Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e1c5bde65adcfe0c702ad12",
    "accountId": "5dc801d6e01a84c693e64291",
    "newfeedContent": "gbitrujno",
    "newfeedLocation": "Đường Đề Thám, Quận Ninh Kiều, Thành Phố Cần Thơ",
    "updatedAt": "2020-01-13T12:00:30.389Z",
    "title": "1"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-12T16:13:47.261Z",
    "updatedAt": "2020-01-12T16:13:47.261Z",
    "images": [
      "/public/images/6b62f3a7-a2f6-4187-85b1-e93e88706bde.png",
      "/public/images/received_694254294435388.jpeg",
      "/public/images/6b62f3a7-a2f6-4187-85b1-e93e88706bde.png"
    ],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e1b45bb6df05ba8b30ea283",
    "accountId": "5dc801d6e01a84c693e64291",
    "newfeedContent": "ưerw",
    "newfeedLocation": "Đường Đề Thám, Quận Ninh Kiều, Thành Phố Cần Thơ",
    "updatedAt": "2020-01-12T16:13:47.261Z",
    "title": "ewr"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-11T13:05:24.070Z",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "images": ["/public/images/received_694254294435388.jpeg"],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e19c8156df05ba8b30e8d6a",
    "accountId": "5dc801d6e01a84c693e6428b",
    "newfeedContent": "rweewrr",
    "newfeedLocation": "949, Santa Clara County, California",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "title": "rfrktgmrothytiouehjy"
  })
];

FadeInImage fa = FadeInImage(
  placeholder: null,
  image: null,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => NewFeedController(_newFeeds),
        child: MaterialApp(
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
  });
}
