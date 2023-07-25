import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;

enum Platform {
  phone,
  tablet,
  web,
  desktop,
}

extension PlatformExtansion on Platform {
  String getExplanatoryMessage() => switch (this) {
        Platform.web || Platform.desktop => 'Нажмите на шар',
        Platform.phone => 'Нажмите на шар \nили потрясите телефон',
        Platform.tablet => 'Нажмите на шар \nили потрясите планшет',
      };

  double getTextSize() => switch (this) {
    Platform.web || Platform.desktop => 32,
    Platform.phone => 24,
    Platform.tablet => 32,
  };
}

//todo: detect Desktop
Platform detectPlatform() {
  if (kIsWeb) {
    return Platform.web;
  }
  final double devicePixelRatio = ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
  final ui.Size size = ui.PlatformDispatcher.instance.views.first.physicalSize;
  final double width = size.width;
  final double height = size.height;

  if ((devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) ||
      (devicePixelRatio == 2 && (width >= 1920 || height >= 1920))) {
    return Platform.tablet;
  }
  return Platform.phone;
}
