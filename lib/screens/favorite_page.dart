import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/screens/newfeed_page.dart';

// FIXME: dump account id
String _dumpAccountId = "5e7d9468f715b13067a30f66";

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quan tâm'),
        centerTitle: true,
      ),
      body: Consumer<FavoriteController>(builder: (context, controller, _) {
        List<NewFeed> newfeeds = controller.getAll();
        if ((controller.announce == null || newfeeds.isEmpty)) {
          controller.fetchTop(_dumpAccountId);
          return LoadingScreen();
        }
        return RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            itemCount:
                controller.hasMore ? newfeeds.length + 1 : controller.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= newfeeds.length && controller.hasMore) {
                Provider.of<FavoriteController>(context, listen: false)
                    .fetchNews(_dumpAccountId, index);
                return LoadingFadingLine.circle();
              }
              return NewFeedItem(
                newFeed: newfeeds[index],
                like: true,
                owner: newfeeds[index].user,
              );
            },
          ),
        );
      }),
    );
  }
}
