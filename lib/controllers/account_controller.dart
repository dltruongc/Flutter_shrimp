import 'dart:convert';

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:http/http.dart' as http;

class AccountController {
  static final List<Account> accounts = [];

  AccountController();

  Future<Account> fetchAccount(String id) async {
    try {
      var result = accounts.firstWhere((account) => account.id == id);
      return result;
    } catch (err) {}

    try {
      final data = await http.get('$kServerApiUrl/accounts/$id');
      final parsedJson = json.decode(data.body);
      final Account result = Account.fromJson(parsedJson['data'].first);
      accounts.add(result);
      return result;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
