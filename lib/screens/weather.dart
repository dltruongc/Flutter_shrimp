import 'package:flutter/material.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/secret.dart';
import 'package:weather/weather.dart';

List _weekDay = [
  'NO DATA',
  'Thứ 2',
  'Thứ 3',
  'Thứ 4',
  'Thứ 5',
  'Thứ 6',
  'Thứ 7',
  'Chủ nhật',
];

class WeatherWidget extends StatefulWidget {
  WeatherStation weatherStation;
  List<Weather> weathers;
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather weather;

  @override
  Widget build(BuildContext context) {
    // setState(() {
    if (widget.weathers == null)
      WeatherStation(SecretKeys.weather).fiveDayForecast().then((data) {
        setState(() {
          print("GERGERGREWRGWEWDEGDSEGSEFSGEFSEFS");
          widget.weathers = data;
          weather = data[0];
        });
      });
    else
      setState(() {
        weather = widget.weathers[0];
      });
    // });
    if (widget.weathers == null) {
      return LoadingScreen(
        isBackground: true,
      );
    }

    return AnimatedContainer(
      duration: Duration(seconds: 3),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/weather_wall.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // WEATHER TITLE
          Text(
            weather.areaName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          Text(
            '${weather.temperature.celsius.round()}\u2070C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.w300,
              letterSpacing: -3,
            ),
          ),
          Text(
            weather.weatherDescription,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            'Độ ẩm: ${weather.humidity}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  text: 'Cao nhất:',
                  children: [
                    TextSpan(
                      text:
                          '\n${weather.tempMax.celsius.toStringAsFixed(1)}\u2070C',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  text: 'Thấp nhất:',
                  children: [
                    TextSpan(
                      text:
                          '\n${weather.tempMin.celsius.toStringAsFixed(1)}\u2070C',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // WEATHER BODY
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: widget.weathers.length,
              itemBuilder: (context, id) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        _weekDay[widget.weathers[id].date.weekday],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                          ),
                          Text(
                            widget.weathers[id].date.hour.toString() + ' giờ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${widget.weathers[id].temperature.celsius.toStringAsFixed(1)}\u2070C',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white54,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
