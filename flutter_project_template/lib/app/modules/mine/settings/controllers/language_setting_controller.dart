import 'package:flutter_project_template/app/data/local/store/config_store.dart';
import 'package:get/get.dart';

import '../../../../common/langs/translation_service.dart';

class LanguageSettingController extends GetxController {
  var languages = TranslationService.languages;
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

  void selectLanguage(int index) {
    var model = languages[index];
    ConfigStore.to.onLocaleUpdate(model);
    getSelectIndex();
  }

  void getSelectIndex() {
    var locale = Get.locale;
    var index = languages.indexWhere((element) {
      return element.locale == locale;
    });
    if (index < 0) return;
    selectIndex.value = index;
  }
}
