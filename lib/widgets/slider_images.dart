import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shrimpapp/utils/FetchImage.dart';

class SliderImages extends StatelessWidget {
  final List<String> images;

  SliderImages({@required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return MyNetworkImage.fromPath(
        path: images[0],
        height: 200.0,
        width: double.infinity,
      );
    }
    return CarouselSlider.builder(
      viewportFraction: 0.9,
      aspectRatio: 1.5,
      autoPlay: false,
      autoPlayAnimationDuration: Duration(milliseconds: 50),
      enlargeCenterPage: true,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex) => Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: MyNetworkImage.fromPath(
            path: images[itemIndex],
          ),
        ),
      ),
      enableInfiniteScroll: false,
    );
  }
}
