import 'package:get/get.dart';

import '../controllers/setting_proxy_controller.dart';

class SettingProxyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingProxyController>(
      () => SettingProxyController(),
    );
  }
}
