import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'account_bar.dart';

class CommentBox extends StatelessWidget {
  final Account user;
  final Comment comment;
  final TextEditingController controller;

  CommentBox(this.user, this.comment, {this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AccountBar(
            account: user,
            isThreeLine: false,
            subTitle: Text(
              DateFormatter.toVietNamString(comment.createdAt),
            ),
          ),
          // Divider(
          //   height: 8.0,
          //   thickness: 0.5,
          //   color: Colors.grey,
          // endIndent: 146.0,
          // indent: 68.0,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 68.0),
            child: MarkdownBody(data: comment.content),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              height: 16.0,
              child: FlatButton.icon(
                onPressed: () {
                  // TODO: implement reply
                  controller.text = '**@${user.username}** ${controller.text}';
                },
                icon: Icon(
                  Icons.reply,
                  size: 12.0,
                ),
                label: Text('Trả lời'),
                highlightColor: Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
