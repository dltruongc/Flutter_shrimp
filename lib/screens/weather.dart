import 'package:flutter/material.dart';
import 'package:shrimpapp/models/Weather.dart';

final Weather weather = Weather({
  "coord": {"lon": -0.13, "lat": 51.51},
  "weather": [
    {
      "id": 300,
      "main": "Drizzle",
      "description": "light intensity drizzle",
      "icon": "09d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 280.32,
    "pressure": 1012,
    "humidity": 81,
    "temp_min": 279.15,
    "temp_max": 281.15
  },
  "visibility": 10000,
  "wind": {"speed": 4.1, "deg": 80},
  "clouds": {"all": 90},
  "dt": 1485789600,
  "sys": {
    "type": 1,
    "id": 5091,
    "message": 0.0103,
    "country": "GB",
    "sunrise": 1485762037,
    "sunset": 1485794875
  },
  "id": 2643743,
  "name": "London",
  "cod": 200
});

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

class WeatherWidget extends StatelessWidget {
  static const path = '/weather';
  @override
  Widget build(BuildContext context) {
    return Container(
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
              itemCount: 10,
              itemBuilder: (context, id) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Text(
                        _weekDay[weather.date.weekday],
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
                            weather.date.hour.toString() + ' giờ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${weather.temperature.celsius.toStringAsFixed(1)}\u2070C',
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
