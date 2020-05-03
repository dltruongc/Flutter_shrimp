import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/screens/comment_page.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

class NewFeedItem extends StatefulWidget {
  final NewFeed newFeed;
  final Account owner;

  // FIXME: owner feed item null error
  NewFeedItem({
    Key key,
    @required this.newFeed,
    @required this.owner,
    like = false,
  }) : super(key: key);

  @override
  _NewFeedItemState createState() => _NewFeedItemState();
}

class _NewFeedItemState extends State<NewFeedItem> {
  bool like = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Account loginAccount = Provider.of<AuthController>(context).owner;
    if (loginAccount != null)
      Provider.of<FavoriteController>(context, listen: false)
          .findFeed(widget.newFeed.id, loginAccount.id)
          .then((found) {
        setState(() {
          like = found;
        });
      }).catchError((err) {
        print(err);
      });
  }

  Future<void> likeController(Account loginAccount) async {
    try {
      final String authToken = loginAccount.token;
      final String accountId = loginAccount.id;
      if (!like) {
        Provider.of<FavoriteController>(context, listen: false)
            .like(authToken, widget.newFeed.id, accountId);
        // Provider.of<FavoriteController>(context, listen: false)
        //     .fetchAnnouce(accountId);
        setState(() {
          like = true;
        });
      } else {
        final unlike =
            await Provider.of<FavoriteController>(context, listen: false)
                .unLike(authToken, widget.newFeed.id, accountId);
        // Provider.of<FavoriteController>(context, listen: false)
        //     .fetchAnnouce(accountId);
        setState(() {
          like = unlike ? false : like;
        });
      }
    } catch (err) {
      print('Like ERROR: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    Account loginAccount =
        Provider.of<AuthController>(context, listen: false).owner;

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MarkdownBody(
                    data: widget.newFeed.newFeedContent,
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                  ),
                ),
              ],
            ),
          ),
          widget.newFeed.images.length > 0
              ? SliderImages(images: widget.newFeed.images)
              : SizedBox(),
          // Interactive post buttons
          SizedBox(height: 4.0),
          // TODO: newfeed views count
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
                  onPressed: () {
                    likeController(loginAccount);
                  },
                  icon: like
                      ? Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          size: 20.0,
                          color: Colors.blue.shade400,
                        )
                      : Icon(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentPage(
                          widget.newFeed,
                        ),
                      ),
                    );
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
                // TODO: DELETE newFeed implement
                // loginAccount.id == widget.newFeed.accountId
                //     ? FlatButton.icon(
                //         padding: const EdgeInsets.all(0.0),
                //         onPressed: () {},
                //         icon: Icon(
                //           FontAwesomeIcons.trashAlt,
                //           size: 20.0,
                //           color: Colors.red,
                //         ),
                //         label: Text(
                //           'Xóa',
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       )
                //     : SizedBox(),
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
