import 'package:flutter/foundation.dart';
import 'package:shrimpapp/constants.dart';

class ServerAddress {
  static String getUrl({@required path}) {
    return '$kServerUrl' + '$path';
  }
}
