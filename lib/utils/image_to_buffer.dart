import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageToBuffer {
  static Future<List<String>> fromAssets(List<Asset> images) async {
    List<String> bufferResults;

    try {
      Iterable<Future<String>> buffers = images.map((img) async {
        ByteData x = await img.getThumbByteData(
            (1024 * img.originalWidth) ~/ img.originalHeight, 1024);
        return base64Encode(x.buffer.asUint8List());
      });
      Future<List<String>> futureList = Future.wait(buffers);
      bufferResults = await futureList;
    } catch (err) {
      bufferResults = [];
    }

    return bufferResults;
  }
}
