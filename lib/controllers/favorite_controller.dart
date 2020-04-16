import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/Announce.dart';
import 'package:shrimpapp/models/NewFeed.dart';

class FavoriteController extends ChangeNotifier {
  Announce announce;
  List<NewFeed> feeds = [];
  bool hasMore = true;
  final int _limit = 10;
  int length = 0;
  NewFeedController newFeedController = NewFeedController();

  // DELETE owner ID
  Future<bool> findFeed(String feedId, String accountId) async {
    if (announce == null) await fetchAnnouce(accountId);
    try {
      final found = announce.favorites.firstWhere((e) => e == feedId);
      return found != null;
    } catch (err) {
      return false;
    }
  }

  clear() {
    feeds.clear();
    this.length = 0;
    this.hasMore = true;
    notifyListeners();
  }

  Future fetchAnnouce(String accountId) async {
    try {
      final data =
          await http.get('$kServerApiUrl/announces?accountId=$accountId');
      final parsedJson = json.decode(data.body);
      announce = Announce.fromMap(parsedJson['data'].first);
      length = announce.favorites.length;
      hasMore = announce.favorites.isNotEmpty;
    } catch (err) {
      print(err);
      length = 0;
    }
  }

  Future<List<NewFeed>> fetchTop(String accountId) async {
    await fetchAnnouce(accountId);

    if (announce.favorites.isEmpty) {
      hasMore = false;
      this.length = 0;
      notifyListeners();

      return [];
    }

    List<NewFeed> news;
    try {
      news = await newFeedController
          .fetchIds(announce.favorites.sublist(0, _limit));
    } catch (e) {
      news = await newFeedController.fetchIds(announce.favorites.sublist(0));
    }

    if (news != null && news.isNotEmpty)
      feeds = news;
    else if (_limit > news.length) {
      hasMore = false;
      this.length = news.length;
    }

    notifyListeners();
    return feeds;
  }

  Future<List<NewFeed>> fetchNews(String accountId, int id) async {
    await fetchAnnouce(accountId);

    List<String> ids = [];
    try {
      ids = announce.favorites.sublist(id, id + _limit);
    } catch (err) {
      ids = announce.favorites.sublist(id);
    }

    final news = await newFeedController.fetchIds(ids);

    if (news != null && news.isNotEmpty)
      feeds.addAll(news);
    else if (_limit + id > feeds.length) {
      hasMore = false;
      this.length = feeds.length;
    }
    // if (newFeedController.hasMore) {
    //   hasMore = false;
    //   this.length = feeds.length;
    // }
    notifyListeners();

    return news.isNotEmpty ? news : [];
  }

  getAll() => feeds;

  Future<bool> like(String authToken, String feed, String accountId) async {
    if (announce == null) fetchAnnouce(accountId);
    authToken = 'Bearer ' + authToken;
    Response result = await Dio().post(
      '$kServerApiUrl/announces',
      data: {'favorite': feed},
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {'charset': 'utf-8', 'Authorization': authToken},
      ),
    );

    if (result.statusCode == 200) {
      if (!announce.favorites.contains(feed)) announce.favorites.add(feed);
      return true;
    }
    return false;
  }

  Future<bool> unLike(String authToken, String feed, String accountId) async {
    if (announce == null) fetchAnnouce(accountId);

    authToken = 'Bearer ' + authToken;

    Response result = await Dio().delete(
      '$kServerApiUrl/announces',
      data: {'favorite': feed},
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {'charset': 'utf-8', 'Authorization': authToken},
      ),
    );
    if (result.statusCode == 200) {
      announce.favorites.removeWhere((x) => x == feed);
      return true;
    }
    return false;
  }

  // Future fetchTopFeeds(String accountId) async {
  //   if (announce == null) await fetchAnnouce(accountId);

  //   final List<NewFeed> newfeeds = await newFeedController
  //       .fetchIds(announce.getItems(limit: _limit, page: count ~/ 10));

  //   count += newfeeds.length;

  //   if (announce.favorites.length <= count) hasMore = false;

  //   return newfeeds != null ? newfeeds : null;
  // }
}
