import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<File> _takeImage() async {
  File x = await ImagePicker.pickImage(
    source: ImageSource.camera,
    maxHeight: 1024,
    maxWidth: 1024,
  );
  return x;
}

Future<File> _pickImage() async {
  File x = await ImagePicker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 1024,
    maxWidth: 1024,
  );
  return x;
}

class ChooseImage extends Alert {
  String title;
  BuildContext context;

  ChooseImage({
    @required this.title,
    @required this.context,
    @required Function setImage,
  }) : super(
          title: title,
          context: context,
          buttons: [
            DialogButton(
              onPressed: () async {
                Navigator.of(context).pop();
                File x = await _takeImage();
                setImage(x);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.camera, size: 20.0),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      'Chụp ảnh mới',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
            DialogButton(
              onPressed: () async {
                Navigator.of(context).pop();
                File x = await _pickImage();
                setImage(x);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.photo, size: 20.0),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      'Có sẵn',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
}
