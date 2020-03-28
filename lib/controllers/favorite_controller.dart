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
    await fetchAnnouce(accountId);
    List<NewFeed> news;
    try {
      news = await NewFeedController()
          .fetchIds(announce.favorites.sublist(0, _limit));
    } catch (e) {
      news = await NewFeedController().fetchIds(announce.favorites.sublist(0));
    }

    if (news != null && news.isNotEmpty)
      feeds = news;
    else if (_limit > feeds.length) hasMore = false;
    print('Announce From Top: ${announce.favorites}');

    notifyListeners();
  }

  Future fetchNews(String accountId, int id) async {
    await fetchAnnouce(accountId);

    List<String> ids = [];
    try {
      ids = announce.favorites.sublist(id, id + _limit);
    } catch (err) {
      ids = announce.favorites.sublist(id);
    }

    final news = await NewFeedController().fetchIds(ids);

    if (news != null && news.isNotEmpty)
      feeds.addAll(news);
    else if (_limit + id > feeds.length) hasMore = false;
    print('Announce From IDs: ${announce.favorites}');

    notifyListeners();
  }

  get length => announce.favorites.length;

  getAll() => feeds;

  // FIXME: remove accountId
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
    return result.statusCode == 200;
  }

  // FIXME: remove accountId

  Future<bool> unLike(String authToken, String feed, String accountId) async {
    if (announce == null) fetchAnnouce(accountId);

    authToken = 'Bearer ' + authToken;

    Response result = await Dio().delete(
      '$kServerApiUrl/announces',
      data: {'favorite': feed},
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          'charset': 'utf-8',
          // FIXME: dump auth
          'Authorization': authToken
        },
      ),
    );
    return result.statusCode == 200;
  }

  // Future fetchTopFeeds(String accountId) async {
  //   if (announce == null) await fetchAnnouce(accountId);

  //   final List<NewFeed> newfeeds = await NewFeedController()
  //       .fetchIds(announce.getItems(limit: _limit, page: count ~/ 10));

  //   count += newfeeds.length;

  //   if (announce.favorites.length <= count) hasMore = false;

  //   return newfeeds != null ? newfeeds : null;
  // }
}
