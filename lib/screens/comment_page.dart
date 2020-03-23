import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/components/comment_box.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

const _text =
    """Ea magna aliquip ad ullamco reprehenderit dolore nisi commodo. Deserunt deserunt culpa cupidatat consequat anim. Qui cillum elit enim est eiusmod id voluptate laborum aute. Elit anim quis sunt exercitation aliquip proident est cupidatat. Ad eu adipisicing veniam amet consequat qui deserunt sunt incididunt velit. Aliqua commodo id non id reprehenderit eu deserunt qui sint minim velit quis consequat velit. Enim ullamco amet labore labore dolor pariatur Lorem.

In laborum nostrud veniam labore consequat id fugiat anim. Duis aliquip minim cupidatat id incididunt reprehenderit commodo ullamco aute. Ad aute id et sint nulla nulla cillum sunt id anim pariatur incididunt fugiat excepteur. Exercitation nulla commodo incididunt velit reprehenderit proident ad laboris eiusmod duis magna fugiat ut culpa. Voluptate id non consectetur ad laboris reprehenderit in quis irure nostrud non cupidatat do. Id anim excepteur eiusmod tempor ea cillum minim reprehenderit aliqua. Mollit adipisicing sit ea nostrud sunt veniam.

Pariatur sunt laborum do laboris eu non reprehenderit ut anim et incididunt qui. Duis sint exercitation magna dolor irure dolore sint minim tempor velit. Tempor exercitation in proident ad non in. Sunt ea sunt in quis. Magna esse sit aute exercitation irure nisi.
\n""";

final _sad = Comment.fromJson({
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
      "Enim **consectetur** consectetur qui ***consequat*** mollit dolor. Adipisicing esse aute ![image](http://192.168.43.111:3000/public/images/axx.jpeg) commodo esse *cillum* minim amet incididunt. Consequat duis ea non consequat cupidatat \n- occaecat \n- irure dolore \n1. dolore cillum occaecat cupidatat enim. \n2. Irure amet nulla in \n3. quis cillum proident fugiat duis duis enim labore minim qui. Eiusmod magna ad consectetur ullamco veniam. Sint laborum ut esse mollit labore consequat. Anim est exercitation aute commodo nulla.",
  "userId": "5dc801d6e01a84c693e64291"
});

const _dumpText = [
  _text,
  _text,
  _text,
  _text,
  _text,
  _text,
  _text,
  _text,
  _text,
  _text,
];

class CommentPage extends StatefulWidget {
  final Account owner;
  final NewFeed newFeed;
  final List<Comment> comments;

  CommentPage(this.owner, this.newFeed, this.comments);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController cmtController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: <Widget>[
                AccountBar(
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
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                widget.newFeed.images.length > 0
                    ? Container(
                        height: 250.0,
                        width: double.infinity,
                        child: SliderImages(images: widget.newFeed.images),
                      )
                    : SizedBox(),
                Divider(
                  height: 30.0,
                  thickness: 0.8,
                  color: Colors.black38,
                ),
                ...widget.comments.map(
                  (cmt) =>
                      CommentBox(widget.owner, cmt, controller: cmtController),
                )
              ],
            ),
            // Enter comment
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey.shade400,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                child: TextField(
                  onTap: () {
                    // Implement PostEditor page
                  },
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  enableInteractiveSelection: true,
                  minLines: null,
                  maxLines: null,
                  keyboardAppearance: Brightness.dark,
                  enabled: true,
                  controller: cmtController,
                  decoration: InputDecoration(
                    hintText: ' Nhập bình luận...',
                    prefixIcon: IconButton(
                      icon: Icon(FontAwesomeIcons.camera),
                      onPressed: () {
                        // Camera pick comment implement
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        // Send comment implement
                        if (cmtController.text.isEmpty) {
                          Alert(
                            context: context,
                            closeFunction: () {},
                            title: 'Bình luận rỗng',
                            content: Text(
                              'Bạn đang gởi một bình luận không có nội dung.',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ).show();
                        }
                        setState(() {
                          this.widget.comments.insert(0, _sad);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
