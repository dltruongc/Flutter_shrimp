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
    createdAt =
        map["updatedAt"] != null ? DateTime.tryParse(map["createdAt"]) : null;
    updatedAt =
        map["updatedAt"] != null ? DateTime.tryParse(map["updatedAt"]) : null;
  }
}
