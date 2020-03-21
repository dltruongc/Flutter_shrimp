class Farmer {
  String farmerFullname;
  String farmerPhoneNumber;
  String farmerAddress;
  String farmerStory;
//  DateTime createdAt;
//  DateTime updatedAt;

  Farmer({
    this.farmerFullname,
    this.farmerPhoneNumber,
    this.farmerAddress,
    this.farmerStory,
//    this.createdAt,
//    this.updatedAt,
  });

  Farmer.fromJson(Map<String, dynamic> parsedJson)
      : this.farmerFullname = parsedJson['farmerFullname'],
        this.farmerPhoneNumber = parsedJson['farmerPhoneNumber'],
        this.farmerAddress = parsedJson['farmerAddress'],
        this.farmerStory = parsedJson['farmerStory'];
//        this.createdAt = DateTime.tryParse(parsedJson["createdAt"]),
//        this.updatedAt = DateTime.tryParse(parsedJson["updatedAt"]);

  Map<String, dynamic> toMap() => <String, dynamic>{
        'farmerFullname': farmerFullname,
        'farmerPhoneNumber': farmerPhoneNumber,
        'farmerAddress': farmerAddress,
        'farmerStory': farmerStory,
//        'createdAt': createdAt,
//        'updatedAt': updatedAt,
      };
}
