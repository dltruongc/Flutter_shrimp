import 'package:flutter/foundation.dart';
import 'package:shrimpapp/models/Account.dart';

class AuthController extends ChangeNotifier {
  // FIXME: dump owner
  static Account _owner = Account.fromJson({
    "_id": "5e7d9468f715b13067a30f66",
    "isMale": null,
    "birth": null,
    "createdAt": "2020-03-27T02:42:18.700Z",
    "updatedAt": "2020-03-27T02:42:18.700Z",
    "profilePhoto": "/public/images/a.jpeg",
    "coverPhoto": "/public/images/b.jpeg",
    "farmer": {
      "farmerFullname": "DLTruong.c",
      "farmerPhoneNumber": "096x.xxx.307",
      "farmerAddress": "Vietnam",
      "farmerStory": "No story",
      "accountId": null,
      "_id": "5e7d9468f715b13067a30f65",
    },
    "retailer": null,
    "researcher": null,
    "token": null,
    "accountPassword":
        r"$2b$12$ihwkJcE7j6Cjn8cJ.72amuet5.6967Din6XWayhUvza3.0lRDxB/C",
    "accountUserName": "dltruongc",
    "roleId": 1,
    "salt": r"$2b$12$ihwkJcE7j6Cjn8cJ.72amu",
    "__v": 0
  });

  Account get owner => _owner;

  login() async {}

  register() async {}

  logout() async {}
}
