import 'package:flutter/material.dart';
import 'package:shrimpapp/components/loading_screen.dart';
import 'package:shrimpapp/controllers/sensor_controller.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../components/paragraph.dart';
import '../models/Sensor.dart';

class EnvironmentPage extends StatefulWidget {
  List<Sensor> sensors;
  @override
  _EnvironmentPageState createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  List<Sensor> sensors;
  dynamic salinity;
  @override
  Widget build(BuildContext context) {
    if (widget.sensors == null) {
      SensorController().fetchNew().then((data) {
        widget.sensors = data;
        setState(() {
          sensors = data;
          salinity = sensors
              .firstWhere((sensor) => sensor.type == SensorType.Salinity);
        });
      });
    }

    if (sensors == null) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Môi trường'),
        actions: <Widget>[
          IconButton(
            // child: Text(
            //   'Tải lại',
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Colors.white,
            //   ),
            // ),
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Text(
            'Ngày ${salinity.createdAt.day} tháng ${salinity.createdAt.month}',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 82, 170, 165),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _salinityBuild(sensors
                .firstWhere((sensor) => sensor.type == SensorType.Salinity)),
          ),
          _bottomBuild(sensors
              .firstWhere((sensor) => sensor.type == SensorType.Salinity))
        ],
      ),
    );
  }

  Widget _salinityBuild(Sensor sensor) {
    double _value = sensor.value;

    /// from `0` to `255`
    int colorWeight = ((_value / 100) * 255).toInt();
    return SleekCircularSlider(
      initialValue: sensor.value,
      min: 0.0,
      max: 80.0,
      appearance: CircularSliderAppearance(
        size: 300.0,
        startAngle: 270,
        angleRange: 360.0,
        customWidths: CustomSliderWidths(
          progressBarWidth: 15.0,
          trackWidth: 7.0,
          shadowWidth: 0.0,
        ),
        customColors: CustomSliderColors(
          gradientStartAngle: 270,
          gradientEndAngle: 450,
          shadowColor: Colors.transparent,
          trackColor: Color.fromARGB(255, 82, 170, 165),
          progressBarColors: [
            Colors.yellow[200],
            Colors.red,
          ],
          dotColor: Colors.red,
          shadowMaxOpacity: 0.5,
        ),
        infoProperties: InfoProperties(
          bottomLabelText: sensor.name,
          bottomLabelStyle: TextStyle(
            color: Color.fromARGB(255, 82, 170, 165),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          modifier: (val) {
            return '${val.toStringAsFixed(4)} ${sensor.unit}';
          },
          mainLabelStyle: TextStyle(
            color: Colors.white.withRed(colorWeight),
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  _bottomBuild(Sensor sensor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.black12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // left
            Paragraph(
              title: 'Giờ đo: ',
              items: [
                '${sensor.createdAt.hour} giờ ${sensor.createdAt.minute} phút',
              ],
            ),
            // center
            Paragraph(
              title: 'Giá trị:',
              items: ['${sensor.value} ${sensor.unit}'],
            ),

            // right
            Paragraph(
              title: 'Trạm đo:',
              items: ['${sensor.name}'],
            ),
          ],
        ),
      ),
    );
  }
}
