import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shrimpapp/models/News.dart';
import 'package:url_launcher/url_launcher.dart';

final List<News> newsData = [
  News.fromJson({
    "_id": "5e018ac8b80e8c02c8b7ef92",
    "title": "Hàn Quốc và Philippines ký Biên bản ghi nhớ về Hợp tác thủy sản",
    "url":
        "https://tongcucthuysan.gov.vn/vi-vn/tin-tức/-nghề-cá-thế-giới/doc-tin/014124/2019-12-23/han-quoc-va-philippines-ky-bien-ban-ghi-nho-ve-hop-tac-thuy-san",
    "image": "/portals/0/hq-phi.jpg",
    "createdAt": "2019-12-24T03:49:28.665Z",
    "updatedAt": "2019-12-24T03:49:28.665Z",
    "__v": 0
  }),
  News.fromJson({
    "_id": "5e0181ac7666471674d01d42",
    "title": "EU áp dụng lại thẻ vàng cho ngành thủy sản Panama",
    "url":
        "https://tongcucthuysan.gov.vn/vi-vn/tin-tức/-nghề-cá-thế-giới/doc-tin/014129/2019-12-23/eu-ap-dung-lai-the-vang-cho-nganh-thuy-san-panama",
    "image": "/portals/0/panama.jpg",
    "createdAt": "2019-12-24T03:10:36.624Z",
    "updatedAt": "2019-12-24T03:10:36.624Z",
    "__v": 0
  })
];

class NewsPage extends StatelessWidget {
  static const newsRoute = 'newsRoute';
  @override
  Widget build(BuildContext context) {
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
