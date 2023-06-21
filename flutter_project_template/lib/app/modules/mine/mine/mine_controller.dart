import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/data/local/store/user_store.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';

class MineController extends GetxController {
  UserLoginResponseModel userProfile = UserStore.to.profile;

  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);
  var topH = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    addScrollListener();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void addScrollListener() {
    scrollController.addListener(() {
      double y = scrollController.offset;
      if (y < 0 && y > -1000) {
        topH.value = y.abs();
      }
    });
  }
}
