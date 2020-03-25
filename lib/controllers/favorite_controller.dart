import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/Announce.dart';
import 'package:shrimpapp/models/NewFeed.dart';

class FavoriteController extends ChangeNotifier {
  static Announce announce;
  List<NewFeed> feeds = [];
  bool hasMore = true;
  final int _limit = 10;

  Future fetchAnnouce(String accountId) async {
    try {
      final data =
          await http.get('$kServerApiUrl/announces?accountId=$accountId');
      final parsedJson = json.decode(data.body);
      announce = Announce.fromMap(parsedJson['data'].first);
    } catch (err) {
      print(err);
    }
  }

  Future fetchTop(String accountId) async {
    if (announce == null) {
      await fetchAnnouce(accountId);
    }

    final news = await NewFeedController()
        .fetchIds(announce.favorites.sublist(0, _limit));
    if (news != null && news.isNotEmpty)
      feeds.addAll(news);
    else if (_limit > feeds.length) hasMore = false;

    notifyListeners();
  }

  Future fetchNews(String accountId, int id) async {
    if (announce == null) {
      await fetchAnnouce(accountId);
    }

    List<String> ids = [];
    try {
      ids = announce.favorites.sublist(id, id + _limit);
    } catch (err) {
      ids = announce.favorites.sublist(id);
    }

    final news = await NewFeedController().fetchIds(ids);

    print("ID : $id \t NEW LENGTH: ${news.length}");
    if (news != null && news.isNotEmpty)
      feeds.addAll(news);
    else if (_limit + id > feeds.length) hasMore = false;

    notifyListeners();
  }

  get length => announce.favorites.length;

  getAll() => feeds;

  // Future fetchTopFeeds(String accountId) async {
  //   if (announce == null) await fetchAnnouce(accountId);

  //   final List<NewFeed> newfeeds = await NewFeedController()
  //       .fetchIds(announce.getItems(limit: _limit, page: count ~/ 10));

  //   count += newfeeds.length;

  //   if (announce.favorites.length <= count) hasMore = false;

  //   return newfeeds != null ? newfeeds : null;
  // }
}
