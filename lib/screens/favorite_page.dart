import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/screens/newfeed_page.dart';

class FavoritePage extends StatelessWidget {
//   @override
//   _NewFeedPageState createState() => _NewFeedPageState();
// }

// class _NewFeedPageState extends State<NewFeedPage> {
//   bool _isLoading = true;
//   bool _hasMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hỏi đáp'),
      ),
      body: Consumer<NewFeedController>(builder: (context, controller, _) {
        if (controller.length <= 0) {
          Provider.of<NewFeedController>(context, listen: false).fetchTop();
          return LoadingScreen();
        }
        print(controller.length);
        final List<NewFeed> newfeeds = controller.getAll();
        return RefreshIndicator(
          // TODO: dummy data
          onRefresh: () async {
            // await Future.delayed(Duration(seconds: 3));
            // Provider.of<NewFeedController>(context, listen: false)
            //     .addFirst(_addThis);
          },
          child: ListView.builder(
            itemCount: newfeeds.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == newfeeds.length && controller.hasMore) {
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
    );
  }
}
