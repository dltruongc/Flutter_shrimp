import 'dart:convert';

import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:http/http.dart' as http;

class AccountController {
  static final List<Account> accounts = [];

  AccountController();

  Future<Account> fetchAccount(String id) async {
    var result = _localId(id);
    if (result != null) return result;

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

  Account _localId(String id) {
    try {
      var result = accounts.firstWhere((account) => account.id == id);
      return result;
    } catch (err) {
      return null;
    }
  }

  _localIds(List<String> ids) {
    // deep copy another list. To exclude exist ids;
    final excludes = [...ids];
    // Find all from local
    List<Account> _localData = [];
    ids.forEach((id) {
      final result = _localId(id);
      // exclude ids that exist locally
      if (result != null) {
        _localData.add(result);
        excludes.remove(id);
      }
    });
    return {"data": _localData, "excludes": excludes};
  }

  Future<List<Account>> fetchAccounts(List<String> ids) async {
    final local = _localIds(ids);

    final List<String> excludes = local['excludes'];
    final List<Account> _localData = local['data'] as List<Account>;

    if (excludes.isEmpty) return local['data'];

    // Request to server
    try {
      String queryString = excludes.map((e) => r'accounts[]=' + e).join('&');
      final data = await http.get('$kServerApiUrl/accounts/find?$queryString');
      final parsedJson = json.decode(data.body);
      final List<Account> results = parsedJson['data'].map<Account>((e) {
        return Account.fromJson(e);
      }).toList();
      accounts.addAll(results);
      return _localData + results;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
