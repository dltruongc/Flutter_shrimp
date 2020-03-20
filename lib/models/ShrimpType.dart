class ShrimpType {
  String id;
  String shrimpTypeName;
  String shrimpTypeDescription;
  DateTime createdAt;
  DateTime updatedAt;

  ShrimpType({
    this.id,
    this.shrimpTypeName,
    this.shrimpTypeDescription,
    this.createdAt,
    this.updatedAt,
  });

  ShrimpType.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        shrimpTypeName = map['shrimpTypeName'],
        shrimpTypeDescription = map['shrimpTypeDescription'] {
    createdAt = DateTime.tryParse(map["createdAt"]);
    updatedAt = DateTime.tryParse(map["updatedAt"]);
  }
}
