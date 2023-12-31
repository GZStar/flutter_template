import 'package:get/get.dart';

import '../controllers/theme_setting_controller.dart';

class ThemeSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeSettingController>(() => ThemeSettingController());
  }
}
