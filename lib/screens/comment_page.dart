import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/components/comment_box.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/controllers/comment_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/login_alert.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

class CommentPage extends StatefulWidget {
  final NewFeed newFeed;
  final CommentController commentController = CommentController();
  CommentPage(this.newFeed);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = [];
  bool _hasMore = true;
  bool _isLoading = true;

  @override
  void initState() {
    _hasMore = true;
    _isLoading = true;
    super.initState();
    _loadItems(0);
  }

  void _loadItems(int index) {
    _isLoading = true;
    widget.commentController
        .fetchComment(widget.newFeed.id, index)
        .then((data) {
      if (data == null || data.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasMore = true;
          comments.addAll(data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cmtController = TextEditingController();
    final Account owner =
        Provider.of<AuthController>(context, listen: false).owner;
    Future _onSubmit() async {
      Comment newComment = Comment(
        images: [],
        movies: [],
        profilePhoto: owner.profilePhoto,
        postId: widget.newFeed.id,
        commentsContent: cmtController.text,
        userFullName: owner.fullName,
        userId: owner.id,
      );

      final String token = owner.token;

      try {
        final result = await Dio().post(
          '$kServerApiUrl/comments',
          data: newComment.toMap(),
          options: new Options(
              contentType: "application/x-www-form-urlencoded",
              headers: {
                'charset': 'utf-8',
                'Authorization': 'Bearer ' + token
              }),
        );

        if (result.statusCode != 200) {
          Alert(
                  context: context,
                  title: 'Lỗi',
                  content: Text(
                    'Không gởi được',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  type: AlertType.error)
              .show();
        } else {
          // update for local device only
          newComment.user = owner;

          setState(() {
            comments.add(newComment);
          });
        }
      } catch (err) {
        Alert(
                context: context,
                title: 'Lỗi',
                content: Text(
                  'Không gởi được',
                  style: Theme.of(context).textTheme.body1,
                ),
                type: AlertType.error)
            .show();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightColor,
        centerTitle: true,
        title: Text('Bình luận'),
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: <Widget>[
                AccountBar(
                  account: widget.newFeed.user,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    widget.newFeed.newFeedContent,
                    softWrap: true,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: widget.commentController.hasMore
                      ? comments.length + 1
                      : comments.length,
                  itemBuilder: (context, id) {
                    if (id >= comments.length &&
                        widget.commentController.hasMore) {
                      if (!_isLoading) {
                        _loadItems(id);
                      }
                      return Center(child: LoadingFadingLine.circle());
                    }
                    if (_hasMore &&
                        _isLoading &&
                        widget.commentController.hasMore) {
                      return LoadingFadingLine.circle();
                    }
                    return CommentBox(comments[id], controller: cmtController);
                  },
                ),
                SizedBox(
                  height: 80.0,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
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
          minLines: 1,
          maxLines: 3,
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
                if (owner == null) {
                  LoginAlert(context: context, title: 'Đăng nhập').alert.show();
                } else if (cmtController.text.isEmpty) {
                  Alert(
                    context: context,
                    closeFunction: () {},
                    title: 'Bình luận rỗng',
                    content: Text(
                      'Bạn đang gởi một bình luận không có nội dung.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ).show();
                } else {
                  //fsdf
                  print('Alo');
                  _onSubmit();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
