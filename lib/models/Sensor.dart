import 'package:flutter/foundation.dart';

enum SensorType { WaterTemperature, DeliveryOrder, Salinity }

class Sensor {
  DateTime createdAt;
  String name;
  String parameter;
  double value;
  String unit;

  /// Addition info: `SensorType`.
  SensorType type;

  Sensor({
    @required this.type,
    this.createdAt,
    this.name,
    this.parameter,
    this.value,
    this.unit,
  });

  Sensor.fromMap(Map<String, dynamic> parsedJson)
      : createdAt = DateTime.parse(parsedJson['created_at']),
        name = parsedJson['name'],
        parameter = parsedJson['parameter'],
        value = parsedJson['value'].toDouble(),
        unit = parsedJson['unit'] {
    switch (parsedJson['parameter']) {
      case 'water-temperature':
        type = SensorType.WaterTemperature;
        break;
      case 'salinity':
        type = SensorType.Salinity;
        break;
      case 'do':
        type = SensorType.DeliveryOrder;
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'name': name,
      'parameter': parameter,
      'value': value,
      'unit': unit,
    };
  }
}

// [
//   {
//     "created_at": "2020-01-16T23:12:15+07:00",
//     "name": "Nhiệt độ nước (oC)",
//     "parameter": "water-temperature",
//     "value": 28.5,
//     "unit": "oC"
//   },
//   {
//     "created_at": "2020-01-16T23:12:15+07:00",
//     "name": "Oxy hòa tan (mg/l)",
//     "parameter": "do",
//     "value": 7.14,
//     "unit": "mg/l"
//   },
//   {
//     "created_at": "2020-01-16T23:12:15+07:00",
//     "name": "Độ mặn (ppt)",
//     "parameter": "salinity",
//     "value": 6.68,
//     "unit": "ppt"
//   }
// ];
