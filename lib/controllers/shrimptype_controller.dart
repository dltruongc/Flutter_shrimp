import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/ShrimpType.dart';
import 'package:http/http.dart' as http;

class ShrimpTypeController extends ChangeNotifier {
  List<ShrimpType> _types = [];

  Future<List<ShrimpType>> fetchAll() async {
    try {
      final data = await http.get('$kServerApiUrl/shrimp-types');
      final parsedJson = json.decode(data.body);
      final List<ShrimpType> results = parsedJson['data']
          .map<ShrimpType>((e) => ShrimpType.fromMap(e))
          .toList();
      return results;
    } catch (err) {
      return null;
    }
  }

  ShrimpTypeController({List<ShrimpType> articles}) : this._types = articles;

  void addFirst(Iterable<ShrimpType> items) {
    this._types.insertAll(0, items);
    notifyListeners();
  }

  void set(List<ShrimpType> items) {
    this._types = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._types.length > 0) {
      this._types.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._types.length > 0) {
      this._types.removeAt(this._types.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._types.removeRange(start, end);
  }

  List<ShrimpType> getAll() => [...this._types];
}
