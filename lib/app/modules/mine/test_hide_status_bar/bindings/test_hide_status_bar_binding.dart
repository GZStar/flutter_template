import 'package:get/get.dart';

import '../controllers/test_hide_status_bar_controller.dart';

class TestHideStatusBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestHideStatusBarController>(
      () => TestHideStatusBarController(),
    );
  }
}
