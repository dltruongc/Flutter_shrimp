import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Retailer.dart';
import 'package:shrimpapp/models/Role.dart';
import 'package:shrimpapp/screens/login_page.dart';
import 'package:shrimpapp/validation/input_validate.dart';

class RetailerEditorWidget extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String username;
  final String password;
  final Asset image;

  RetailerEditorWidget(this.username, this.password, this.image);

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
//   retailerName: _fullNameCtrl.text,
//   retailerAddress: _addressCtrl.text,
//   retailerEmail: _emailCtrl.text,
//   retailerWebsite: _websiteCtrl.text,
//   retailerPhoneNumber: _phoneCtrl.text,
//   cityName: _cityCtrl.text,
// )

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tạo tài khoản'),
        backgroundColor: kLightColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // _retailerBuilder(),
            Card(
              color: Colors.teal.shade50,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  autovalidate: true,
                  key: widget._formKey,
                  child: Column(
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
                      SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          SubmitButton(
                            title: 'Hoàn tất',
                            onPressed: () async {
                              if (widget._formKey.currentState.validate()) {
                                ByteData encoded;
                                try {
                                  encoded = await widget.image.getThumbByteData(
                                      1024 *
                                          widget.image.originalWidth ~/
                                          widget.image.originalHeight,
                                      1024);
                                } catch (err) {
                                  encoded = null;
                                }
                                // account instance
                                Account newAccount = Account(
                                  address: _addressCtrl.text,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  password: widget.password,
                                  username: widget.username,
                                  profilePhoto: encoded != null
                                      ? base64Encode(
                                          encoded.buffer.asUint8List())
                                      : null,
                                  researcher: null,
                                  role: RoleTypes.farmer,
                                  farmer: null,
                                  retailer: Retailer(
                                    cityName: _cityCtrl.text,
                                    retailerAddress: _addressCtrl.text,
                                    retailerEmail: _emailCtrl.text,
                                    retailerName: _fullNameCtrl.text,
                                    retailerPhoneNumber: _phoneCtrl.text,
                                    retailerWebsite: _websiteCtrl.text,
                                  ),
                                  phone: _phoneCtrl.text,
                                );
                                Response res;
                                try {
                                  res = await Dio().post(
                                    '$kServerApiUrl/accounts',
                                    data: newAccount.toMap(),
                                    options: new Options(
                                      contentType:
                                          "application/x-www-form-urlencoded",
                                      headers: {
                                        'charset': 'utf-8',
                                      },
                                    ),
                                  );

                                  if (res.statusCode > 400 &&
                                      res.statusCode < 500) {
                                    Alert(
                                            context: context,
                                            content: Text(
                                                'Kiểm tra lại kết nối Internet và thử lại!'),
                                            title: 'Lỗi',
                                            type: AlertType.error)
                                        .show();
                                  } else if (res.statusCode == 200) {
                                    Alert(
                                        context: context,
                                        content: Text(
                                            'Đăng kí tài khoản thành công!'),
                                        title: 'Thành công',
                                        type: AlertType.success,
                                        closeFunction: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          );
                                        }).show();
                                  }
                                } catch (err) {
                                  Alert(
                                          context: context,
                                          content:
                                              Text('Vui lòng thử lại sau!'),
                                          title: 'Lỗi',
                                          type: AlertType.error)
                                      .show();
                                }
                              }
                            },
                            height: 60.0,
                            width: 100.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintStyle: TextStyle(color: Colors.teal),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
