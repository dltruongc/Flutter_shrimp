import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shrimpapp/validation/input_validate.dart';

class RetailerEditorWidget extends StatefulWidget {
  @override
  _RetailerEditorWidgetState createState() => _RetailerEditorWidgetState();
}

class _RetailerEditorWidgetState extends State<RetailerEditorWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneCtrl = TextEditingController();
    TextEditingController _addressCtrl = TextEditingController();
    TextEditingController _fullNameCtrl = TextEditingController();
    TextEditingController _emailCtrl = TextEditingController();
    TextEditingController _cityCtrl = TextEditingController();
    TextEditingController _websiteCtrl = TextEditingController();

    // Retailer(
//           retailerName: _fullNameCtrl.text,
//           retailerAddress: _addressCtrl.text,
//           retailerEmail: _emailCtrl.text,
//           retailerWebsite: _websiteCtrl.text,
//           retailerPhoneNumber: _phoneCtrl.text,
//           cityName: _cityCtrl.text,
//         )

    return Column(
      children: <Widget>[
        TextFormField(
          controller: _emailCtrl,
          validator: (value) {
            if (value.isEmpty) {
              return "Không được bỏ trống.";
            }
            if (!value.contains('@') || value.length < 5) {
              return "Email không hợp lệ";
            }
            return null;
          },
          decoration: customInputDecoration("Thông tin Email"),
        ),
        TextFormField(
          controller: _addressCtrl,
          decoration: InputDecoration(
            labelText: 'Địa chỉ',
            hintStyle: TextStyle(color: Colors.teal),
            contentPadding: const EdgeInsets.all(0),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
          ),
        ),
        TextFormField(
          controller: _phoneCtrl,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value.isEmpty) {
              return "Không được bỏ trống.";
            }
            if (!InputValidate.isValidPhone(value)) {
              return "Số điện thoại không đúng";
            }
            return null;
          },
          decoration: customInputDecoration("Số điện thoại "),
          keyboardType: TextInputType.phone,
          maxLength: 10,
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: _fullNameCtrl,
          validator: (value) {
            if (value.isEmpty) {
              return "Không được bỏ trống.";
            }
            if (!InputValidate.isValidName(value)) {
              return "Họ tên không hợp lệ";
            }
            return null;
          },
          decoration: customInputDecoration("Họ tên "),
        ),
        TextFormField(
          controller: _websiteCtrl,
          validator: (value) {
            if (value.isEmpty) {
              return "Không được bỏ trống.";
            }
            if (value.length < 5 || !value.contains('.')) {
              return "Địa chỉ Website không hợp lệ";
            }
            return null;
          },
          decoration: customInputDecoration("Địa chỉ website"),
        ),
        SizedBox(
          height: 30.0,
        ),
        TextFormField(
          controller: _cityCtrl,
          validator: (value) {
            if (value.isEmpty) {
              return "Không được bỏ trống.";
            }
            if (!InputValidate.isValidUserName(value)) {
              return "Thành phố không hợp lệ";
            }
            return null;
          },
          decoration: customInputDecoration("Thành phố"),
        ),
      ],
    );
  }

  _getCoverImage() {}
  File image;

  Column _retailerBuilder() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('Thêm ảnh giới thiệu'),
          color: Color(0xff22B1A9),
          onPressed: () {
            // TODO
            _getCoverImage();
          },
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  width: 300,
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                    cacheHeight: 640,
                    cacheWidth: 640,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: FlatButton.icon(
                  color: Color(0xCC000000),
                  label: Text(
                    'Xoá',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      image;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: TextStyle(color: Colors.teal),
      contentPadding: const EdgeInsets.all(0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
    );
  }
}
