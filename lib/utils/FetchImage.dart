import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shrimpapp/components/not_found.dart';
import 'package:shrimpapp/utils/ServerAddress.dart';

import '../constants.dart';

class MyNetworkImage {
  static CachedNetworkImage fromPath({
    @required String path,
    String errorMessage = 'Không tải được!',
    num height = 200.0,
    num width = double.infinity,
    BoxFit fit = BoxFit.cover,
  }) {
    String url;

    if (path.startsWith("/")) {
      url = ServerAddress.getUrl(path: path);
    } else {
      url = path;
    }
    return CachedNetworkImage(
      errorWidget: (context, url, err) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: NotFoundWidget(errorMessage),
      ),
      placeholder: (context, url) => LoadingFadingLine.circle(
        backgroundColor: kLightColor,
        borderColor: kLightColor,
      ),
      imageUrl: url,
      width: double.infinity,
      fit: fit,
      height: height,
    );
  }
}
