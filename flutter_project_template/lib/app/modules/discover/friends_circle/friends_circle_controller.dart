import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/utils/screen_utils.dart';

class FriendsCircleController extends GetxController {
  ScrollController scrollController = ScrollController();

  double imgNormalHeight = 300;
  double imgExtraHeight = 0.0;
  var imgChangeHeight = 0.0.obs;
  double scrollMinOffSet = 0.0;
  double navH = 0.0;
  var appbarOpacity = 0.0.obs;

  var dataArr = [].obs;

  @override
  void onInit() {
    super.onInit();
    navH = ScreenUtils.navigationBarHeight;
    imgChangeHeight.value = imgNormalHeight + imgExtraHeight;
    scrollMinOffSet = imgNormalHeight - navH;
    addScrollListener();

    loadData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr =
        await rootBundle.loadString('assets/data/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List tempDataArr = dic['data'];
    // dataArr.forEach((item) {
    // });
    dataArr.value = tempDataArr;
  }

  // 滚动监听
  void addScrollListener() {
    scrollController.addListener(() {
      double _y = scrollController.offset;
      // print('滑动距离: $_y');

      if (_y < scrollMinOffSet) {
        imgExtraHeight = -_y;
//        print(_topH);
        imgChangeHeight.value = imgNormalHeight + imgExtraHeight;
      } else {
        imgChangeHeight.value = navH;
      }

      // appbar 透明度
      double appBarOpacity = _y / navH;
      if (appBarOpacity < 0) {
        // 透明
        appBarOpacity = 0.0;
      } else if (appBarOpacity > 1) {
        // 不透明
        appBarOpacity = 1.0;
      }

      // 更新透明度
      appbarOpacity.value = appBarOpacity;
    });
  }
}
