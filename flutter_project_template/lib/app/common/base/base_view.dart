import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/app/common/style/theme.dart';
import 'package:get/get.dart';

import '../style/app_colors.dart';

abstract class BaseView<Controller extends GetxController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  PreferredSizeWidget? appBar(BuildContext context);

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          annotatedRegion(context),
          Container(),
        ],
      ),
      onTap: () {
        // 全局点击背景收起键盘
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
    );
  }

  Widget annotatedRegion(BuildContext context) {
    // return AnnotatedRegion(
    //   value: SystemUiOverlayStyle(
    //     //Status bar color for android
    //     statusBarColor: statusBarColor(),
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: pageScaffold(context),
    //   ),
    // );

    return pageScaffold(context);
  }

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      //sets ios status bar color
      // backgroundColor: pageBackgroundColor(),
      key: globalKey,
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      body: pageContent(context),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: drawer(),
    );
  }

  Widget pageContent(BuildContext context) {
    return SafeArea(
      child: body(context),
    );
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container();
  }

  Color pageBackgroundColor() {
    return Get.theme.scaffoldBackgroundColor;
  }

  // Color statusBarColor() {
  //   return getTheme().barco;
  // }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }
}
