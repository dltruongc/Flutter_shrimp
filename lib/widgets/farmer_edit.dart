import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/screens/home_page.dart';
import 'package:shrimpapp/validation/input_validate.dart';

class FarmerEditorWidget extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    String _story;

    // Farmer(
    //       farmerFullname: _fullNameCtrl.text,
    //       farmerPhoneNumber: _phoneCtrl.text,
    //       farmerAddress: _addressCtrl.text,
    //       farmerStory: _story,
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
                      onChanged: (val) {
                        _story = val;
                      },
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
                          onPressed: () {
                            if (widget._formKey.currentState.validate())
                              Navigator.of(context).pop();
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
