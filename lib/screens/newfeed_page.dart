import 'package:flutter/material.dart';
import 'package:shrimpapp/models/NewFeed.dart';

final List<NewFeed> newfeeds = [
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "images": [],
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
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e722a15d684b2542460e050",
    "accountId": "5e71f11bfbb5942d4031b0c0",
    "title": "Postman",
    "newfeedLocation": "Bến Tre, Việt Nam",
    "newfeedContent": "Hello from Postman"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "images": [],
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
    "images": [],
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
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e1de0b233fe301a0dd44c5b",
    "accountId": "5dc801d6e01a84c693e64291",
    "newfeedContent": "rwe",
    "newfeedLocation": "Đường Đề Thám, Quận Ninh Kiều, Thành Phố Cần Thơ",
    "updatedAt": "2020-01-14T15:39:30.486Z",
    "title": "so good"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-14T15:33:06.774Z",
    "images": [],
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
    "images": [],
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
    "images": ["/public/images/received_694254294435388.jpeg"],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e19c8156df05ba8b30e8d6a",
    "newfeedId": null,
    "accountId": "5dc801d6e01a84c693e6428b",
    "newfeedContent": "rweewrr",
    "newfeedLocation": "949, Santa Clara County, California",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "title": "rfrktgmrothytiouehjy"
  })
];

class NewFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hỏi đáp'),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blue[index * 100],
              child: Text('OKOKO'),
              height: 100,
            );
          }),
    );
  }
}
