import 'package:flutter/material.dart';
import 'package:shrimpapp/secret.dart';

const kLightColor = Color(0xFF00A3B3);
const kGradientStartColor = Color(0xFF00A3B3);
const kDeepColor = Color(0xFF012A33);
const kGradientEndColor = Color(0xff22B1A9);
const kBodyTextColor = Colors.white;
const kDisplayTextColor = Colors.black;
const kPrimaryTextSize = 30.0;
final kServerUrl = SecretKeys.serverUrl;
final kServerApiUrl = kServerUrl + '/api/v1';
final kSensorUrl = SecretKeys.sensorUrl;

final textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.0),
  borderSide: BorderSide(
    color: Colors.black26,
    width: 0.5,
  ),
);

enum ValidStatus { OK, ERROR }
