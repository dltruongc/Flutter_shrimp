import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/news_controller.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:shrimpapp/utils/FetchImage.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
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

    _loadItems(0);
  }

  void _loadItems(int index) {
    _isLoading = true;

    NewsController().fetchAll(index).then((data) {
      if (data == null || data.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
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
      if (!_hasMore) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tin tức'),
          ),
          body: Center(
            child: Text('Không có dữ liệu',
                style: Theme.of(context).textTheme.title),
          ),
        );
      }
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tin tức'),
      ),
      body: ListView.separated(
        itemCount: _hasMore ? newsData.length + 1 : newsData.length,
        separatorBuilder: (ctx, id) => Divider(
          thickness: 1.3,
          indent: 32,
          endIndent: 32,
        ),
        itemBuilder: (ctx, id) {
          _launchURL() async {
            final url = newsData[id].url;
            if (await canLaunch(url)) {
              await launch(url);
            }
          }

          if (id >= newsData.length) {
            if (!_isLoading) {
              _loadItems(id);
            }
            return Center(child: LoadingFadingLine.circle());
          }

          return GestureDetector(
            onTap: _launchURL,
            child: ListTile(
              leading: newsData[id].image != null
                  ? Container(
                      margin: const EdgeInsets.all(2.0),
                      height: 80.0,
                      width: 80.0,
                      child: MyNetworkImage.fromPath(
                        path: newsData[id].image,
                        height: 60.0,
                        width: 60.0,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(8.0),
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/ts_blue.png'),
                        ),
                      ),
                    ),
              title: Text(
                newsData[id].title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  newsData[id].url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
