import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/ShrimpSize.dart';
import 'package:http/http.dart' as http;

class ShrimpSizeController extends ChangeNotifier {
  List<ShrimpSize> _sizes = [];

  Future<List<ShrimpSize>> fetchAll() async {
    try {
      final data = await http.get('$kServerApiUrl/shrimp-sizes');
      final parsedJson = json.decode(data.body);
      final List<ShrimpSize> results = parsedJson['data']
          .map<ShrimpSize>((e) => ShrimpSize.fromMap(e))
          .toList();
      return results;
    } catch (err) {
      return null;
    }
  }

  ShrimpSizeController({List<ShrimpSize> articles}) : this._sizes = articles;

  void addFirst(Iterable<ShrimpSize> items) {
    this._sizes.insertAll(0, items);
    notifyListeners();
  }

  void set(List<ShrimpSize> items) {
    this._sizes = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._sizes.length > 0) {
      this._sizes.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._sizes.length > 0) {
      this._sizes.removeAt(this._sizes.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._sizes.removeRange(start, end);
  }

  List<ShrimpSize> getAll() => [...this._sizes];
}
