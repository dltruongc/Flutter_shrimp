import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shrimpapp/models/ShrimpPrice.dart';
import 'package:shrimpapp/models/ShrimpType.dart';

x() async {
  try {
    final data =
        await http.get('http://192.168.43.111:3000/api/v1/shrimp-types');
    final parsedJson = json.decode(data.body);
    final List<ShrimpType> results = parsedJson['data']
        .map<ShrimpType>((e) => ShrimpType.fromMap(e))
        .toList();
    print(results);
  } catch (err) {
    return null;
  }
}

void main() {
  x();
}
