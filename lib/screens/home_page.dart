import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shrimpapp/components/reusable_card.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/controllers/auth_controller.dart';
import 'package:shrimpapp/controllers/favorite_controller.dart';
import 'package:shrimpapp/controllers/newfeed_controller.dart';
import 'package:shrimpapp/models/NewFeed.dart';
import 'package:shrimpapp/providers/address_provider.dart';
import 'package:shrimpapp/screens/environment_page.dart';
import 'package:shrimpapp/screens/favorite_page.dart';
import 'package:shrimpapp/screens/login_page.dart';
import 'package:shrimpapp/screens/newfeed_page.dart';
import 'package:shrimpapp/screens/news_page.dart';
import 'package:shrimpapp/screens/register_page.dart';
import 'package:shrimpapp/screens/weather.dart';
import 'package:shrimpapp/utils/image_to_buffer.dart';
import 'package:shrimpapp/widgets/login_alert.dart';
import 'package:shrimpapp/widgets/audio_player.dart';
import 'package:shrimpapp/screens/price_page.dart';

class MyApp extends StatefulWidget {
  static const String route = '/myapp';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  handle(NewFeed feed, List<Asset> images) async {
    List<String> bufferResults = await ImageToBuffer.fromAssets(images);

    feed.images = bufferResults;
    feed.newFeedLocation = await AddressProvider().getCurrentLocation();
    try {
      final loginAccount =
          Provider.of<AuthController>(context, listen: false).owner;
      final newFeedController =
          Provider.of<NewFeedController>(context, listen: false);
      await newFeedController.createNewFeed(feed, loginAccount.token);
      _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Bài viết mới đã được đăng'),
            backgroundColor: Colors.lightGreen,
          ),
        );
      Provider.of<FavoriteController>(context, listen: false)
          .fetchAnnouce(loginAccount.id);
    } catch (err) {
      print('ERROR: $err');
      try {
        _scaffoldKey.currentState
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Đăng bài thất bại.'),
              backgroundColor: Colors.red.shade400,
            ),
          );
      } catch (er) {
        print("Show snackbar error!!\n$er");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _widgets = [
      WeatherWidget(),
      HomePage(handle: handle),
      FavoritePage(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: _widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            title: Text('Thời tiết'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Trang chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            title: Text('Quan tâm'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 2) {
            if (Provider.of<AuthController>(context, listen: false).owner ==
                null) {
              LoginAlert(context: context, title: 'Đăng nhập').alert.show();
            } else {
              Provider.of<FavoriteController>(context, listen: false).clear();
              setState(() {
                _currentIndex = 2;
              });
            }
          } else
            setState(() {
              _currentIndex = index;
            });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  static const route = '/home';
  final Function handle;

  HomePage({Key key, this.handle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: PlayerWidget('$kServerUrl/audio'),
          ),
          SizedBox(height: 8.0),
          Expanded(
//            height: MediaQuery.of(context).size.height - 180,
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                constraints: BoxConstraints(
                  minHeight: 350,
                  maxHeight: 350,
                  minWidth: 350,
                  maxWidth: double.infinity,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                          child: Text("RegisterPage"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterPage(),
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: RaisedButton(
                          child: Text("LoginPage"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          Expanded(
                            child: ReusableCard(
                              colour: kLightColor,
                              cardChild: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(Icons.school),
                                  Text(
                                    'Hỏi đáp',
                                    style: Theme.of(context).textTheme.display1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              onPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewFeedPage(handle: handle),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ReusableCard(
                              colour: kLightColor,
                              cardChild: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.leaf),
                                  Text(
                                    'Môi trường',
                                    style: Theme.of(context).textTheme.display1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              onPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EnvironmentPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 8.0),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 8.0),
                          Expanded(
                            child: ReusableCard(
                              colour: kLightColor,
                              cardChild: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.coins),
                                  Text(
                                    'Giá cả',
                                    style: Theme.of(context).textTheme.display1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              onPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => PricePage()),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ReusableCard(
                              colour: kLightColor,
                              cardChild: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.newspaper),
                                  Text(
                                    'Tin tức',
                                    style: Theme.of(context).textTheme.display1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              onPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => NewsPage()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
