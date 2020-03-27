import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/account_bar.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/providers/address_provider.dart';
import 'package:shrimpapp/screens/comment_page.dart';
import 'package:shrimpapp/screens/newfeed_editor.dart';
import 'package:shrimpapp/utils/DateFormatter.dart';
import 'package:shrimpapp/widgets/slider_images.dart';

class NewFeedPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void floatSubmit(BuildContext context) async {
    Map<String, dynamic> result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewFeedEditor(),
      ),
    );
    _scaffoldKey.currentState
      ..showSnackBar(
        SnackBar(
          content: Text('Đang tải lên...'),
          backgroundColor: Colors.yellow,
        ),
      );

    if (Provider.of<NewFeedController>(context, listen: false)
        .findByDate(result['createdAt'])) {
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Bài viết mới đã được đăng'),
            backgroundColor: Colors.lightGreen,
          ),
        );
    }

    handle(result['feed'], result['images'], context);
  }

  handle(NewFeed feed, List<Asset> images, BuildContext context) async {
    // Convert images to base64
    Iterable<Future<String>> buffers = images.map((img) async {
      ByteData x = await img.getByteData();
      return base64Encode(x.buffer.asUint8List());
    });

    Future<List<String>> futureList = Future.wait(buffers);

    List<String> bufferResults = await futureList;

    // find current location
    final Location location = Location();
    LocationData locationData = await location.getLocation();
    String addressString;

    try {
      List<Address> addressData = await AddressProvider()
          .fetchAddress(locationData.latitude, locationData.latitude);
      Address address = addressData.first;
      addressString = address.featureName +
          ', ' +
          address.subAdminArea +
          ', ' +
          address.adminArea;
    } catch (e) {
      addressString = 'ple ple ple';
    }

    feed.images = bufferResults;
    feed.newFeedLocation = addressString;

    // FIXME: Dump create alter
    NewFeed x = await Provider.of<NewFeedController>(context, listen: false)
        .createNewFeed(feed);
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Bài viết mới đã được đăng'),
          backgroundColor: Colors.lightGreen,
        ),
      );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Hỏi đáp'),
        centerTitle: true,
      ),
      body: Consumer<NewFeedController>(builder: (context, controller, _) {
        if (controller.length <= 0) {
          Provider.of<NewFeedController>(context, listen: false).fetchTop();
          return LoadingScreen();
        }
        final List<NewFeed> newfeeds = controller.getAll();
        return RefreshIndicator(
          onRefresh: () async {
            // await Future.delayed(Duration(seconds: 3));
            Provider.of<NewFeedController>(context, listen: false)
                .dumpCreateNewFeed();
          },
          child: ListView.builder(
            itemCount:
                controller.hasMore ? newfeeds.length + 1 : controller.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= newfeeds.length && controller.hasMore) {
                Provider.of<NewFeedController>(context, listen: false)
                    .fetchTop();
                return LoadingFadingLine.circle();
              }

              return NewFeedItem(
                newFeed: newfeeds[index],
                owner: newfeeds[index].user,
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          floatSubmit(buildContext);
        },
        backgroundColor: kDeepColor,
        heroTag: 'post-editor',
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset(
            'images/add_icon.png',
            fit: BoxFit.contain,
            color: Colors.white.withAlpha(180),
          ),
        ),
      ),
    );
  }
}

class NewFeedItem extends StatefulWidget {
  final NewFeed newFeed;
  final Account owner;
  bool like = false;

  NewFeedItem(
      {Key key, @required this.newFeed, @required this.owner, like = false})
      : super(key: key);

  @override
  _NewFeedItemState createState() => _NewFeedItemState();
}

class _NewFeedItemState extends State<NewFeedItem> {
  @override
  Widget build(BuildContext context) {
    bool isOverflowContent =
        widget.newFeed.newFeedContent.length > 50 ? true : false;
    return Container(
      child: Column(
        children: <Widget>[
          // Account card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AccountBar(
              account: widget.owner,
              subTitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(widget.newFeed.newFeedLocation ?? ''),
                  Text(
                    DateFormatter.toVietNamString(widget.newFeed.createdAt),
                  ),
                ],
              ),
            ),
          ),

          // NewFeed content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.newFeed.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: MarkdownBody(
                    data: widget.newFeed.newFeedContent,
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                    // softWrap: true,
                    // maxLines: isOverflowContent ? 4 : 100,
                    // overflow: isOverflowContent
                    //     ? TextOverflow.clip
                    //     : TextOverflow.visible,
                    // style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          // Images
//          widget.newFeed.images.length > 0
//              ? MyNetworkImage.fromPath(path: widget.newFeed.images[0])
//              : SizedBox(height: 150.0, width: double.infinity),

          widget.newFeed.images.length > 0
              ? SliderImages(images: widget.newFeed.images)
              : SizedBox(),
          // Interactive post buttons
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade500,
                  width: 0.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
            height: 32.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: widget.like
                      ? Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          size: 20.0,
                          color: Colors.red.shade300,
                        )
                      : Icon(
                          FontAwesomeIcons.thumbsUp,
                          size: 20.0,
                          color: Colors.black54,
                        ),
                  label: Text(
                    'Quan tâm',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentPage(widget.newFeed),
                      ),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.commentAlt,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  label: Text(
                    'Bình luận',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.share,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  label: Text(
                    'Chia sẻ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 10.0,
            thickness: 10.0,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
