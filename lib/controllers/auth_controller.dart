import 'package:flutter/foundation.dart';
import 'package:shrimpapp/models/Account.dart';

class AuthController extends ChangeNotifier {
  static Account _owner = Account.fromJson({
    "isMale": false,
    "birth": "2019-08-06T17:00:00.000Z",
    "createdAt": "2019-10-12T17:00:00.000Z",
    "updatedAt": "2019-12-02T17:00:00.000Z",
    "profilePhoto":
        "https://robohash.org/occaecatiquisunt.jpg?size=50x50&set=set1",
    "coverPhoto": "http://dummyimage.com/191x109.png/ff4444/ffffff",
    "farmer": {
      "farmerFullname": "Tobit Shorten",
      "farmerPhoneNumber": "552 387 9468",
      "farmerAddress": "6 Fordem Place",
      "farmerStory":
          "Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\n\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.",
      "accountId": 1,
      "_id": "5e7ca31be25843237006226e"
    },
    "retailer": null,
    "researcher": null,
    "token": null,
    "_id": "5e79c9eb93662543993416de",
    "roleId": 1
  });

  Account get owner => _owner;

  login() async {}

  register() async {}

  logout() async {}
}
