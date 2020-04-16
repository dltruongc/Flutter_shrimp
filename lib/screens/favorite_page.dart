import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/models/Account.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/widgets/newfeed_item.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<NewFeed> newfeeds;
  FavoriteController controller;

  @override
  void initState() {
    super.initState();
    controller = FavoriteController();
    newfeeds = controller.getAll();
  }

  Widget listViewBuild(Account owner) {
    return ListView.builder(
      itemCount: controller.hasMore ? newfeeds.length + 1 : controller.length,
      itemBuilder: (BuildContext context, int index) {
        if (index >= newfeeds.length) {
          controller.fetchNews(owner.id, index).then((feeds) {
            setState(() {
              newfeeds.addAll(feeds);
            });
          });
          return LoadingFadingLine.circle();
        }
        return NewFeedItem(
          newFeed: newfeeds[index],
          like: true,
          owner: newfeeds[index].user,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Account owner = Provider.of<AuthController>(context).owner;
    if ((controller.announce == null || newfeeds.isEmpty) &&
        controller.hasMore) {
      controller.fetchTop(owner.id).then(
            (feeds) => setState(() {
              newfeeds = feeds;
            }),
          );
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quan tâm'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.clear();
          setState(() {
            newfeeds.clear();
          });
        },
        child: newfeeds.isNotEmpty
            ? listViewBuild(owner)
            : Center(
                child: Text(
                  'Chưa có bài theo dõi nào!',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
      ),
    );
  }
}
