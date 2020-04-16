import 'dart:convert';

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/account_controller.dart';
import 'package:shrimpapp/models/Comment.dart';
import 'package:http/http.dart' as http;

class CommentController {
  final List<Comment> comments = [];
  bool hasMore = true;
  int _limit = 10;

  CommentController();

  Future<List<Comment>> fetchComment(String newFeedId, int index) async {
    int page = comments != null ? (comments.length ~/ 10) + 1 : 1;
    if (index < comments.length) return null;

    try {
      final data = await http.get(
          '$kServerApiUrl/comments?limit=$_limit&page=$page&sort=-_id&postId=$newFeedId');
      final parsedJson = json.decode(data.body);
      final List<Comment> results =
          parsedJson['data'].map<Comment>((e) => Comment.fromJson(e)).toList();

      AccountController accountController = AccountController();

      // Query for accounts
      final accounts = await accountController
          .fetchAccounts(results.map((e) => e.userId).toList());
      // Include account into newfeed
      for (int i = 0; i < results.length; i++) {
        try {
          results[i].user =
              accounts.firstWhere((e) => e.id == results[i].userId);
        } catch (e) {}
      }

      if (results.length < _limit) hasMore = false;
      comments.addAll(results);
      return results;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
