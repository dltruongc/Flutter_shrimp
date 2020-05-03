import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/ShrimpPriceAdded.dart';
import 'package:http/http.dart' as http;

class ShrimpPriceAddedController extends ChangeNotifier {
  List<ShrimpPriceAdded> _prices = [];

  Future<List<ShrimpPriceAdded>> fetchAll() async {
    final data = await http.get('$kServerUrl/shrimppricesadded');
    try {
      final parsedJson = json.decode(data.body);
      final List<ShrimpPriceAdded> results = parsedJson
          .map<ShrimpPriceAdded>((e) => ShrimpPriceAdded.fromMap(e))
          .toList();
      return results;
    } catch (err) {
      print('ERROR: $err');
      return null;
    }
  }

  ShrimpPriceAddedController({List<ShrimpPriceAdded> articles})
      : this._prices = articles;

  void addFirst(Iterable<ShrimpPriceAdded> items) {
    this._prices.insertAll(0, items);
    notifyListeners();
  }

  void set(List<ShrimpPriceAdded> items) {
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

  List<ShrimpPriceAdded> getAll() => [...this._prices];
}
