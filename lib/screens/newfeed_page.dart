import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/screens/comment_page.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

final newFeed = NewFeed.fromMap({
  "createdAt": "2020-01-11T13:05:24.070Z",
  "updatedAt": "2020-01-11T13:05:24.070Z",
  "images": ["/public/images/a.jpeg"],
  "movies": [],
  "views": 0,
  "favorites": 0,
  "_id": "5e19c8156df05ba8b30e8d6a",
  "accountId": "5dc801d6e01a84c693e6428b",
  "newfeedContent": "rweewrr",
  "newfeedLocation": "949, Santa Clara County, California",
  "updatedAt": "2020-01-11T13:05:24.070Z",
  "title": "DELETE IT 03"
});

final Account owner = Account.fromJson({
  "createdAt": "2020-01-12T18:50:20.883Z",
  "updatedAt": "2020-01-12T18:50:20.883Z",
  "farmer": {
    "farmerFullname": "Đỗ Lam Trường",
    "farmerPhoneNumber": "0964818307",
    "farmerAddress": "Cần Thơ, Ninh Kiều",
    "farmerStory": "nói gì ai biết đâu à kệ nó đi",
  },
  "profilePhoto": "/public/images/a.jpeg",
  "coverPhoto": null,
  "retailer": null,
  "researcher": null,
  "_id": "5e1b6a6f6df05ba8b30ea62a",
  "accountUserName": "dltruong",
  "isMale": null,
  "birth": null,
  "roleId": 1
});
final List<Comment> comments = [
  Comment.fromJson({
    "createdAt": "2020-01-14T15:41:33.192Z",
    "updatedAt": "2020-01-14T15:41:33.192Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de12d0bc12f9dfcdb1da8",
    "postId": "5e1de0b233fe301a0dd44c5b",
    "commentsContent":
        "Enim **consectetur** consectetur qui ***consequat*** mollit dolor. Adipisicing esse aute commodo esse *cillum* minim amet incididunt. Consequat duis ea non consequat cupidatat \n- occaecat \n- irure dolore \n1. dolore cillum occaecat cupidatat enim. \n2. Irure amet nulla in \n3. quis cillum proident fugiat duis duis enim labore minim qui. Eiusmod magna ad consectetur ullamco veniam. Sint laborum ut esse mollit labore consequat. Anim est exercitation aute commodo nulla.",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-14T15:41:23.952Z",
    "updatedAt": "2020-01-14T15:41:23.952Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de1230bc12f9dfcdb1da6",
    "postId": "5e1de0b233fe301a0dd44c5b",
    "commentsContent": "q",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-14T15:39:43.085Z",
    "updatedAt": "2020-01-14T15:39:43.085Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de0bf0bc12f9dfcdb1d86",
    "postId": "5e1ddf32c4ac97351284d5be",
    "commentsContent": "well",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-14T15:39:35.461Z",
    "updatedAt": "2020-01-14T15:39:35.461Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de0b70bc12f9dfcdb1d82",
    "postId": "5e1de0b233fe301a0dd44c5b",
    "commentsContent": "nices",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-14T15:39:07.728Z",
    "updatedAt": "2020-01-14T15:39:07.728Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de09b0bc12f9dfcdb1d77",
    "postId": "5e19c8156df05ba8b30e8d6a",
    "commentsContent": "ewq",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-14T15:37:41.041Z",
    "updatedAt": "2020-01-14T15:37:41.041Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1de0450bc12f9dfcdb1d69",
    "postId": "5e1ddf32c4ac97351284d5be",
    "commentsContent": "asas",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2020-01-04T13:26:45.071Z",
    "updatedAt": "2020-01-04T13:26:45.071Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e1030250b15ac075ca17b48",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "barorjwe",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-31T15:36:05.290Z",
    "updatedAt": "2019-12-31T15:36:05.290Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "lmc",
    "_id": "5e0b6ae5c8affc2764bd131b",
    "postId": "5e0b0e1f6a4423203c45081e",
    "commentsContent": "aaaaaa",
    "userId": "5e0863a1935d3028e0930808"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:25:14.318Z",
    "updatedAt": "2019-12-25T05:25:14.318Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Chưa có tên",
    "_id": "5e02904a3853dc84e3065ed1",
    "postId": "5e024b4a3853dc84e30653d3",
    "commentsContent": "uhm tui cũng thấy đẹp",
    "userId": "5dc801d6e01a84c693e64292"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:24:42.817Z",
    "updatedAt": "2019-12-25T05:24:42.817Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e02902a3853dc84e3065ec9",
    "postId": "5e024b4a3853dc84e30653d3",
    "commentsContent": "thấy khá thích",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:24:35.940Z",
    "updatedAt": "2019-12-25T05:24:35.940Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e0290233853dc84e3065ec5",
    "postId": "5e024b4a3853dc84e30653d3",
    "commentsContent": "ảnh đẹp đó",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:22:59.517Z",
    "updatedAt": "2019-12-25T05:22:59.517Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Chưa có tên",
    "_id": "5e028fc33853dc84e3065eb4",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "hahaha",
    "userId": "5dc801d6e01a84c693e64292"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:22:50.468Z",
    "updatedAt": "2019-12-25T05:22:50.468Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Chưa có tên",
    "_id": "5e028fba3853dc84e3065eae",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "ewrw",
    "userId": "5dc801d6e01a84c693e64292"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:18:18.545Z",
    "updatedAt": "2019-12-25T05:18:18.545Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Văn Công",
    "_id": "5e028eaa3853dc84e3065e79",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "hey mn",
    "userId": "5dc801d6e01a84c693e6428b"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:17:52.359Z",
    "updatedAt": "2019-12-25T05:17:52.359Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e028e903853dc84e3065e73",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "alolo",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:17:47.872Z",
    "updatedAt": "2019-12-25T05:17:47.872Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e028e8b3853dc84e3065e71",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "alo",
    "userId": "5dc801d6e01a84c693e64291"
  }),
  Comment.fromJson({
    "createdAt": "2019-12-25T05:15:34.882Z",
    "updatedAt": "2019-12-25T05:15:34.882Z",
    "images": [],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "profilePhoto": null,
    "userFullName": "Nguyễn Hữu Hà",
    "_id": "5e028e063853dc84e3065e3b",
    "postId": "5e024b823853dc84e30653d8",
    "commentsContent": "ewrewr",
    "userId": "5dc801d6e01a84c693e64291"
  })
];

final List<NewFeed> _addThis = [
  NewFeed.fromMap({
    "createdAt": "2020-01-11T13:05:24.070Z",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "images": ["/public/images/a.jpeg"],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e19c8156df05ba8b30e8d6a",
    "accountId": "5dc801d6e01a84c693e6428b",
    "newfeedContent": "rweewrr",
    "newfeedLocation": "949, Santa Clara County, California",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "title": "DELETE IT 01"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-11T13:05:24.070Z",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "images": ["/public/images/a.jpeg"],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e19c8156df05ba8b30e8d6a",
    "accountId": "5dc801d6e01a84c693e6428b",
    "newfeedContent": "rweewrr",
    "newfeedLocation": "949, Santa Clara County, California",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "title": "DELETE IT 02"
  }),
  NewFeed.fromMap({
    "createdAt": "2020-01-11T13:05:24.070Z",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "images": ["/public/images/a.jpeg"],
    "movies": [],
    "views": 0,
    "favorites": 0,
    "_id": "5e19c8156df05ba8b30e8d6a",
    "accountId": "5dc801d6e01a84c693e6428b",
    "newfeedContent": "rweewrr",
    "newfeedLocation": "949, Santa Clara County, California",
    "updatedAt": "2020-01-11T13:05:24.070Z",
    "title": "DELETE IT 03"
  })
];

class NewFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hỏi đáp'),
      ),
      body: Consumer<NewFeedController>(
          child: LoadingBouncingGrid.square(
            backgroundColor: kLightColor,
          ),
          builder: (context, controller, _) {
            final List<NewFeed> newfeeds = controller.getAll();
            return RefreshIndicator(
              // TODO: dummy data
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 3));
                Provider.of<NewFeedController>(context, listen: false)
                    .addFirst(_addThis);
              },
              child: ListView.builder(
                itemCount: newfeeds.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewFeedItem(
                    newFeed: newfeeds[index],
                    // FIXME: newfeed owner
                    owner: owner,
                  );
                },
              ),
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
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  widget.newFeed.newFeedContent,
                  softWrap: true,
                  maxLines: isOverflowContent ? 4 : 100,
                  overflow: isOverflowContent
                      ? TextOverflow.clip
                      : TextOverflow.visible,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CommentPage(owner, newFeed, comments)));
                  },
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
