import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/components/submit_button.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';

class NewFeedEditor extends StatefulWidget {
  @override
  _NewFeedEditorState createState() => _NewFeedEditorState();
}

class _NewFeedEditorState extends State<NewFeedEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _contentFocus = FocusNode();

  List<Asset> images = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
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
      images = resultList;
    });
  }

  /*
  var buffer = new Uint8List(8).buffer;
  var bdata = new ByteData.view(buffer);
  bdata.setFloat32(0, 3.04);
  int huh = bdata.getInt32(0);
*/
  onSubmit() {
    DateTime timeNow = DateTime.now();

    final newFeed = NewFeed(
      accountId: Provider.of<AuthController>(context, listen: false).owner.id,
      createdAt: timeNow,
      updatedAt: timeNow,
      favorites: 0,
      images: [],
      movies: [],
      newFeedContent: _contentController.text,
      title: _titleController.text,
      views: 0,
    );
    Navigator.pop(context, {'feed': newFeed, 'images': images, 'data': true});
  }

  @override
  Widget build(BuildContext context) {
    Account owner = Provider.of<AuthController>(context).owner;
    return Scaffold(
      appBar: AppBar(
        title: Text('Soạn thảo'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                onSubmit();
              }
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 28.0,
            ),
            label: Text(
              'Xong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: <Widget>[
              AccountBar(
                account: owner,
                subTitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(owner.address),
                    Text(DateTime.now().toIso8601String()),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 30,
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Không được bỏ trống.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Tiêu đề',
                        hintStyle: Theme.of(context).textTheme.title,
                        contentPadding: const EdgeInsets.all(4.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: kGradientEndColor, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: kLightColor, width: 0.5),
                        ),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_contentFocus);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        minLines: 10,
                        maxLines: 10,
                        focusNode: _contentFocus,
                        controller: _contentController,
                        decoration: InputDecoration(
                          hintText: 'Nội dung',
                          hintStyle: Theme.of(context).textTheme.body1,
                          contentPadding: const EdgeInsets.all(4.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                color: kGradientEndColor, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: kLightColor, width: 0.5),
                          ),
                        ),
                        validator: (val) {
                          return val.isEmpty ? 'Không được để trống!' : null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      loadAssets();
                    },
                    icon: Icon(
                      Icons.photo,
                      color: kLightColor,
                      size: 30.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.list,
                      color: kLightColor,
                      size: 30.0,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(_contentFocus);
                      _contentController.text =
                          _contentController.text + '\n1. ';
                      _contentController.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: _contentController.text.length - 1));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.link,
                      color: kLightColor,
                      size: 30.0,
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(_contentFocus);
                      _contentController.text =
                          _contentController.text + ' [tên_liên_kết]()';
                      _contentController.selection = TextSelection.fromPosition(
                        TextPosition(
                          offset:
                              _contentController.text.lastIndexOf((']()')) + 2,
                        ),
                      );
                    },
                  ),
                  Icon(
                    Icons.location_on,
                    color: kLightColor,
                    size: 30.0,
                  )
                ],
              ),

              // images.length > 0
              // ? SliderImages(images: widget.newFeed.images)
              // : SizedBox(),
              SizedBox(height: 4.0),
              images.length > 0
                  ? CarouselSlider(
                      viewportFraction: 0.9,
                      aspectRatio: 1.5,
                      autoPlay: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 50),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      items:
                          images.map<Widget>((img) => imageView(img)).toList(),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    SubmitButton(
                      title: 'Hoàn tất',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          onSubmit();
                        }
                      },
                      height: 40.0,
                      width: 120.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageView(Asset img) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            child: AssetThumb(
              asset: img,
              height: 200,
              width: 300,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: RaisedButton(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete, color: kLightColor, size: 24.0),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  images.removeWhere((e) => e.identifier == img.identifier);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
