import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import '../values/app_values.dart';

class ScreenUtils {
  // 系统方法获取
  static double get screenWidth {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  static double get screenHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  static double get scale {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.devicePixelRatio;
  }

  static double get textScaleFactor {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.textScaleFactor;
  }

  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + AppValues.appBarbarHeight;
  }

  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }
}
