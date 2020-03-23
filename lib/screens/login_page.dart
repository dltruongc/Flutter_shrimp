import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shrimpapp/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailInput = TextEditingController();

  TextEditingController _passWordInput = TextEditingController();

  FocusNode _emailFocus = FocusNode();

  FocusNode _passwordFocus = FocusNode();

  bool _showPassword = false;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailInput,
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
                        errorText: 'ERROR TEXT',
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
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        filled: false,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: _showPasswordFnc(),
                        labelText: "Mật khẩu",
                        errorText: 'ERROR TEXT',
                      ),
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (val) {},
                    ),
                  ],
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
                    onTap: () {},
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
                              letterSpacing: 1.0),
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
                      Navigator.pushReplacement(
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
