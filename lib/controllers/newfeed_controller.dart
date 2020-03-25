import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/account_controller.dart';
import 'package:shrimpapp/models/Account.dart';
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

      AccountController accountController = AccountController();

      if (results.isEmpty)
        hasMore = false;
      else {
        // Query for accounts
        final accounts = await accountController
            .fetchAccounts(results.map((e) => e.accountId).toList());
        // Include account into newfeed
        for (int i = 0; i < results.length; i++) {
          try {
            results[i].user =
                accounts.firstWhere((e) => e.id == results[i].accountId);
          } catch (e) {}
        }
        _newFeeds.addAll(results);
      }

      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }

  Future fetchId(String id) async {
    try {
      // FIXME: sort=-id
      final data = await http.get('$kServerApiUrl/newfeeds/$id');
      final parsedJson = json.decode(data.body);
      final NewFeed result = NewFeed.fromMap(parsedJson['data'].first);

      AccountController accountController = AccountController();
      result.user = await accountController.fetchAccount(result.accountId);
      return result;
    } catch (err) {
      return null;
    }
  }

  NewFeed _localFind(String id) {
    try {
      var result = _newFeeds.firstWhere((account) => account.id == id);
      return result;
    } catch (err) {
      return null;
    }
  }

  _localIds(List<String> ids) {
    // deep copy another list. To exclude exist ids;
    final excludes = [...ids];
    // Find all from local
    List<NewFeed> _localData = [];
    ids.forEach((id) {
      final result = _localFind(id);
      // exclude ids that exist locally
      if (result != null) {
        _localData.add(result);
        excludes.remove(id);
      }
    });
    return {"data": _localData, "excludes": excludes};
  }

  Future<List<NewFeed>> fetchIds(List<String> ids) async {
    // local find
    final local = _localIds(ids);

    final List<String> excludes = local['excludes'];
    final List<NewFeed> _localData = local['data'];

    if (excludes.isEmpty) return _localData;

    try {
      String queryString = excludes.map((e) => 'newfeeds[]=$e').join('&');

      // FIXME: sort=-id
      final data = await http.get('$kServerApiUrl/newfeeds/find?$queryString');
      final parsedJson = json.decode(data.body);

      final List<NewFeed> results =
          parsedJson['data'].map<NewFeed>((e) => NewFeed.fromMap(e)).toList();

      AccountController accountController = AccountController();
      // Query for accounts
      final List<Account> accounts = await accountController
          .fetchAccounts(results.map((e) => e.accountId).toList());
      // Include account into newfeed
      for (int i = 0; i < results.length; i++) {
        try {
          results[i].user =
              accounts.firstWhere((e) => e.id == results[i].accountId);
        } catch (e) {}
      }
      return results;
    } catch (err) {
      return null;
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
