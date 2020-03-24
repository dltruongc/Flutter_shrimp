import '../models/Role.dart';
import 'Farmer.dart';
import 'Researcher.dart';
import 'Retailer.dart';

class Account {
  String id;
  String username;
  bool isMale;
  DateTime birth;
  String profilePhoto;
  String coverPhoto;
  Role role;
  String phone;
  String fullName;
  String address;
  DateTime createdAt;
  DateTime updatedAt;
  String story;
  final String _password;
  Retailer retailer;
  Farmer farmer;
  Researcher researcher;
  // FIXME: auth token
  //token: { type: String },
  //expiredToken: Date,
  //salt: String

  Account({
    id,
    username,
    bool isMale,
    birth,
    role,
    phone,
    address,
    createdAt,
    String profilePhoto,
    updatedAt,
    password,
    story,
    this.retailer,
    this.farmer,
    this.researcher,
  })  : id = id,
        username = username,
        birth = birth,
        role = Role(role),
        phone = phone,
        address = address,
        updatedAt = updatedAt,
        createdAt = createdAt,
        isMale = isMale,
        story = story,
        _password = password ?? null,
        profilePhoto = profilePhoto;

  Account.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['_id'],
        this.username = parsedJson['accountUserName'],
        this.isMale = parsedJson['isMale'],
        this.birth = parsedJson['birth'] != null
            ? DateTime.tryParse(parsedJson['birth'])
            : null,
        this._password = null,
        this.role = Role.fromInt(parsedJson['roleId']),
        createdAt = parsedJson["updatedAt"] != null
            ? DateTime.tryParse(parsedJson["createdAt"])
            : null,
        updatedAt = parsedJson["updatedAt"] != null
            ? DateTime.tryParse(parsedJson["updatedAt"])
            : null {
    String role = Role.fromInt(parsedJson['roleId']).toString();

    if (parsedJson[role] != null) {
      this.fullName = parsedJson[role]['${role}Fullname'] ??
          parsedJson[role]['${role}Name'];
      this.profilePhoto = parsedJson['profilePhoto'];
      this.phone = parsedJson[role]['${role}PhoneNumber'];
      this.address = parsedJson[role]['${role}Address'];
      this.story = parsedJson[role]['${role}Story'] ?? null;
    } else {
      this.fullName = 'Chưa có tên';
      this.phone = 'Không có số liên lạc';
      this.address = 'Không có địa chỉ';
      this.story = 'Chưa có câu chuyện';
    }
    this.retailer = parsedJson['retailer'] != null
        ? Retailer.fromJson(parsedJson['retailer'])
        : null;
    this.farmer = parsedJson['farmer'] != null
        ? Farmer.fromJson(parsedJson['farmer'])
        : null;
    this.researcher = parsedJson['researcher'] != null
        ? Researcher.fromJson(parsedJson['researcher'])
        : null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountUserName': username,
      'accountPassword': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isMale': isMale,
      'birth': birth,
      'roleId': role.toInt(),
      'retailer': retailer != null ? retailer.toMap() : null,
      'farmer': farmer != null ? farmer.toMap() : null,
      'researcher': researcher != null ? researcher.toMap() : null,
    };
  }

  String get shortName {
    List spl = fullName.split(' ');
    String x =
        spl.sublist(0, spl.length - 1).map((x) => x[0]).join('').toString();
    return x + spl.last;
  }

  String get password => _password;
}
