import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoader(
    {@required double height, @required double width, bool circle = false}) {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    baseColor: Color(0xffeeeeee),
    highlightColor: Color(0xfff5f5f5),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: circle ? BoxShape.circle : BoxShape.rectangle),
    ),
  );
}

Widget networkImageLoader(
        {@required String url,
        @required double height,
        @required double width,
        bool circle = false}) =>
    CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: circle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
        ),
        height: height,
        width: width,
      ),
      placeholder: (context, url) =>
          shimmerLoader(height: height - 1, width: width - 1, circle: circle),
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              shape: circle ? BoxShape.circle : BoxShape.rectangle),
          height: height - 1,
          width: width - 1,
          child: Icon(Icons.error)),
    );
