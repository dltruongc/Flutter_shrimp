import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ImagePickAlert {
  static _getImage() {}
  static _takeImage() {}
  static Alert alert(BuildContext context, List<File> images) {
    return Alert(
      title: 'Thêm ảnh đại diện',
      context: context,
      closeFunction: () {},
      content: Text('Chụp ảnh mới hoặc chọn ảnh có sẵn'),
      buttons: [
        DialogButton(
          child: Text('Có sẵn'),
          onPressed: () {
            // TODO
            _getImage();
            Navigator.of(context).pop();
          },
        ),
        DialogButton(
          child: Text('Ảnh mới'),
          onPressed: () {
            // TODO
            _takeImage();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
