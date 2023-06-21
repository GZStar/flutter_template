import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/values/storage_key.dart';
import '../../../../data/local/store/storage_service.dart';

class EnvSettingController extends GetxController {
  List<String> envs = ['dev', 'test', 'uat', 'prod'];

  var selectIndex = 3.obs;
  var oldIndex = 3.obs;

  @override
  void onInit() {
    super.onInit();

    getDefaultSelectIndex();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void getDefaultSelectIndex() {
    String server = StorageService.to.getString(StorageKeys.localEnvironment);
    var index = envs.indexWhere((element) {
      return element == server;
    });
    if (index < 0) return;
    selectIndex.value = index;
    oldIndex.value = index;
  }

  void selectTheme(int index) {
    selectIndex.value = index;
  }

  void onCancelButtonClick() {
    if (selectIndex != oldIndex) {
      Get.defaultDialog(
        middleText: "您有修改操作，是否保存最新配置？",
        textCancel: '不保存',
        textConfirm: '保存',
        onConfirm: () {
          saveEnvAction();
        },
        onCancel: () {
          Get.back();
        },
      );
    } else {
      Get.back();
    }
  }

  void onSaveButtonClick() {
    if (selectIndex != oldIndex) {
      saveEnvAction();
    } else {
      Get.back();
    }
  }

  void saveEnvAction() {
    Get.defaultDialog(
      middleText: "保存环境配置需要您退出APP并重新打开应用！",
      textCancel: '取消',
      textConfirm: '保存',
      onConfirm: () {
        StorageService.to
            .setString(StorageKeys.localEnvironment, envs[selectIndex.value]);
        exit(0);
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
