import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shrimpapp/models/Sensor.dart';
import 'package:http/http.dart' as http;
import 'package:shrimpapp/secret.dart';

class SensorController extends ChangeNotifier {
  List<Sensor> _sensor = [];

  Future<List<Sensor>> fetchNew() async {
    try {
      final data = await http.get(SecretKeys.sensorUrl);
      final parsedJson = json.decode(data.body);
      List<Sensor> sensors =
          parsedJson.map<Sensor>((item) => Sensor.fromMap(item)).toList();
      return sensors;
    } catch (err) {
      print('Sensor error: $err');
      return null;
    }
  }

  SensorController({List<Sensor> articles}) : this._sensor = articles;

  void addFirst(Iterable<Sensor> items) {
    this._sensor.insertAll(0, items);
    notifyListeners();
  }

  void set(List<Sensor> items) {
    this._sensor = [...items];
    notifyListeners();
  }

  void removeFirst() {
    if (this._sensor.length > 0) {
      this._sensor.removeAt(0);
    }
    notifyListeners();
  }

  void removeLast() {
    if (this._sensor.length > 0) {
      this._sensor.removeAt(this._sensor.length - 1);
    }
    notifyListeners();
  }

  void removeMany(int start, int end) {
    this._sensor.removeRange(start, end);
  }

  List<Sensor> getAll() => [...this._sensor];
}
