import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/Farmer.dart';
import 'package:shrimpapp/models/Role.dart';
import 'package:shrimpapp/screens/login_page.dart';
import 'package:shrimpapp/validation/input_validate.dart';

class FarmerEditorWidget extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String username;
  final String password;
  final Asset image;

  FarmerEditorWidget(this.username, this.password, this.image);

  @override
  _FarmerEditorWidgetState createState() => _FarmerEditorWidgetState();
}

class _FarmerEditorWidgetState extends State<FarmerEditorWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _fullNameCtrl = TextEditingController();
    TextEditingController _storyCtrl = TextEditingController();
    TextEditingController _phoneCtrl = TextEditingController();
    TextEditingController _addressCtrl = TextEditingController();

    // Farmer(
    //       farmerFullname: _fullNameCtrl.text,
    //       farmerPhoneNumber: _phoneCtrl.text,
    //       farmerAddress: _addressCtrl.text,
    //       farmerStory: _storyCtrl.text,
    //     )

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tạo tài khoản'),
        backgroundColor: kLightColor,
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(
        //   top: MediaQuery.of(context).size.height * 0.2,
        // ),
        child: Center(
          child: Card(
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
                      controller: _fullNameCtrl,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      enableInteractiveSelection: true,
                      minLines: null,
                      maxLines: null,
                      keyboardAppearance: Brightness.dark,
                      enabled: true,
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
                      controller: _phoneCtrl,
                      enableInteractiveSelection: true,
                      minLines: null,
                      maxLines: null,
                      keyboardAppearance: Brightness.dark,
                      enabled: true,
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
                    TextField(
                      controller: _storyCtrl,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      enableInteractiveSelection: true,
                      minLines: null,
                      maxLines: null,
                      keyboardAppearance: Brightness.light,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: 'Câu chuyện nông dân',
                        hintText: 'Hãy nói gì đó để mọi người biết về bạn.',
                      ),
                    ),
                    TextFormField(
                      controller: _addressCtrl,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      enableInteractiveSelection: true,
                      minLines: null,
                      maxLines: null,
                      keyboardAppearance: Brightness.dark,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: 'Địa chỉ',
                        hintStyle: TextStyle(color: Colors.teal),
                        contentPadding: const EdgeInsets.all(0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: 40.0),
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
                                    ? base64Encode(encoded.buffer.asUint8List())
                                    : null,
                                researcher: null,
                                retailer: null,
                                role: RoleTypes.farmer,
                                story: _storyCtrl.text,
                                farmer: Farmer(
                                  farmerAddress: _addressCtrl.text,
                                  farmerFullname: _fullNameCtrl.text,
                                  farmerPhoneNumber: _phoneCtrl.text,
                                  farmerStory: _storyCtrl.text,
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
                                      content:
                                          Text('Đăng kí tài khoản thành công!'),
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
                                        content: Text('Vui lòng thử lại sau!'),
                                        title: 'Lỗi',
                                        type: AlertType.error)
                                    .show();
                              }
                            }
                          },
                          height: 60.0,
                          width: 180.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
