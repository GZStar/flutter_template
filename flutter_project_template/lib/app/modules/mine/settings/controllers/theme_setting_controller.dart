import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/utils/loading.dart';
import '../../../../common/values/storage_key.dart';
import '../../../../data/local/store/config_store.dart';
import '../../../../data/local/store/storage_service.dart';

class ThemeSettingController extends GetxController {
  List<ThemeModel> themes = [
    ThemeModel(key: 0, name: '主题跟随系统'),
    ThemeModel(key: 1, name: '白天模式'),
    ThemeModel(key: 2, name: '黑夜模式'),
  ];

  var selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getSelectIndex();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void selectTheme(int index) async {
    if (index == 1 && selectIndex.value != 1) {
      Get.changeThemeMode(ThemeMode.light);
    } else if (index == 2 && selectIndex.value != 2) {
      Get.changeThemeMode(ThemeMode.dark);
    } else if (index == 0 && selectIndex.value != 0) {
      Get.changeThemeMode(ThemeMode.system);
    }

    if (index != selectIndex.value) {
      ConfigStore.to.onThemeUpdate(themes[index].key);
      selectIndex.value = themes[index].key;

      Loading.show();
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.forceAppUpdate();
        Loading.dismiss();
      });
    }
  }

  void getSelectIndex() {
    var value = StorageService.to.getInt(StorageKeys.themeStyle);
    selectIndex.value = value;
  }
}

class ThemeModel {
  late int key;
  late String name;

  ThemeModel({
    required this.key,
    required this.name,
  });
}
