import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  final File image;
  final File cover;

  RetailerEditorWidget(this.username, this.password, this.image, {this.cover});

  @override
  _RetailerEditorWidgetState createState() => _RetailerEditorWidgetState();
}

class _RetailerEditorWidgetState extends State<RetailerEditorWidget> {
  TextEditingController _phoneCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _fullNameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _cityCtrl = TextEditingController();
  TextEditingController _websiteCtrl = TextEditingController();

  bool _isPending = false;
  bool _autoValidate = false;

  onSubmit() async {
    setState(() {
      _isPending = true;
    });
    if (widget._formKey.currentState.validate()) {
      // account instance
      Account newAccount = Account(
        address: _addressCtrl.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        password: widget.password,
        username: widget.username,
        profilePhoto: widget.image != null
            ? base64Encode(widget.image.readAsBytesSync())
            : null,
        coverPhoto: widget.cover != null
            ? base64Encode(widget.cover.readAsBytesSync())
            : null,
        researcher: null,
        role: RoleTypes.farmer,
        farmer: null,
        retailer: Retailer(
          cityName: _cityCtrl.text
              .split(' ')
              .map((x) => x[0].toUpperCase() + x.substring(1))
              .join(' '),
          retailerAddress: _addressCtrl.text,
          retailerEmail: _emailCtrl.text,
          retailerName: _fullNameCtrl.text
              .split(' ')
              .map((x) => x[0].toUpperCase() + x.substring(1))
              .join(' '),
          retailerPhoneNumber: _phoneCtrl.text,
          retailerWebsite: _websiteCtrl.text,
        ),
        phone: _phoneCtrl.text,
      );

      try {
        Response res = await Dio(BaseOptions(connectTimeout: 5000)).post(
          '$kServerApiUrl/accounts',
          data: newAccount.toMap(),
          options: new Options(
            contentType: "application/x-www-form-urlencoded",
            headers: {
              'charset': 'utf-8',
            },
          ),
        );

        if (res.statusCode == 200) {
          Alert(
              context: context,
              content: Text('Đăng kí tài khoản thành công!'),
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
        setState(() {
          _isPending = false;
        });
      } catch (err) {
        if (err.type == DioErrorType.CONNECT_TIMEOUT) {
          Alert(
                  context: context,
                  content: Text('Không thể kết nối đến hệ thống!'),
                  title: 'Mất kết nối',
                  type: AlertType.error)
              .show();
        } else
          Alert(
            context: context,
            content: Text('Vui lòng thử lại sau!'),
            title: 'Lỗi',
            type: AlertType.error,
          ).show();
      }
    } else
      setState(() {
        _autoValidate = true;
      });
    setState(() {
      _isPending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isPending,
      child: Scaffold(
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
                    autovalidate: _autoValidate,
                    key: widget._formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Không được bỏ trống.";
                            }
                            if (!InputValidate.isValidEmail(value)) {
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
                            if (!InputValidate.isValidWebsite(value)) {
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
                            if (!InputValidate.isValidCity(value)) {
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
                              onPressed: () {
                                if (_isPending) {
                                  Alert(
                                    context: context,
                                    title: 'Đang gởi...',
                                    type: AlertType.info,
                                  ).show();
                                } else {
                                  onSubmit();
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
