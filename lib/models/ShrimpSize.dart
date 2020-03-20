class ShrimpSize {
  String id;
  String shrimpSizeQuantity;
  String shrimpSizeUnit;
  DateTime createdAt;
  DateTime updatedAt;

  ShrimpSize({
    this.id,
    this.shrimpSizeQuantity,
    this.shrimpSizeUnit,
    this.createdAt,
    this.updatedAt,
  });

  ShrimpSize.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        shrimpSizeQuantity = map['shrimpSizeQuantity'],
        shrimpSizeUnit = map['shrimpSizeUnit'] ?? '',
        createdAt = DateTime.tryParse(map['createdAt']),
        updatedAt = DateTime.tryParse(map['updatedAt']);

  @override
  String toString() {
    return '${this.shrimpSizeQuantity} ${this.shrimpSizeUnit}';
  }
}
