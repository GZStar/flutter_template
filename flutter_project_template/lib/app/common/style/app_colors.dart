import 'package:flutter/material.dart';

abstract class AppColors {
  // App 主题色
  static const Color primaryColor = Color(0xFFE6262C);

  static const Color pageBackground = Color(0xFFFAFBFD);
  static const Color appBarColor = Color(0xFF38686A);
  static const Color appBarIconColor = Color(0xFFFFFFFF);
  static const Color appBarTextColor = Color(0xFFFFFFFF);

  // 标题颜色
  static const Color titleColor = Color(0xFF171921);
  // 重要文字颜色
  static const Color iwordsColor = Color(0xFF3C3C3C);
  // 常规文字颜色
  static const Color nwordsColor = Color(0xFF61666D);
  // 次要文字颜色
  static const Color swordsColor = Color(0xFF999999);
  // 提示文字颜色
  static const Color tipsColor = Color(0xFFB7B7B7);
  // 边框颜色 三种
  static const Color borderColor1 = Color(0xFFEBEBEB);
  static const Color borderColor2 = Color(0xFFE4E4E4);
  static const Color borderColor3 = Color(0xFFE4E4E4);
  static const Color separateLine = Color(0xFFF0F0F0);
  // 边框背景色
  static const Color borderBackgroundColor = Color(0xFFF5F6F9);
  // 辅色-绿色
  static const Color greenColor = Color(0xFF0EC02F);
  // 辅色-橘色
  static const Color orangeColor = Color(0xFFFFA53F);
  // 辅色-橘色
  static const Color orangeColors = Color(0xFFF63A40);
  // 辅色-黄色
  static const Color yellow = Color(0xFFFDF2D0);
  // 辅色-蓝色
  static const Color blueColor = Color(0xFF5E83FF);
  // 辅色-淡红色背景
  static const Color redBgColor = Color(0x0DE6262C);

  // 绿色-箭头
  static const Color greenColors = Color(0xFF1DC11D);
  // 背景色
  static const Color backgroundColor = Color(0xFFf3f4f5);
  // 首页背景色
  static const Color homeBackgroundColor = Color(0xFFEAEAEA);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
