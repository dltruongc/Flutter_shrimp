import 'package:flutter/material.dart';
import 'package:shrimpapp/models/NewFeed.dart';

class NewFeedController extends ChangeNotifier {
  List<NewFeed> _newFeeds = [];

  NewFeedController(this._newFeeds);

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
