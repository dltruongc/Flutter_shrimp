import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shrimpapp/components/image_picker_type.dart';

class AvatarPicker extends StatefulWidget {
  final Function setImage;
  final Function setCoverImage;
  AvatarPicker({
    Key key,
    @required this.setImage,
    @required this.setCoverImage,
  }) : super(key: key);

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File image;
  File coverImage;

  loadImageAffect(File img) {
    print("IMAGE: ${img.path}");
    // widget.setImage(image);
    setState(() {
      image = img;
    });
    widget.setImage(image);
  }

  loadCoverImageAffect(File img) {
    // widget.setCoverImage(img);
    setState(() {
      coverImage = img;
    });
    widget.setCoverImage(coverImage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0, bottom: 16),
          height: 200,
          width: double.infinity,
          child: coverImage != null
              ? Image.file(
                  coverImage,
                  fit: BoxFit.cover,
                  height: 200,
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/weather_wall.png'),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                        Colors.teal.withOpacity(0.5),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 16),
          height: 160,
          width: 160,
          child: Stack(
            children: <Widget>[
              image == null
                  ? Container(
                      height: 150,
                      width: 150,
                      margin: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        border: Border.all(
                          color: Colors.teal.shade400,
                          width: 0.5,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'images/person.png',
                        ),
                        backgroundColor: Colors.teal.shade100.withAlpha(80),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Color(0xff22B1A9),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      // ImagePickAlert.alert(context, [image]).show();
                      ChooseImage(
                        context: context,
                        setImage: loadImageAffect,
                        title: 'Chọn ảnh nền',
                      ).show();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 16.0),
            child: RaisedButton.icon(
              icon: Icon(Icons.camera_enhance, color: Colors.white, size: 32.0),
              label: Text('Ảnh nền', style: TextStyle(color: Colors.white)),
              color: Colors.teal.shade300,
              onPressed: () async {
                ChooseImage(
                  context: context,
                  setImage: loadCoverImageAffect,
                  title: 'Chọn ảnh đại diện',
                ).show();
              },
            ),
          ),
        ),
      ],
    );
  }
}
