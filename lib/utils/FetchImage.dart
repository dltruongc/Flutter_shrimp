import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shrimpapp/components/not_found.dart';
import 'package:shrimpapp/utils/ServerAddress.dart';

class MyNetworkImage {
  static CachedNetworkImage fromPath(
      {@required path,
      String errorMessage = 'Không tải được!',
      height = 150.0,
      width = double.infinity}) {
    return CachedNetworkImage(
      errorWidget: (context, url, err) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade200,
        child: NotFoundWidget(errorMessage),
      ),
      placeholder: (context, url) => LoadingBouncingGrid.square(),
      imageUrl: ServerAddress.getUrl(path: path),
      height: height,
    );
  }

  static CachedNetworkImage fromURL(
      {@required String url,
      String errorMessage = 'Không tải được!',
      height = 150.0,
      width = double.infinity}) {
    return CachedNetworkImage(
      errorWidget: (context, url, err) => Container(
        width: height,
        height: width,
        color: Colors.grey.shade200,
        child: NotFoundWidget(errorMessage),
      ),
      placeholder: (context, url) => LoadingBouncingGrid.square(),
      imageUrl: url,
      height: height,
    );
  }
}
