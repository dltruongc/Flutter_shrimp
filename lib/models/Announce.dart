class Announce {
  String id;
  String accountId;
  List<String> favorites;

  Announce(this.id, this.accountId, this.favorites);

  Announce.fromMap(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['_id'];
    this.accountId = parsedJson['accountId'];
    this.favorites = List<String>.from(parsedJson['favorites']);
  }

  getItems({int limit = 10, int page = 1}) {
    return favorites.sublist((page - 1) * limit, page * limit);
  }
}
