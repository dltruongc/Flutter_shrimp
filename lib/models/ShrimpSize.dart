class ShrimpSize {
  String id;
  String shrimpSizeQuantity;
  String shrimpSizeUnit;
  DateTime createdAt;
  DateTime updatedAt;

  ShrimpSize.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        shrimpSizeQuantity = map['shrimpSizeQuantity'],
        shrimpSizeUnit = map['shrimpSizeUnit'] ?? '' {
    createdAt =
        map["updatedAt"] != null ? DateTime.tryParse(map["createdAt"]) : null;
    updatedAt =
        map["updatedAt"] != null ? DateTime.tryParse(map["updatedAt"]) : null;
  }

  ShrimpSize({
    this.id,
    this.shrimpSizeQuantity,
    this.shrimpSizeUnit,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return '${this.shrimpSizeQuantity} ${this.shrimpSizeUnit}';
  }
}
