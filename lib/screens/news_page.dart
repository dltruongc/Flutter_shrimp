import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shrimpapp/components/loading_fullpage.dart';
import 'package:shrimpapp/controllers/news_controller.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  List<News> articles;
  static const newsRoute = 'newsRoute';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> newsData;
  @override
  Widget build(BuildContext context) {
    if (widget.articles == null) {
      NewsController().fetchAll().then((data) {
        widget.articles = data;
        setState(() {
          newsData = data;
        });
      });
    }
    if (newsData == null) {
      return LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức'),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (ctx, id) {
          _launchURL() async {
            print('${newsData[id].url}');
            final url = newsData[id].url;
            if (await canLaunch(url)) {
              await launch(url);
            }
          }

          return GestureDetector(
            onTap: _launchURL,
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.all(8.0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: newsData[id].image != null
                        ? MemoryImage(base64Decode(newsData[id].image))
                        : AssetImage('images/ts_blue.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                newsData[id].title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                newsData[id].url,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
