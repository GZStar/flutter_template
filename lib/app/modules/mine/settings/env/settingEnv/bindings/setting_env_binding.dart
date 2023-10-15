import 'package:get/get.dart';

import '../controllers/setting_env_controller.dart';

class SettingEnvBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingEnvController>(
      () => SettingEnvController(),
    );
  }
}
