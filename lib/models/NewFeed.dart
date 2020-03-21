import 'package:shrimpapp/models/Comment.dart';

class NewFeed {
  String id;
  String accountId;
  String newFeedContent;
  String newFeedLocation;
  DateTime createdAt;
  DateTime updatedAt;
  List<Comment> comments;

  // new update
  String title;

  List images;
  List movies;
  int views;
  int favorites;

  // Addition
//  User user;

  NewFeed({
    this.id,
    this.accountId,
    this.newFeedContent,
    this.newFeedLocation,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.views = 0,
    images,
    movies,
    this.favorites = 0,
    cmt,
  })  : this.comments = (cmt != null) ? cmt : [],
        this.images = images != null ? images : [],
        this.movies = movies != null ? movies : [];

  NewFeed.fromMap(Map<String, dynamic> parsedJson) {
    id = parsedJson['_id'];
    accountId = parsedJson['accountId'];
    newFeedContent = parsedJson['newfeedContent'];
    newFeedLocation = parsedJson['newfeedLocation'];
    createdAt = parsedJson["updatedAt"] != null
        ? DateTime.tryParse(parsedJson["createdAt"])
        : null;
    updatedAt = parsedJson["updatedAt"] != null
        ? DateTime.tryParse(parsedJson["updatedAt"])
        : null;
    title = parsedJson['title'];
    images = parsedJson['images'];
    movies = parsedJson['movies'];
    views = parsedJson['views'];
    favorites = parsedJson['favorites'];
    comments = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {
      '_id': this.id,
      'accountId': this.accountId,
      'newfeedContent': this.newFeedContent,
      'newfeedLocation': this.newFeedLocation,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'title': this.title,
      'images': images,
      'movies': movies,
      'views': this.views,
      'favorites': this.favorites
    };
    return result;
  }
}
