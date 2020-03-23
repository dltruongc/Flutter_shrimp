import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/validation/input_validate.dart';

class FarmerEditorWidget extends StatefulWidget {
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
        title: Text('Tạo tài khoản'),
        backgroundColor: kLightColor,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: TextField(
                controller: _storyCtrl,
                onChanged: (val) {
                  _story = val;
                },
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                enableInteractiveSelection: true,
                minLines: null,
                maxLines: null,
                keyboardAppearance: Brightness.dark,
                enabled: true,
                decoration: InputDecoration(
                  labelText: 'Câu chuyện nông dân',
                  hintText: 'Hãy nói gì đó để mọi người biết về bạn.',
                ),
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
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
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
            SizedBox(
              height: 10.0,
            ),
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
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
    );
  }
}
