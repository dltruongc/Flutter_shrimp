import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:http/http.dart' as http;

class NewsController extends ChangeNotifier {
  List<News> _articles = [];

  Future<List<News>> fetchAll() async {
    try {
      final data = await http.get('$kServerApiUrl/news');
      final parsedJson = json.decode(data.body);
      final List<News> results =
          parsedJson['data'].map<News>((e) => News.fromJson(e)).toList();
      return results;
    } catch (err) {
      return null;
    }
  }

  NewsController({List<News> articles}) : this._articles = articles;

  void addFirst(Iterable<News> items) {
    this._articles.insertAll(0, items);
    notifyListeners();
  }

  void set(List<News> items) {
    this._articles = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._articles.length > 0) {
      this._articles.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._articles.length > 0) {
      this._articles.removeAt(this._articles.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._articles.removeRange(start, end);
  }

  List<News> getAll() => [...this._articles];
}
