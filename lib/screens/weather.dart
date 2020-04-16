import 'package:flutter/material.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/secret.dart';
import 'package:shrimpapp/utils/weather_sub.dart';
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
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  WeatherStation weatherStation;
  List<Weather> weathers;
  Weather weather;

  @override
  Widget build(BuildContext context) {
    // setState(() {
    if (weathers == null)
      WeatherStation(SecretKeys.weather).fiveDayForecast().then((data) {
        setState(() {
          weathers = data;
          weather = data[0];
        });
      });
    else
      setState(() {
        weather = weathers[0];
      });
    // });
    if (weathers == null) {
      return LoadingScreen(
        isBackground: true,
      );
    }
    print(weather.weatherDescription);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Thời tiết'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: AnimatedContainer(
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
                'Gần ' + weather.areaName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${weather.temperature.celsius.round()}\u2070C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 42,
                      width: 42,
                      child: Image.asset(
                          'images/weathers/${weather.weatherIcon}@2x.png')),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    WeatherVietsub.word(weather.weatherDescription) ?? WeatherVietsub.iconCode(weather.weatherIcon),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      text: 'Cao nhất:',
                      children: [
                        TextSpan(
                          text:
                              '\n${weather.tempMax.celsius.toStringAsFixed(1)}\u2070C',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      text: 'Độ ẩm:',
                      children: [
                        TextSpan(
                          text: '\n${weather.humidity}',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      text: 'Thấp nhất:',
                      children: [
                        TextSpan(
                          text:
                              '\n${weather.tempMin.celsius.toStringAsFixed(1)}\u2070C',
                          style: TextStyle(color: Colors.white, fontSize: 22),
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
                  itemCount: weathers.length,
                  itemBuilder: (context, id) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            _weekDay[weathers[id].date.weekday],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                weathers[id].date.hour.toString() + ' giờ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                height: 32,
                                width: 32,
                                child: Image.asset(
                                  'images/weathers/${weathers[id].weatherIcon}@2x.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '${weathers[id].temperature.celsius.toStringAsFixed(1)}\u2070C',
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
        ),
      ),
    );
  }
}
