import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/common/style/theme.dart';

import 'package:get/get.dart';

import '../../../common/langs/translation_service.dart';
import '../../../common/values/storage_key.dart';
import 'storage_service.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  Locale locale = const Locale('en', 'US');
  static const fallbackLocale = Locale('zh', 'CN');

  @override
  void onInit() {
    super.onInit();
    onInitLocale();
    onInitTheme();
    isFirstOpen = StorageService.to.getBool(StorageKeys.deviceFirstOpen);
  }

  // 标记用户已打开APP
  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(StorageKeys.deviceFirstOpen, true);
  }

  void onInitLocale() {
    var deviceLocale = Get.deviceLocale;
    var languages = TranslationService.languages;

    var langKey = StorageService.to.getString(StorageKeys.language);
    if (langKey.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.key == langKey;
    });
    if (index < 0) {
      var temp = languages.indexWhere((element) {
        return element.locale.languageCode == deviceLocale?.languageCode;
      });
      if (temp < 0) return;
      index = temp;
    }
    Get.updateLocale(languages[index].locale);
    locale = languages[index].locale;
  }

  void onLocaleUpdate(LanguageModel model) {
    Get.updateLocale(model.locale);
    StorageService.to.setString(StorageKeys.language, model.key);
    locale = model.locale;
  }

  void onInitTheme() {
    int value = StorageService.to.getInt(StorageKeys.themeStyle);
    if (value == 1) {
      Get.changeThemeMode(ThemeMode.light);
    } else if (value == 2) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  void onThemeUpdate(int value) {
    StorageService.to.setInt(StorageKeys.themeStyle, value);
  }
}
