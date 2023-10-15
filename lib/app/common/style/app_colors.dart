// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  // App 主题颜色
  // static const Color appMain = Color(0xFF4688FA);
  // static const Color appMainDark = Color(0xFF3F7AE0);
  static const Color appMain = Color(0xFF38686A);
  static const Color appMainDark = Color(0xFF12686A);
  // 背景色
  static const Color background = Color(0xfff1f1f1);
  static const Color backgroundDark = Color(0xFF18191A);

  // material 背景色
  static const Color materialBackground = Color(0xFFFFFFFF);
  static const Color materialBackgroundDark = Color(0xFF303233);

  static const Color container = Colors.white;
  static const Color containerDark = Color(0xff303233);

  // Text常规颜色
  static const Color text = Color(0xFF333333);
  static const Color textDark = Color(0xFFB8B8B8);

  // Text灰色gray文字
  static const Color textGray = Color(0xFF999999);
  static const Color textGrayDark = Color(0xFF666666);

  // Text灰色C文字
  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  // 淡灰gray 背景色
  static const Color bgGray = Color(0xFFF6F6F6);
  static const Color bgGrayDark = Color(0xFF1F1F1F);

  // 线条颜色
  static const Color line = Color(0xFFEEEEEE);
  static const Color lineDark = Color(0xFF3A3C3D);

  // 红色
  static const Color red = Color(0xFFFF4759);
  static const Color redDark = Color(0xFFE03E4E);

  // Text不可用 文字颜色
  static const Color textDisabled = Color(0xFFD4E2FA);
  static const Color textDisabledDark = Color(0xFFCEDBF2);

  // Button不可用 按钮颜色
  static const Color buttonDisabled = Color(0xFF96BBFA);
  static const Color buttonDisabledDark = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);

  static const Color gradientBlue = Color(0xFF5793FA);
  static const Color shadowblue = Color(0x805793FA);
  static const Color orange = Color(0xFFFF8547);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
