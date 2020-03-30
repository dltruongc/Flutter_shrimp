import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
  Asset coverImage;
  bool _obscureText = true;

  bool _accountExisted = false;

  Future<Asset> loadAssets() async {
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
    if (!mounted) return null;
    return resultList[0];
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
                                    cover: this.coverImage,
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
                                    cover: this.coverImage,
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
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 0, bottom: 16),
          height: 200,
          width: double.infinity,
          child: coverImage != null
              ? AssetThumb(
                  asset: coverImage,
                  height: 200,
                  width: MediaQuery.of(context).size.width ~/ 1,
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
                    onPressed: () async {
                      // ImagePickAlert.alert(context, [image]).show();
                      Asset x = await loadAssets();
                      setState(() {
                        image = x;
                      });
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
                Asset x = await loadAssets();
                setState(() {
                  coverImage = x;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
