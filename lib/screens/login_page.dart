import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailInput = TextEditingController();
  TextEditingController _passWordInput = TextEditingController();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  bool _isPending = false;
  bool _showPassword = false;
  bool _autoValidate = false;

  Widget _showPasswordFnc() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      child:
          _showPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
    );
  }

  onLogin() async {
    try {
      // Duplicate requests limited
      setState(() {
        _isPending = true;
      });

      Response res = await Dio(BaseOptions(connectTimeout: 3000))
          .post('$kServerApiUrl/accounts/login', data: {
        'accountUserName': _emailInput.text,
        'accountPassword': _passWordInput.text
      });
      if (res.statusCode == 200) {
        Account logedAccount = Account.fromJson(res.data['user']);

        logedAccount.token = res.data['token'];
        logedAccount.expiredToken = DateTime.parse(res.data['expire']);
        Provider.of<AuthController>(context, listen: false)
            .setOwner(logedAccount);
        Navigator.of(context).pop();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accountId', logedAccount.id);
        prefs.setString('token', logedAccount.token);
      }
    } on DioError catch (err) {
      if (err.type == DioErrorType.RESPONSE) {
        Alert(
          context: context,
          title: 'Đăng nhập thất bại!',
          content: Text(err.response.data['message'] ?? ''),
          type: AlertType.error,
        ).show();
      } else if (err.type == DioErrorType.CONNECT_TIMEOUT)
        Alert(
          context: context,
          title: 'Mất kết nối',
          content: Text('Không kết nối được với hệ thống!'),
          type: AlertType.error,
        ).show();
    }
    setState(() {
      _isPending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 60.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                "images/logoSTfarm.png",
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0,
                      )
                    ]),
                child: Form(
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailInput,
                        validator: (val) {
                          if (val.length == 0) return "Không được bỏ trống!";
                          if (val.length < 5)
                            return "Tên đăng nhập không hợp lệ";
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          filled: false,
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: "Tên đăng nhập",
                        ),
                        focusNode: _emailFocus,
                        onFieldSubmitted: (val) {
                          _emailFocus.unfocus();
                          FocusScope.of(context).requestFocus(_passwordFocus);
                        },
                      ),

                      // height: ScreenUtil.getInstance().setHeight(50)),
                      TextFormField(
                        controller: _passWordInput,
                        obscureText: !_showPassword,
                        validator: (val) {
                          if (val.length == 0) return "Không được bỏ trống!";
                          if (val.length < 5) return "Mật khẩu quá ngắn";
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          filled: false,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: _showPasswordFnc(),
                          labelText: "Mật khẩu",
                        ),
                        focusNode: _passwordFocus,
                        onFieldSubmitted: (val) {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              // SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      if (_isPending) {
                        Alert(
                          context: context,
                          title: 'Đang gởi...',
                          type: AlertType.warning,
                        ).show();
                      } else if (_formKey.currentState.validate()) {
                        await onLogin();
                      } else
                        setState(() {
                          _autoValidate = true;
                        });
                    },
                    child: Container(
                      height: 60,
                      width: 240,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, 8.0),
                                blurRadius: 8.0)
                          ]),
                      child: Center(
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 18,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Chưa có tài khoản? ",
                    style:
                        TextStyle(fontFamily: "Poppins-Medium", fontSize: 18.0),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                        color: Color(0xFF5d74e3),
                        fontFamily: "Poppins-Bold",
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
