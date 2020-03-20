import 'package:flutter/foundation.dart';

class Comment {
  String commentsId;
  DateTime createdAt;
  DateTime updatedAt;
  String postId;
  String content;
  List<String> images;
  List<String> movies;

  // Additions
  String profilePhoto;
  String userFullName;
  String userId;

  Comment(
      {commentsContent,
      commentsId,
      movies,
      images,
      postId,
      this.profilePhoto,
      this.userFullName,
      @required this.userId})
      : this.commentsId = commentsId,
        this.content = commentsContent,
        this.createdAt = DateTime.now(),
        this.updatedAt = DateTime.now(),
        this.images = images != null ? images : [],
        this.movies = movies != null ? movies : [],
        this.postId = postId;

  Comment.fromJson(Map<String, dynamic> parsedJson) {
    commentsId = parsedJson['_id'];
    createdAt = DateTime.tryParse(parsedJson["createdAt"]);
    updatedAt = DateTime.tryParse(parsedJson["updatedAt"]);
    postId = parsedJson['postId'];
    content = parsedJson['commentsContent'];
    profilePhoto = parsedJson['profilePhoto'];
    userFullName = parsedJson['userFullName'];
    userId = parsedJson['userId'];
    images = parsedJson['images'];
    movies = parsedJson['movies'];
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
