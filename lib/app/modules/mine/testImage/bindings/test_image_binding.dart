import 'package:get/get.dart';

import '../controllers/test_image_controller.dart';

class TestImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestImageController>(
      () => TestImageController(),
    );
  }
}
