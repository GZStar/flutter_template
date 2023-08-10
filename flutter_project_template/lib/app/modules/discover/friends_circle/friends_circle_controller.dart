import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/utils/screen_utils.dart';

class FriendsCircleController extends GetxController {
  var dataArr = [].obs;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  @override
  void dispose() {
    super.dispose();
  }

  void loadData() async {
    // 获取微信运动排行榜数据
    final jsonStr =
        await rootBundle.loadString('assets/data/wx_friends_circle.json');

    Map dic = json.decode(jsonStr);
    List tempDataArr = dic['data'];
    dataArr.value = tempDataArr;
  }
}
