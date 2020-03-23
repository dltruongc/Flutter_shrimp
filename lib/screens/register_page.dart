import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shrimpapp/components/image_picker.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/widgets/farmer_edit.dart';
import 'package:shrimpapp/widgets/retailer_edit.dart';
import '../validation/input_validate.dart';

class RegisterPage extends StatefulWidget {
  static const registerRoute = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userNameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  File image;
  bool _obscureText = true;

  // _submitButton() {
  //   return SubmitButton(
  //       title: 'Đăng ký',
  //       onPressed: () {
  //         // TODO: create model
  //         // bool ok = _formKey.currentState.validate();
  //         // if (ok) _createModel();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
        centerTitle: true,
        backgroundColor: kLightColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _avatarPicker(),
            Card(
              color: Colors.teal.shade50,
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          //-------------------- username----------------
                          TextFormField(
                            controller: _userNameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Tên đăng nhập',
                              hintStyle: TextStyle(color: Colors.teal),
                              contentPadding: const EdgeInsets.all(0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Không được bỏ trống.";
                              }
                              if (!InputValidate.isValidUserName(value)) {
                                return "Tài khoản không hợp lệ";
                              }
                              return null;
                            },
                          ),

                          //---------------password------------------
                          TextFormField(
                            controller: _passwordCtrl,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Không được bỏ trống.";
                              }
                              if (!InputValidate.isValidPassword(value)) {
                                return "Mật khẩu không hợp lệ";
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              labelText: "Mật khẩu",
                              suffixIcon: new GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: new Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        SubmitButton(
                          title: 'Nông dân',
                          onPressed: () {
                            if (_formKey.currentState.validate())
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => FarmerEditorWidget(),
                                ),
                              );
                          },
                          height: 40,
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        SubmitButton(
                          title: 'Đại lí',
                          onPressed: () {
                            if (_formKey.currentState.validate())
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RetailerEditorWidget(),
                                ),
                              );
                          },
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarPicker() {
    return Container(
      margin: const EdgeInsets.only(top: 60, bottom: 16),
      height: 160,
      width: 160,
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            child: CircleAvatar(
              backgroundImage: image == null
                  ? AssetImage(
                      'images/person.png',
                    )
                  : FileImage(image),
              backgroundColor: Colors.transparent,
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
                onPressed: () {
                  ImagePickAlert.alert(context, [image]).show();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
