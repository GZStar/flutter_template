import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/app_colors.dart';

import 'text_styles.dart';

ThemeData getAppTheme({bool isDarkMode = false}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: isDarkMode ? AppColors.appMainDark : AppColors.appMain,
      secondary: isDarkMode ? AppColors.appMainDark : AppColors.appMain,
      error: isDarkMode ? AppColors.redDark : AppColors.red,
      primaryContainer:
          isDarkMode ? AppColors.containerDark : AppColors.container,
    ),
    // Tab指示器颜色
    indicatorColor: isDarkMode ? AppColors.appMainDark : AppColors.appMain,
    // 页面背景色
    scaffoldBackgroundColor:
        isDarkMode ? AppColors.backgroundDark : AppColors.background,
    // 主要用于Material背景色
    canvasColor: isDarkMode ? AppColors.materialBackgroundDark : Colors.white,
    // 文字选择色（输入框选择文字等）
    // textSelectionColor: Colours.app_main.withAlpha(70),
    // textSelectionHandleColor: Colours.app_main,
    // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.appMain.withAlpha(70),
      selectionHandleColor: AppColors.appMain,
      cursorColor: AppColors.appMain,
    ),
    textTheme: TextTheme(
      // TextField输入文字颜色
      titleMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
      // Text文字样式
      bodyMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
      titleSmall:
          isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      // color: isDarkMode ? AppColors.background : AppColors.backgroundDark,
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.light,
      centerTitle: true,
      backgroundColor:
          isDarkMode ? AppColors.backgroundDark : AppColors.appMain,
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.background : Colors.white,
      ),
      titleTextStyle: isDarkMode
          ? TextStyles.appBarTitleTextDark
          : TextStyles.appBarTitleText,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: isDarkMode ? AppColors.textDark : AppColors.text,
    ),
    dividerTheme: DividerThemeData(
        color: isDarkMode ? AppColors.lineDark : AppColors.line,
        space: 0.6,
        thickness: 0.6),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    ),
    // pageTransitionsTheme: NoTransitionsOnWeb(),
    visualDensity: VisualDensity
        .standard, // https://github.com/flutter/flutter/issues/77142
  );
}
