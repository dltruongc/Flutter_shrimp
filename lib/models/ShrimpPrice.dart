import '../models/ShrimpSize.dart';
import '../models/ShrimpType.dart';

class ShrimpPrice {
  String id;
  ShrimpType shrimpType;
  ShrimpSize shrimpSize;
  num price;
  DateTime shrimpPriceDate;
  DateTime createdAt;
  DateTime updatedAt;

  /// Addition: `typeId`, `sizeId` references to `ShrimpTypeId`
  /// and `ShrimpSizeId`
  String typeId;
  String sizeId;

  ShrimpPrice({
    this.id,
    this.shrimpType,
    this.shrimpSize,
    this.price,
    this.shrimpPriceDate,
    this.createdAt,
    this.updatedAt,
    this.sizeId,
    this.typeId,
  });

  ShrimpPrice.fromMap(Map<String, dynamic> parsedJson) {
    id = parsedJson["_id"];

    typeId = parsedJson['shrimpTypeId'];
    sizeId = parsedJson['shrimpSizeId'];
    price = parsedJson["price"];
    shrimpPriceDate = DateTime.tryParse(parsedJson["shrimpPriceDate"]);
    createdAt = DateTime.tryParse(parsedJson["createdAt"]);
    updatedAt = DateTime.tryParse(parsedJson["updatedAt"]);
  }
}
