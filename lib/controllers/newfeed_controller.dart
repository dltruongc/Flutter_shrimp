import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/account_controller.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:http/http.dart' as http;

class NewFeedController extends ChangeNotifier {
  List<NewFeed> _newFeeds = [];
  final int _limit = 10;
  bool hasMore = true;

  NewFeedController({List<NewFeed> newFeeds}) : this._newFeeds = newFeeds ?? [];

  Future fetchTop() async {
    int page = _newFeeds != null ? (_newFeeds.length ~/ 10) + 1 : 1;
    try {
      // FIXME: sort=-id
      final data =
          await http.get('$kServerApiUrl/newfeeds?limit=$_limit&page=$page');
      final parsedJson = json.decode(data.body);
      final List<NewFeed> results =
          parsedJson['data'].map<NewFeed>((e) => NewFeed.fromMap(e)).toList();
      _newFeeds.addAll(results);

      AccountController accountController = AccountController();
      for (int i = 0; i < results.length; i++) {
        results[i].user =
            await accountController.fetchAccount(results[i].accountId);
      }

      if (results.isEmpty) hasMore = false;
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

  int get length => _newFeeds.length;

  void addFirst(Iterable<NewFeed> items) {
    this._newFeeds.insertAll(0, items);
    notifyListeners();
  }

  void set(List<NewFeed> items) {
    this._newFeeds = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._newFeeds.length > 0) {
      this._newFeeds.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._newFeeds.length > 0) {
      this._newFeeds.removeAt(this._newFeeds.length - 1);
    }
    notifyListeners();
  }

  /// Removes the objects in the range [start] inclusive to [end] exclusive.
  void removeMany(int start, int end) {
    this._newFeeds.removeRange(start, end);
  }

  List<NewFeed> getAll() => [...this._newFeeds];
}
