import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_colors.dart';
import '../style/text_styles.dart';
import '../values/app_values.dart';

class CommonWidget {
  static AppBar appBar(String appBarTitleText,
      {bool isBackButtonEnabled = true,
      List<Widget>? actions,
      SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.light}) {
    return AppBar(
      toolbarHeight: AppValues.appBarbarHeight,
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
      automaticallyImplyLeading: isBackButtonEnabled,
      actions: actions,
      systemOverlayStyle: systemOverlayStyle,
      // iconTheme: const IconThemeData(color: AppColors.appBarIconColor),
      title: Text(
        appBarTitleText,
        style: pageTitleStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static void toast(String error) async {
    await Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xFF2D2D2D),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
