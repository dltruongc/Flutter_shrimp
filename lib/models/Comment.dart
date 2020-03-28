import 'package:flutter/foundation.dart';
import 'package:shrimpapp/models/Account.dart';

class Comment {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String postId;
  String content;
  List images;
  List movies;

  // Additions
  String profilePhoto;
  String userFullName;
  String userId;
  Account user;

  Comment(
      {commentsContent,
      id,
      movies,
      images,
      postId,
      this.profilePhoto,
      this.userFullName,
      @required this.userId})
      : this.id = id,
        this.content = commentsContent,
        this.createdAt = DateTime.now(),
        this.updatedAt = DateTime.now(),
        this.images = images != null ? images : [],
        this.movies = movies != null ? movies : [],
        this.postId = postId;

  Comment.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['_id'];
    createdAt = parsedJson["updatedAt"] != null
        ? DateTime.tryParse(parsedJson["createdAt"])
        : null;
    updatedAt = parsedJson["updatedAt"] != null
        ? DateTime.tryParse(parsedJson["updatedAt"])
        : null;
    postId = parsedJson['postId'];
    content = parsedJson['commentsContent'];
    profilePhoto = parsedJson['profilePhoto'];
    userFullName = parsedJson['userFullName'];
    userId = parsedJson['userId'];
    images = parsedJson['images'].isNotEmpty
        ? parsedJson['images'].map<String>((e) => e.toString()).toList()
        : [];
    movies = parsedJson['movies'].isNotEmpty
        ? parsedJson['movies'].map<String>((e) => e.toString()).toList()
        : [];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'postId': postId,
      'commentsContent': content,
      'images': images,
      'movies': movies,
      'profilePhoto': profilePhoto,
      'userFullName': userFullName,
      'userId': userId,
    };
  }
}
