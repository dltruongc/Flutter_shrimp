class News {
  String id;
  String title;
  String url;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  News({
    this.id,
    this.title,
    this.url,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  News.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    title = parsedJson['title'];
    url = parsedJson['url'];
    image = null;
    createdAt = DateTime.tryParse(parsedJson['createdAt']);
    updatedAt = DateTime.tryParse(parsedJson['updatedAt']);
  }
}
