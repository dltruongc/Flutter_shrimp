import 'package:flutter/material.dart';
import 'package:shrimpapp/models/News.dart';

class NewsController extends ChangeNotifier {
  List<News> _news = [];

  NewsController(this._news);

  void addFirst(Iterable<News> items) {
    this._news.insertAll(0, items);
    notifyListeners();
  }

  void set(List<News> items) {
    this._news = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._news.length > 0) {
      this._news.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._news.length > 0) {
      this._news.removeAt(this._news.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._news.removeRange(start, end);
  }

  List<News> getAll() => [...this._news];
}
