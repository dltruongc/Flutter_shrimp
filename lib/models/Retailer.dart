class Retailer {
  String retailerName;
  String retailerAddress;
  String retailerEmail;
  String retailerWebsite;
  String retailerPhoneNumber;
  String cityName;
//  DateTime createdAt;
//  DateTime updatedAt;

  Retailer({
    this.retailerName,
    this.retailerAddress,
    this.retailerEmail,
    this.retailerWebsite,
    this.retailerPhoneNumber,
    this.cityName,
//    this.createdAt,
//    this.updatedAt,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'retailerName': retailerName,
        'retailerAddress': retailerAddress,
        'retailerEmail': retailerEmail,
        'retailerWebsite': retailerWebsite,
        'retailerPhoneNumber': retailerPhoneNumber,
        'cityName': cityName,
//        'createdAt': createdAt,
//        'updatedAt': updatedAt,
      };

  Retailer.fromJson(Map<String, dynamic> parsedJson)
      : retailerName = parsedJson['retailerName'],
        retailerAddress = parsedJson['retailerAddress'],
        retailerEmail = parsedJson['retailerEmail'],
        retailerWebsite = parsedJson['retailerWebsite'],
        retailerPhoneNumber = parsedJson['retailerPhoneNumber'],
        cityName = parsedJson['cityName'];
//        createdAt = DateTime.tryParse(parsedJson["createdAt"]),
//        updatedAt = DateTime.tryParse(parsedJson["updatedAt"]);
}
