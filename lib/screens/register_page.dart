import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Role.dart';
import 'package:shrimpapp/widgets/avatar_picker.dart';
import 'package:shrimpapp/widgets/farmer_edit.dart';
import 'package:shrimpapp/widgets/researcher_editor.dart';
import 'package:shrimpapp/widgets/retailer_edit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../validation/input_validate.dart';

class RegisterPage extends StatefulWidget {
  static const registerRoute = '/register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _passwordRetypeCtrl = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode passwordRetypeFocus = FocusNode();
  File image;
  File coverImage;
  bool _obscureText = true;
  bool _accountExisted = false;
  bool _isPending = false;
  bool _autoValidate = false;
  RoleTypes _roleVal = RoleTypes.farmer;

  onSubmit() {
    if (_roleVal == RoleTypes.farmer) {
      onFarmer();
    } else if (_roleVal == RoleTypes.retailer) {
      onRetailer();
    } else if (_roleVal == RoleTypes.researcher) {
      onResearcher();
    }
  }

  onResearcher() async {
    setState(() {
      _isPending = true;
    });
    try {
      final base = BaseOptions(
        connectTimeout: 5000,
      );

      Response res = await Dio(base).get(
        '$kServerApiUrl/accounts?accountUserName=${_userNameCtrl.text}',
      );

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
            builder: (context) => ResearcherEditorWidget(
              this._userNameCtrl.text,
              this._passwordCtrl.text,
              this.image,
              cover: this.coverImage,
            ),
          ),
        );
      else
        setState(() {
          _autoValidate = true;
        });
    } on DioError catch (res) {
      if (res.type == DioErrorType.CONNECT_TIMEOUT) {
        Alert(
          context: context,
          title: 'Mất kết nối',
          content: Text('Không kết nối được với hệ thống'),
          type: AlertType.error,
        ).show();
      } else if (res.response.statusCode == 400) {
        setState(() {
          _accountExisted = false;
        });
        if (_formKey.currentState.validate())
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ResearcherEditorWidget(
                this._userNameCtrl.text,
                this._passwordCtrl.text,
                this.image,
                cover: this.coverImage,
              ),
            ),
          );
        else
          setState(() {
            _autoValidate = true;
          });
      }
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      _isPending = false;
    });
  }

  onFarmer() async {
    setState(() {
      _isPending = true;
    });
    try {
      final base = BaseOptions(
        connectTimeout: 5000,
      );

      Response res = await Dio(base).get(
        '$kServerApiUrl/accounts?accountUserName=${_userNameCtrl.text}',
      );

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
              cover: this.coverImage,
            ),
          ),
        );
      else
        setState(() {
          _autoValidate = true;
        });
    } on DioError catch (res) {
      if (res.type == DioErrorType.CONNECT_TIMEOUT) {
        Alert(
          context: context,
          title: 'Mất kết nối',
          content: Text('Không kết nối được với hệ thống'),
          type: AlertType.error,
        ).show();
      } else if (res.response.statusCode == 400) {
        setState(() {
          _accountExisted = false;
        });
        if (_formKey.currentState.validate())
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => FarmerEditorWidget(
                this._userNameCtrl.text,
                this._passwordCtrl.text,
                this.image,
                cover: this.coverImage,
              ),
            ),
          );
        else
          setState(() {
            _autoValidate = true;
          });
      }
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      _isPending = false;
    });
  }

  onRetailer() async {
    setState(() {
      _isPending = true;
    });
    try {
      Response res = await Dio(BaseOptions(connectTimeout: 5000))
          .get('$kServerApiUrl/accounts?accountUserName=${_userNameCtrl.text}');
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
              cover: this.coverImage,
            ),
          ),
        );
      else
        setState(() {
          _autoValidate = true;
        });
    } on DioError catch (res) {
      if (res.type == DioErrorType.CONNECT_TIMEOUT) {
        Alert(
          context: context,
          title: 'Mất kết nối',
          content: Text('Không kết nối được với hệ thống'),
          type: AlertType.error,
        ).show();
      } else if (res.response.statusCode == 400) {
        setState(() {
          _accountExisted = false;
        });
        if (_formKey.currentState.validate())
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RetailerEditorWidget(
                this._userNameCtrl.text,
                this._passwordCtrl.text,
                this.image,
                cover: this.coverImage,
              ),
            ),
          );
        else
          setState(() {
            _autoValidate = true;
          });
      }
    } on Exception catch (_) {
      Alert(
        context: context,
        title: 'Lỗi',
        content: Text(
          'Xảy ra lỗi không xác định. Vui lòng kiểm tra dữ liệu nhập vào',
        ),
        type: AlertType.error,
      ).show();
    }

    setState(() {
      _isPending = false;
    });
  }

  setImage(File img) {
    this.image = img;
  }

  setCoverImage(File img) {
    this.coverImage = img;
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
            AvatarPicker(
              setImage: this.setImage,
              setCoverImage: this.setCoverImage,
            ),
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
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          //-------------------- username----------------
                          TextFormField(
                            controller: _userNameCtrl,
                            autofocus: false,
                            autocorrect: false,
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
                            focusNode: usernameFocus,
                            onChanged: (val) {
                              _accountExisted = false;
                            },
                            onFieldSubmitted: (val) {
                              usernameFocus.unfocus();

                              FocusScope.of(context)
                                  .requestFocus(passwordFocus);
                            },
                            keyboardType: TextInputType.text,
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
                            autofocus: false,
                            autocorrect: false,
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
                            keyboardType: TextInputType.text,
                            focusNode: passwordFocus,
                            onFieldSubmitted: (val) {
                              passwordFocus.unfocus();

                              FocusScope.of(context)
                                  .requestFocus(passwordRetypeFocus);
                            },
                          ),
                          TextFormField(
                            controller: _passwordRetypeCtrl,
                            autofocus: false,
                            autocorrect: false,
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
                            keyboardType: TextInputType.text,
                            focusNode: passwordRetypeFocus,
                            onFieldSubmitted: (val) {
                              passwordRetypeFocus.unfocus();
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          DropdownButton(
                            value: _roleVal,
                            onChanged: (RoleTypes newRole) {
                              if (newRole == RoleTypes.administrator) {
                                Alert(
                                  context: context,
                                  title: 'Xác nhận',
                                  content: Text(
                                    'Bạn muốn đăng ký thành viên Quản Lý?',
                                  ),
                                  type: AlertType.info,
                                  buttons: [
                                    DialogButton(
                                      child: Text('Có'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        final url = '$kServerApiUrl/sign-up';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        }
                                      },
                                    ),
                                    DialogButton(
                                      child: Text('Không'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ).show();
                              }
                              setState(() {
                                _roleVal = newRole;
                              });
                            },
                            isExpanded: true,
                            items: [
                              RoleTypes.farmer,
                              RoleTypes.retailer,
                              RoleTypes.researcher,
                              RoleTypes.administrator,
                            ]
                                .map(
                                  (x) => DropdownMenuItem(
                                    child: Text(
                                      toVietnam(x),
                                    ),
                                    value: x,
                                  ),
                                )
                                .toList(),
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
                          title: 'Đăng ký',
                          onPressed: () {
                            if (_isPending) {
                              Alert(
                                context: context,
                                title: 'Đang gởi...',
                                type: AlertType.warning,
                              ).show();
                            } else {
                              onSubmit();
                            }
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
}
