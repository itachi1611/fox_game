import 'package:flutter/material.dart';

class AppScreenSize {
  late double width;
  late double height;
  late double topPadding;
  late double bottomPadding;
  late double devicePixelRatio;
  late double deviceAspectRatio;
  late double viewInsetsBottom;

  AppScreenSize.of(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    width = mq.size.width;
    height = mq.size.height;
    topPadding = mq.padding.top;
    bottomPadding = mq.padding.bottom;
    devicePixelRatio = mq.devicePixelRatio;
    viewInsetsBottom = mq.viewInsets.bottom;
    deviceAspectRatio = height / width;
  }
}
