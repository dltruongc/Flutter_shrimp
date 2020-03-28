import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
  TextEditingController _passwordRetypeCtrl = TextEditingController();
  Asset image;
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

  bool _accountExisted = false;

  _onSubmit() async {}

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#00A3B3",
          actionBarTitle: "Chọn ảnh",
          allViewTitle: "Tất cả",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print('ERRRORRRRR: $e');
    }
    if (!mounted) return;
    setState(() {
      image = resultList[0];
    });
  }

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
                            onChanged: (val) {
                              _accountExisted = false;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Không được bỏ trống.";
                              }
                              if (!InputValidate.isValidUserName(value)) {
                                return "Tài khoản không hợp lệ";
                              }
                              if (_accountExisted) {
                                return 'Tài khoản đã tồn tại';
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
                          TextFormField(
                            controller: _passwordRetypeCtrl,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Không được bỏ trống.";
                              }
                              if (value != _passwordCtrl.text) {
                                return "Mật khẩu không khớp";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              labelText: "Xác nhận mật khẩu",
                            ),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                      autovalidate: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        SubmitButton(
                          title: 'Nông dân',
                          onPressed: () async {
                            Response res = await Dio().get(
                                '$kServerApiUrl/accounts?accountUserName=${_userNameCtrl.text}');
                            if (res.data['results'] > 0) {
                              setState(() {
                                _accountExisted = true;
                              });
                            } else {
                              setState(() {
                                _accountExisted = false;
                              });
                            }
                            if (_formKey.currentState.validate())
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => FarmerEditorWidget(
                                    this._userNameCtrl.text,
                                    this._passwordCtrl.text,
                                    this.image,
                                  ),
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
                          onPressed: () async {
                            Response res = await Dio().get(
                                '$kServerApiUrl/accounts?accountUserName=${_userNameCtrl.text}');
                            if (res.data['results'] > 0) {
                              setState(() {
                                _accountExisted = true;
                              });
                            } else {
                              setState(() {
                                _accountExisted = false;
                              });
                            }
                            if (_formKey.currentState.validate())
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RetailerEditorWidget(
                                    this._userNameCtrl.text,
                                    this._passwordCtrl.text,
                                    this.image,
                                  ),
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
          image == null
              ? Container(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/person.png',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: AssetThumb(
                    asset: image,
                    width: 150,
                    height: 150,
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
                  // ImagePickAlert.alert(context, [image]).show();
                  loadAssets();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
