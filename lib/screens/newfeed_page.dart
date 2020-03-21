import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

final List<NewFeed> newfeeds = [
  NewFeed.fromMap({
    "createdAt": "2020-03-18T13:59:00.996Z",
    "images": ['public/images/a.jpeg', 'public/images/b.jpeg'],
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
    "images": ['xxxxxx'],
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
    "images": ['public/images/a.jpeg'],
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
    "images": ['public/images/c.jpeg'],
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
    "images": ['public/images/d.jpg'],
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

final Account owner = Account.fromJson({
  "createdAt": "2020-01-12T18:50:20.883Z",
  "updatedAt": "2020-01-12T18:50:20.883Z",
  "farmer": {
    "farmerFullname": "Đỗ Lam Trường",
    "farmerPhoneNumber": "0964818307",
    "farmerAddress": "Cần Thơ, Ninh Kiều",
    "farmerStory": "nói gì ai biết đâu à kệ nó đi",
  },
  "profilePhoto": "public/images/a.jpeg",
  "coverPhoto": null,
  "retailer": null,
  "researcher": null,
  "_id": "5e1b6a6f6df05ba8b30ea62a",
  "accountUserName": "dltruong",
  "isMale": null,
  "birth": null,
  "roleId": 1
});

class NewFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hỏi đáp'),
      ),
      body: ListView.builder(
          itemCount: newfeeds.length,
          itemBuilder: (BuildContext context, int index) {
            return NewFeedItem(
              newFeed: newfeeds[index],
              owner: owner,
            );
          }),
    );
  }
}

class NewFeedItem extends StatefulWidget {
  final NewFeed newFeed;
  final Account owner;

  NewFeedItem({Key key, @required this.newFeed, @required this.owner})
      : super(key: key);

  @override
  _NewFeedItemState createState() => _NewFeedItemState();
}

class _NewFeedItemState extends State<NewFeedItem> {
  @override
  Widget build(BuildContext context) {
    bool isOverflowContent =
        widget.newFeed.newFeedContent.length > 50 ? true : false;
    return Container(
      child: Column(
        children: <Widget>[
          // Account card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AccountBar(
              account: widget.owner,
              subTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(widget.newFeed.newFeedLocation ?? ''),
                  Text(
                    DateFormatter.toVietNamString(widget.newFeed.createdAt),
                  ),
                ],
              ),
            ),
          ),

          // NewFeed content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.newFeed.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    letterSpacing: 1.3,
                  ),
                ),
                Text(
                  widget.newFeed.newFeedContent,
                  softWrap: true,
                  maxLines: isOverflowContent ? 4 : 100,
                  overflow: isOverflowContent
                      ? TextOverflow.clip
                      : TextOverflow.visible,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          // Images
//          widget.newFeed.images.length > 0
//              ? MyNetworkImage.fromPath(path: widget.newFeed.images[0])
//              : SizedBox(height: 150.0, width: double.infinity),

          widget.newFeed.images.length > 0
              ? SliderImages(images: widget.newFeed.images)
              : SizedBox(),
          // Interactive post buttons
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade500,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
            height: 32.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  label: Text(
                    'Quan tâm',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.commentAlt,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  label: Text(
                    'Bình luận',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.share,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  label: Text(
                    'Chia sẻ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 10.0,
            thickness: 10.0,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
