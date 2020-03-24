import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:http/http.dart' as http;

class NewsController extends ChangeNotifier {
  static List<News> _articles = [];
  final int _limit = 10;

  Future<List<News>> fetchAll() async {
    try {
      int page = (_articles.length ~/ 10) + 1;
      final data = await http
          .get('$kServerApiUrl/news?limit=$_limit&page=$page&sort=-_id');
      await Future.delayed(Duration(seconds: 3));
      final parsedJson = json.decode(data.body);
      final List<News> results =
          parsedJson['data'].map<News>((e) => News.fromJson(e)).toList();
      _articles.addAll(results);
      return results;
    } catch (err) {
      return null;
    }
  }

  NewsController();

  void addFirst(Iterable<News> items) {
    _articles.insertAll(0, items);
    notifyListeners();
  }

  void set(List<News> items) {
    _articles = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (_articles.length > 0) {
      _articles.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (_articles.length > 0) {
      _articles.removeAt(_articles.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    _articles.removeRange(start, end);
  }

  List<News> getAll() => [..._articles];
}
