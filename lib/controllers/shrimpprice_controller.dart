import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/ShrimpPrice.dart';
import 'package:http/http.dart' as http;

class ShrimpPriceController extends ChangeNotifier {
  List<ShrimpPrice> _prices = [];

  Future<List<ShrimpPrice>> fetchAll() async {
    try {
      final data = await http.get('$kServerApiUrl/shrimp-prices');
      final parsedJson = json.decode(data.body);
      final List<ShrimpPrice> results = parsedJson['data']
          .map<ShrimpPrice>((e) => ShrimpPrice.fromMap(e))
          .toList();
      return results;
    } catch (err) {
      return null;
    }
  }

  ShrimpPriceController({List<ShrimpPrice> articles}) : this._prices = articles;

  void addFirst(Iterable<ShrimpPrice> items) {
    this._prices.insertAll(0, items);
    notifyListeners();
  }

  void set(List<ShrimpPrice> items) {
    this._prices = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._prices.length > 0) {
      this._prices.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._prices.length > 0) {
      this._prices.removeAt(this._prices.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._prices.removeRange(start, end);
  }

  List<ShrimpPrice> getAll() => [...this._prices];
}
