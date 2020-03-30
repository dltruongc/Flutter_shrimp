import 'package:flutter/foundation.dart';
import 'package:shrimpapp/models/Account.dart';

class AuthController extends ChangeNotifier {
  Account _owner;

  AuthController({Key key}) : super();

  Account get owner => _owner;

  setOwner(Account account) {
    this._owner = account;
    notifyListeners();
  }

  clear() {
    _owner = null;
    notifyListeners();
  }

  bool isExpired() => _owner.expiredToken.isBefore(DateTime.now());
}
