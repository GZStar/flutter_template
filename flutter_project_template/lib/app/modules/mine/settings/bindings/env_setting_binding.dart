import 'package:get/get.dart';

import '../controllers/env_setting_controller.dart';

class EnvSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnvSettingController>(() => EnvSettingController());
  }
}
