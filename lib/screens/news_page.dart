import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/news_controller.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  List<News> articles = [];
  static const newsRoute = 'newsRoute';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool _isLoading = true;
  bool _hasMore = true;
  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _hasMore = true;

    _loadItems();
  }

  void _loadItems() {
    _isLoading = true;

    NewsController().fetchAll().then((data) {
      if (data == null) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        widget.articles.addAll(data);
        setState(() {
          _isLoading = false;
          newsData.addAll(data);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<News> newsData = [];
  @override
  Widget build(BuildContext context) {
    if (newsData.length == 0) {
      return LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức'),
      ),
      body: ListView.builder(
        itemCount: _hasMore ? newsData.length + 1 : newsData.length,
        itemBuilder: (ctx, id) {
          _launchURL() async {
            final url = newsData[id].url;
            if (await canLaunch(url)) {
              await launch(url);
            }
          }

          if (id >= newsData.length) {
            if (!_isLoading) {
              _loadItems();
            }
            return Center(child: LoadingFadingLine.circle());
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
