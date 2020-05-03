class ShrimpPriceAdded {
  final String sizeType;
  final num price;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShrimpPriceAdded({
    this.sizeType,
    this.price,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory ShrimpPriceAdded.fromMap(Map<String, dynamic> parsedJson) {
    return ShrimpPriceAdded(
      sizeType: parsedJson['shrimpTypeSize'],
      price: parsedJson['shrimpPrice'],
      date: DateTime.tryParse(parsedJson['shrimpPriceDate']),
      createdAt: DateTime.tryParse(parsedJson['createdAt']),
      updatedAt: DateTime.tryParse(parsedJson['updatedAt']),
    );
  }

  Map get toMap => {
        'shrimpTypeSize': sizeType,
        'shrimpPrice': price,
        'shrimpPriceDate': date,
        'createdAt': createdAt ?? DateTime.now(),
        'updatedAt': updatedAt ?? DateTime.now(),
      };
}
