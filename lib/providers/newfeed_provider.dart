import 'dart:core';

import 'package:shrimpapp/models/NewFeed.dart';

class NewFeedProvider {
  List<NewFeed> feeds = [];

  NewFeedProvider() : feeds = [];

  clear() {
    feeds.clear();
  }

  List<NewFeed> addAll(List<NewFeed> newFeeds) {
    feeds.addAll(newFeeds);
    return feeds;
  }

  List<NewFeed> addFirst(NewFeed feed) {
    feeds.insert(0, feed);
    return feeds;
  }

  List<NewFeed> insert(NewFeed item, int index) {
    feeds.insert(index, item);
    return feeds;
  }

  List<NewFeed> removeAt(int index) {
    feeds.removeAt(index);

    return feeds;
  }
}

final NewFeedProvider newFeedProvider = NewFeedProvider();
