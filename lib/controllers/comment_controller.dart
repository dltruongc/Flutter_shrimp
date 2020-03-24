import 'dart:convert';

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/account_controller.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:http/http.dart' as http;

class CommentController {
  final List<Comment> comments = [];
  int _limit = 10;

  CommentController();

  Future<List<Comment>> fetchComment(String newFeedId) async {
    int page = comments != null ? (comments.length ~/ 10) + 1 : 1;
    try {
      final data = await http.get(
          '$kServerApiUrl/comments?limit=$_limit&page=$page&sort=-_id&postId=$newFeedId');
      final parsedJson = json.decode(data.body);
      final List<Comment> results =
          parsedJson['data'].map<Comment>((e) => Comment.fromJson(e)).toList();

      AccountController accountController = AccountController();

      for (int i = 0; i < results.length; i++) {
        results[i].user =
            await accountController.fetchAccount(results[i].userId);
      }

      comments.addAll(results);
      return results;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
