import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../common/values/storage_key.dart';
import '../../../../../../data/local/store/storage_service.dart';

class SettingProxyController extends GetxController {
  //TODO: Implement SettingProxyController

  final localHostTextController = TextEditingController();
  final portTextController = TextEditingController();

  var proxy = '';

  @override
  void onInit() {
    super.onInit();

    String localHost = StorageService.to.getString(StorageKeys.proxyLocalHost);
    String port = StorageService.to.getString(StorageKeys.proxyPort);

    String temp = localHost != '' ? '$localHost:$port' : '无';
    proxy = '当前设置的代理：$temp';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onCancelButtonClick() {
    var localHost = localHostTextController.value.text;
    var port = portTextController.value.text;

    if (localHost.isNotEmpty && port.isNotEmpty) {
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
    var localHost = localHostTextController.value.text;
    var port = portTextController.value.text;

    if (localHost.isNotEmpty && port.isNotEmpty) {
      saveEnvAction();
    } else {
      Get.back();
    }
  }

  void saveEnvAction() {
    Get.defaultDialog(
      middleText: "保存代理配置需要您退出APP并重新打开应用！",
      textCancel: '取消',
      textConfirm: '保存',
      onConfirm: () {
        var localHost = localHostTextController.value.text;
        var port = portTextController.value.text;

        StorageService.to.setString(StorageKeys.proxyLocalHost, localHost);
        StorageService.to.setString(StorageKeys.proxyPort, port);
        exit(0);
      },
      onCancel: () {},
    );
  }

  void onCleanButtonClick() {
    Get.defaultDialog(
      middleText: "清空代理配置需要您退出APP并重新打开应用！",
      textCancel: '取消',
      textConfirm: '清空',
      onConfirm: () {
        StorageService.to.setString(StorageKeys.proxyLocalHost, '');
        StorageService.to.setString(StorageKeys.proxyPort, '');
        exit(0);
      },
      onCancel: () {},
    );
  }
}
