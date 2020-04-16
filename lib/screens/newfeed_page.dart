import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/providers/address_provider.dart';
import 'package:shrimpapp/screens/home_page.dart';
import 'package:shrimpapp/screens/newfeed_editor.dart';
import 'package:shrimpapp/utils/image_to_buffer.dart';
import 'package:shrimpapp/widgets/login_alert.dart';
import 'package:shrimpapp/widgets/account_banner.dart';
import 'package:shrimpapp/widgets/newfeed_item.dart';

class NewFeedPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Function handle;

  NewFeedPage({Key key, this.handle}) : super(key: key);

  void floatSubmit(BuildContext context) async {
    Map<String, dynamic> result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewFeedEditor(),
      ),
    );
    if (result != null && result['data'] == true) {
      try {
        _scaffoldKey.currentState
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Đang tải lên...',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.yellow.shade300,
            ),
          );
      } catch (er) {
        print("Show snackbar error!!");
      }
      // FIXME
      handle(result['feed'], result['images']);
    }
  }

  createFeed(Account owner, BuildContext buildContext) {
    if (owner == null) {
      LoginAlert(
        context: _scaffoldKey.currentContext,
        title: 'Đăng nhập',
      ).alert.show();
    } else
      floatSubmit(buildContext);
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Hỏi đáp'),
        centerTitle: true,
      ),
      body: Consumer<NewFeedController>(
        builder: (context, controller, _) {
          Account owner =
              Provider.of<AuthController>(context, listen: false).owner;

          if (controller.length <= 0 && controller.hasMore) {
            controller.fetchTop();
            return LoadingScreen();
          }

          final List<NewFeed> newfeeds = controller.getAll();
          return RefreshIndicator(
            onRefresh: () async {
              controller.clear();
              controller.fetchTop();
              return LoadingScreen();
            },
            child: Column(
              children: <Widget>[
                AccountBanner(
                  onPressed: () {
                    createFeed(owner, buildContext);
                  },
                  profilePhoto: owner != null ? owner.profilePhoto : null,
                ),
                Expanded(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: ScrollPhysics(),
                    itemCount: controller.hasMore
                        ? newfeeds.length + 1
                        : controller.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= newfeeds.length && controller.hasMore) {
                        controller.fetchTop();
                        return LoadingFadingLine.circle();
                      }

                      return NewFeedItem(
                        newFeed: newfeeds[index],
                        owner: newfeeds[index].user,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
