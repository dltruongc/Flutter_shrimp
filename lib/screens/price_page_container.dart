import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/screens/price_page.dart';
import 'package:shrimpapp/screens/price_page_added.dart';
import 'package:shrimpapp/screens/price_page_added.dart';

class PricePageContainer extends StatefulWidget {
  @override
  _PricePageContainerState createState() => _PricePageContainerState();
}

class _PricePageContainerState extends State<PricePageContainer> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Giá cả'),
          bottom: TabBar(
            indicatorColor: kDeepColor,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.white54,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.business_center),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text('Đại lí'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person_pin),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text('Quản lý'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PricePageAdded(),
            PricePage(),
          ],
        ),
      ),
    );
  }
}
